import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/constants/api_endpoints.dart';
import 'package:msquare_market/v2/core/models/super_save/transaction_register_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/foreign_registration_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/resident_registration_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/services/auth_services.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:get/get.dart';
import '../../../../../locator.dart';

class NiceWebViewProvider extends BaseViewModal {
  Map arguments = {};
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  IO.Socket? socket;
  String? token;
  NiceWebViewProvider(Map args) {
    arguments = args;
    init();
  }
  init() async {
    setState(ViewState.busy);
    print("Initialized");
    await fetchPhoneVerificationToken();
    print("Phone Token : $token");
    socketCheck();
    setState(ViewState.idle);
  }

  fetchPhoneVerificationToken() async {
    var response = await _superSaveAPIService.fetchPhoneVerificationToken();
    token = response['data'];
  }

  socketCheck() {
    socket = IO.io(
        EndPoints.baseUrl,
        OptionBuilder()
            .setQuery({"uuid": locator<AuthServices>().myAppUser.id!})
            .setTransports(['websocket'])
            .enableForceNewConnection() // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket!.onConnect((_) {
      print('connect');
      print(locator<AuthServices>().myAppUser.id!);
    });
    socket!.onError((data) {
      print("Socket Error");
      print(data);
    });
    socket!.on('event', (data) {
      print("Event");
      print(data);
    });
    socket!.on('PHONE_VERIFICATION_SUCCESS', (data) {
      debugPrint("PHONE_VERIFICATION_SUCCESS");
      Map result = data as Map;
      TransactionRegisterModel model = TransactionRegisterModel();
      model.addNameDOBContact(
          result['UTF8_NAME'], result["BIRTHDATE"], result["MOBILE_NO"]);
      socket!.dispose();
      Get.to(
          () => arguments['isKorean']
              ? ResidentRegistrationScreen()
              : ForeignRegistrationScreen(),
          arguments: model);
    });
    socket!.on('PHONE_VERIFICATION_ERROR', (data) {
      print("PHONE_VERIFICATION_ERROR");
      print(data);
    });
    socket!.onDisconnect((_) {
      print('disconnect');
    });
    socket!.on('fromServer', (_) => print(_));
  }

  @override
  void dispose() {
    print("disposed");
    socket!.dispose();
    super.dispose();
  }
}
