import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/constants/api_endpoints.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/core/models/super_save/transaction_register_model.dart';
import 'package:msquare_market/v2/core/models/super_save/withdrawal_model.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';

class SuperSaveAPIService {
  fetchDashboardData() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.superSaveDashboard);
    var response = await http.get(uri, headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['retRes']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  sendRequest({required SuperSaveRequestModel requestModel}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({
      "payment_period": requestModel.paymentPeriod,
      "payment_rate": requestModel.paymentRate,
      "payment_method": requestModel.paymentMethod,
      "deposit_amount_in_msq": requestModel.depositAmountInMSQ,
      "deposit_amount_in_won": requestModel.depositAmountInWon,
      "total_payout_amount": requestModel.totalPayoutAmount,
      "daily_payout_amount": requestModel.dailyPayoutAmount,
    });

    var uri = Uri.parse(EndPoints.superSaveRequest);
    var response = await http.post(uri, headers: headers, body: body);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'error': false, "data": data['data']};
    } else {
      return {'error': true, "data": data['result']};
    }
  }

  registerTransaction({required TransactionRegisterModel requestModel}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({
      "name": requestModel.name,
      "birth_date": requestModel.dob,
      "phone_number": requestModel.contact,
      "bank_name": requestModel.bankName,
      "bank_account_number": requestModel.bankAccountNumber,
      "identity_type": requestModel.identityType,
      "nationality": requestModel.nationality,
      "registration_number": requestModel.regNumber,
      "profile_image": requestModel.profileImage,
      "id_image": requestModel.idImage
    });

    var uri = Uri.parse(EndPoints.superSaveTransactionRegistration);
    var response = await http.post(uri, headers: headers, body: body);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'error': false, "data": data['data']};
    } else {
      return {'error': true, "data": data['result']};
    }
  }

  participate({required String reqID, required String txID}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({"request_id": reqID, "transaction_id": txID});
    var uri = Uri.parse(EndPoints.superSaveParticipate);
    var response = await http.post(uri, headers: headers, body: body);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['result']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  uploadImage({required String path}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };

    var uri = Uri.parse(EndPoints.superSaveUploadImage);

    var request = http.MultipartRequest("POST", uri);
    var file = await http.MultipartFile.fromPath("file", path);
    request.headers.addAll(headers);
    request.files.add(file);
    var response = await request.send();
    var responseString = String.fromCharCodes(await response.stream.toBytes());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'error': false, "data": responseString};
    } else {
      return {'error': true, "data": responseString};
    }
  }

  fetchReserveHistory() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.reserveHistory);
    var response = await http.get(uri, headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data};
    } else {
      return {'error': true, "data": data};
    }
  }

  fetchUserBanks() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.userBankAccounts);
    var response = await http.get(uri, headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['userBankAccountsResponse']};
    } else {
      return {'error': true, "data": data};
    }
  }

  setMainBank({required String id}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({"bank_id": id});
    var uri = Uri.parse(EndPoints.setMainBankAccount);
    var response = await http.post(uri, headers: headers, body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['result']};
    } else {
      return {'error': true, "data": data['result']};
    }
  }

  addBank({required String name, required String account}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({"bank_name": name, "bank_account_number": account});
    var uri = Uri.parse(EndPoints.addBank);
    var response = await http.post(uri, headers: headers, body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'error': false, "data": data['result']};
    } else {
      return {'error': true, "data": data['result']};
    }
  }

  withdrawalUser({required WithdrawalModel model}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({
      "reason": model.reason!,
      "description": model.description!,
      "bank_name": model.bankName!,
      "bank_account_number": model.bankAccountNumber!,
      "amount": model.amount!
    });

    var uri = Uri.parse(EndPoints.withdrawalUser);
    var response = await http.post(uri, headers: headers, body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'error': false, "data": data['data']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  deleteBankAccount({required String id}) async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var body = jsonEncode({"bank_id": id});
    var uri = Uri.parse(EndPoints.superSaveDeleteBank);
    var response = await http.delete(uri, headers: headers, body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['result']};
    } else {
      return {'error': true, "data": data['result']};
    }
  }

  ///SuperSave History
  requestHistory() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.superSaveHistory);
    var response = await http.get(uri, headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['superSaveReq']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  ///Participation History
  requestParticipationHistory() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.superSaveParticipationHistory);
    var response = await http.get(uri, headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['data']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  ///Participation Details
  requestParticipationDetails() async {
    var token = await locator<AuthServices>().getUserToken();
    print("Bearer");
    print(token);
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token",
      "request_id": ""
    };
    var uri = Uri.parse(EndPoints.superSaveParticipationDetail);
    var response = await http.get(uri, headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return {'error': false, "data": data};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  fetchUserMainBankAccDetails() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.superSaveUserMainBank);
    var response = await http.get(uri, headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['result']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  fetchCumulativePayment() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.getCumulativeAmount);
    var response = await http.get(uri, headers: headers);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['cumulativeAmount']};
    } else {
      return {'error': true, "data": data['msg']};
    }
  }

  fetchPhoneVerificationToken() async {
    var token = await locator<AuthServices>().getUserToken();
    var headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization": "Bearer $token"
    };
    var uri = Uri.parse(EndPoints.superSaveGeneratePhoneToken);
    var response = await http.get(uri, headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'error': false, "data": data['data']};
    } else {
      return {'error': true, "data": data};
    }
  }
}
