import 'dart:convert';
import 'dart:io';
import 'package:msquare_market/v2/core/enums/token_type.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../../locator.dart';
import '../../../ui/screens/fallback_error/fallback_error_screen.dart';
import '../../constants/api_endpoints.dart';
import '../../models/history.dart';
import '../auth_services.dart';

class TransactionAPIServices {
  /// common headers variable that do not change that much
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  final locateUser = locator<AuthServices>();
  String? url;
  Future swapToken({
    required String amount,
    required TokenType tokenType,
    required String plainPassword,
  }) async {
    locateUser.init();
    var token = await locateUser.getUserToken();
    final localHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token'
    };
    final body = jsonEncode({
      "amount": amount,
      "email": locateUser.firebaseUser!.email,
      "plainPassword": plainPassword,
    });
    if (tokenType == TokenType.MSQ) url = EndPoints.msqToMsqp;
    if (tokenType == TokenType.MSQP) url = EndPoints.msqpToMsq;
    if (tokenType == TokenType.MSQX) url = EndPoints.msqxToMsqxp;
    if (tokenType == TokenType.MSQXP) url = EndPoints.msqxpToMsqx;
    final response =
        await http.post(Uri.parse(url!), body: body, headers: localHeaders);
    var statusCode = response.statusCode;
    if (statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchTransactionHistory({String? lastPageId, int? count}) async {
    String uri = "";
    if (lastPageId == null && count == null) {
      uri = "${EndPoints.getHistory}";
    } else if (lastPageId == null && count != null) {
      uri = "${EndPoints.getHistory}?limit=$count";
    } else if (lastPageId != null && count == null) {
      uri = "${EndPoints.getHistory}?lastId=$lastPageId";
    } else {
      uri = "${EndPoints.getHistory}?lastId=$lastPageId";
    }
    final locateUser = locator<AuthServices>();
    var token = await locateUser.getUserToken();
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 500 || response.statusCode == 502) {
      return Get.to(() => FallbackErrorScreen(
          error: response.statusCode, msg: jsonDecode(response.body)["err"]));
    } else {
      print("${response.statusCode} ${response.body}");
      return false;
    }
  }
}
