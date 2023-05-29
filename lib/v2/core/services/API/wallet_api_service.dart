import 'dart:convert';
import 'dart:io';
import 'package:msquare_market/v2/ui/screens/fallback_error/fallback_error_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../locator.dart';
import '../../constants/api_endpoints.dart';
import '../../models/scan_data.dart';
import '../auth_services.dart';

class WalletAPIServices {
  /// common headers variable that do not change that much
  final _headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  final locateUser = locator<AuthServices>();
  Uri? _url;
  var _parameters;
  var _response;
  var _token;
  var _body;
  var _localHeaders;
  Future fetchWalletRequestDataAPI({required String requestKey}) async {
    var token = await locateUser.getUserToken();
    final localHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(
        Uri.parse("${EndPoints.getTransaction}?request_key=$requestKey"),
        headers: localHeaders);
    var statusCode = response.statusCode;

    if (statusCode == 200 || statusCode == 201) {
      return response.body;
    } else if (statusCode == 404 || statusCode == 500 || statusCode == 502) {
      return Get.to(() => FallbackErrorScreen(
          error: statusCode, msg: jsonDecode(response.body)["err"]));
    } else {
      return false;
    }
  }

  Future completeRequestAPI({final requestKey}) async {
    locateUser.init();
    var token = await locateUser.getUserToken();
    final localHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "request_key": requestKey,
    });
    final http.Response response = await http.post(
      Uri.parse("${EndPoints.sendTransaction}"),
      headers: localHeaders,
      body: body,
    );
    var statusCode = response.statusCode;
    if (statusCode == 200 || statusCode == 201) {
      return {"error": false};
    } else if (statusCode == 404 || statusCode == 500 || statusCode == 502) {
      return Get.to(() =>
          FallbackErrorScreen(error: statusCode, msg: "error_$statusCode"));
    } else {
      return {"error": true, "msg": jsonDecode(response.body)};
    }
  }

  Future fetchWalletAddress({required String email}) async {
    _parameters = "email=$email";
    _url = Uri.parse("${EndPoints.fetchUser}?$_parameters");
    _response = await http.get(_url!, headers: _headers);
    if (_response.statusCode == 200) {
      Map jsonResponse = jsonDecode(_response.body)['user'];
      Map wallet = jsonResponse['wallet'];
      return wallet['address'];
    } else if (_response.statusCode == 404 ||
        _response.statusCode == 500 ||
        _response.statusCode == 502) {
      Get.to(() => FallbackErrorScreen(
          error: _response.statusCode, msg: 'error_${_response.statusCode}'));
    } else {
      return false;
    }
  }

  Future addExternalProject(
      {required ScanData scanData, required String email}) async {
    _token = locateUser.getUserToken();
    _url = Uri.parse("${EndPoints.establishConnection}");
    _body = jsonEncode({
      "keyId": scanData.keyId,
      "email": email,
      "platform": scanData.platform
    });
    _localHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $_token'
    };
    _response = await http.post(_url!, body: _body, headers: _localHeaders);
    if (_response.statusCode == 200 || _response.statusCode == 201) {
      return true;
    } else if (_response.statusCode == 404 ||
        _response.statusCode == 500 ||
        _response.statusCode == 502) {
      Get.to(() => FallbackErrorScreen(
          error: _response.statusCode, msg: 'error_${_response.statusCode}'));
    } else {
      return false;
    }
  }
}
