import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/models/super_save/dashboard_model.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/services/API/super_save_api_service.dart';

class SuperSaveParticipateProvider extends BaseViewModal {
  final SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  TextEditingController txController = TextEditingController();
  bool isEnabled = false;
  bool isBottomSheetEnabled = false;
  bool hasError = false;
  TextEditingController agreementController = TextEditingController();
  TextEditingController msqController = TextEditingController();
  TextEditingController wonController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  SuperSaveParticipateProvider({required PossibleParticipation args}) {
    msqController.text =
        args.totalAmountInMSQ!.toString().replaceAll('MSQ', '');
    wonController.text = args.totalAmountInWon!.toString().replaceAll('원', '');
    bankController.text = "하나둘은행 1101******1234";
  }

  changeEnabled(v) {
    isEnabled = v;
    notifyListeners();
  }

  changeBottomSheetEnabled(v) {
    isBottomSheetEnabled = v;
    notifyListeners();
  }

  txOnChanged(String? v) {
    changeBottomSheetEnabled(v!.isNotEmpty);
  }

  sendParticipationRequest({required String reqID}) async {
    setState(ViewState.busy);
    var response = await _superSaveAPIService.participate(
        reqID: reqID, txID: txController.text);
    setState(ViewState.idle);
    print(response);
    return response;
  }
}
