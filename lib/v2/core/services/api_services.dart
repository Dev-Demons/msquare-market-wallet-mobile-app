import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:msquare_market/v2/core/constants/api_endpoints.dart';
import 'package:msquare_market/v2/core/enums/token_type.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/components/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../locator.dart';
import '../models/connections.dart';
import '../models/history.dart';
import '../models/scan_data.dart';

class ApiServices {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  ///
  ///
  /// This is the function to fetching User
  ///
  ///
  /// TODO:: Add a return type of User here, and incase of failure throw error instead of returning false
  ///
  Future fetchUser() async {
    try {
      final locateUser = locator<AuthServices>();
      var token = await locateUser.getUserToken();
      print("1. Fetch User data");
      final response = await http.get(
        Uri.parse("${EndPoints.fetchUser}"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      } else if (response.statusCode == 404) {
        print(
            "Error@Fetchinguser====>${response.statusCode}, ${response.body}");
        return false;
        // throw "404 Could not fetch user";
      } else if (response.statusCode == 502) {
        print("Error@Fetchinguser====>${response.statusCode}");
        print(response.body);
        // return false;
        throw "502, Server Down";
      }
    } catch (e) {
      throw e;
    }
  }

  ///fetch walletAddress
  fetchWalletAddress(String email) async {
    final response = await http.get(
      Uri.parse("${EndPoints.fetchUser}?email=$email"),
    );
    if (response.statusCode == 200) {
      Map jsonResponse = json.decode(response.body)['user'];
      Map wallet = jsonResponse['wallet'];
      String walletAddress = wallet['address'];
      return walletAddress;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  ///SignUp
  Future signUp(String name, String email) async {
    final locateUser = locator<AuthServices>();
    var token = await locateUser.getUserToken();
    print("Step 04: SignUp Endpoint Called");

    ///Body of uri
    try {
      Map data = {
        "name": name,
        "email": email,
      };
      final response = await http.post(
        Uri.parse("${EndPoints.signUp}"),
        body: json.encode(data),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "$token",
        },
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);

        return response.statusCode;
      } else if (response.statusCode == 400) {
        debugPrint("User already exist");
        throw "User already exisit";
      } else {
        // SnackBars.errorSnackBar(
        //     'Exception inside else', "${response.statusCode}");
        print(response.body);
        throw "${response.body}";
        // throw Exception('Failed to load api');
      }
    } on Exception catch (e) {
      // SnackBars.errorSnackBar('Exception Try Catch ', e);

      print(e);
      throw e;
    }
  }

  ///Create username and password
  Future createUserName(String username, String password, String email) async {
    print("Step 05: Create username /user_creds Has been Called");
    Map data = {
      "username": username,
      "password": password,
      "user": email,
    };
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      final response = await http.post(Uri.parse("${EndPoints.userCredential}"),
          body: json.encode(data), headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "${response.body}";
      }
    } catch (e) {
      throw "$e";
    }
  }

  ///Validate Uer with Password
  Future<bool> validateUser(String email, String password) async {
    bool status = false;
    // print(
    //   "Step 05: Create username /user_creds Has been Called================================================================>>>" +
    //       email.toString(),
    // );

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final encodePassword = Uri.encodeComponent("$password");
    final parsedUri = Uri.parse(
        "${EndPoints.validateUser}?user=$email&plainPassword=$encodePassword");
    final response = await http.get(
      parsedUri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Get.back();

      print("response print: ");
      debugPrint(response.body);

      final body = json.decode(response.body);

      Map<String, dynamic> myJoson = body;
      print(myJoson['msg']);
      status = myJoson['status'];

      return status;
    } else {
      if (status == false) {
        SnackBars.errorSnackBar('Incorrect', 'Password or ');

        return false;
      }
      print("else is running.....");
      debugPrint(response.body);

      return false;
    }
  }

  Future addExternalProject(ScanData scanData, email, String token) async {
    print("Adding extenal project using QR Code");
    print(email);
    print(scanData.keyId);
    print(scanData.platform);
    try {
      Map data = {
        "keyId": scanData.keyId,
        "email": email,
        "platform": scanData.platform,
      };

      http.Response response = await http.post(
        Uri.parse("${EndPoints.baseUrl}/wallet/establish_connection"),
        body: json.encode(data),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "$token",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Wallet has been added");
        return true;
      } else {
        if (response.statusCode == 400) {
          return false;
        }
        print(
          "somethingWentWrong@addingexternalProject==> ${response.statusCode}\n ${response.body}",
        );
      }
    } catch (e) {
      print("error@addingExternalProject===> $e");
      return false;
    }
  }

  ///Fetch all Order Data
  Future getAllOrders() async {
    final response = await http.get(Uri.parse('${EndPoints.getAllOrders}'));
    if (response.statusCode == 200) {
      print("status code 200");
      List jsonResponse = json.decode(response.body)['data'];

      return jsonResponse;
    } else if (response.statusCode == 500) {
      throw Exception('500, Inernal Server Error');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future getHistory({String? lastPageId, int? createdAt, int? count}) async {
    String uri = "";
    if (lastPageId == null && count == null) {
      uri = "${EndPoints.getHistory}";
    } else if (lastPageId == null && count != null) {
      uri = "${EndPoints.getHistory}?limit=$count";
    } else if (lastPageId != null && count == null) {
      uri = "${EndPoints.getHistory}?lastId=$lastPageId&createdAt=$createdAt";
    } else {
      uri = "${EndPoints.getHistory}?lastId=$lastPageId&createdAt=$createdAt";
    }
    // log("Url = $uri");
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
      final jsonResponse = json.decode(response.body);
      // log(jsonResponse.toString());
      return HistoryResponse.fromJson(jsonResponse);
    } else if (response.statusCode == 404) {
      // final jsonResponse = json.decode(response.body);
      throw "user history not found";
    } else if (response.statusCode == 500) {
      throw Exception('500, ${response.body}');
    } else {
      // print("${response.statusCode} ${response.body}");
      throw Exception('Unexpected error occured!');
    }
  }

  Future<bool> buySellOrder(
      {final email, final currency, final amount, final isBuy}) async {
    final locateUser = locator<AuthServices>();
    var token = await locateUser.getUserToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map body = {
      // "email": email,
      "currency": currency,
      "amount": int.parse(amount),
      "isBuy": isBuy,
    };

    final http.Response response = await http.post(
      Uri.parse("https://api.dev.msq.market/p2p-orders/buySellOrders"),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);

      return true;
    } else {
      print(response.statusCode);
      throw Exception('Unexpected error occured!');
    }
  }

  Future completedOrders(
      {final orderId, final email, final currency, final amount}) async {
    final locateUser = locator<AuthServices>();
    var token = await locateUser.getUserToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map body = {
      "order_id": orderId,
    };
    final response = await http.post(
      Uri.parse("${EndPoints.ordersCompleted}"),
      headers: headers,
      body: jsonEncode(body),
    );
    print("Completed Order: ");
    print(orderId);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return response.body;
    }
  }

  ///Verify credentials
  verifyCredential(String username, String password) async {
    debugPrint(
        "https://api.dev.msq.market/validate_user_creds?username=$username&plainPassword=$password");

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(
        Uri.parse(
            "https://api.dev.msq.market/validate_user_creds?username=$username&plainPassword=$password"),
        headers: headers);
    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString());

      return response.statusCode;
    } else {
      debugPrint(response.body);
      return response.statusCode;
    }
  }

  Future fetchAllUserWallets(String email, String token) async {
    print("email :" + email);
    print("Fetching extenal project");
    try {
      var response = await http.get(
        Uri.parse(
            "${EndPoints.baseUrl}/wallet/wallet_connections?email=$email"),
        // headers: headers,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "$token",
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {}
  }

  Future<bool> removeUserWallet(Connections connection, String email) async {
    try {
      Map data = {
        "keyId": connection.keyId,
        "email": email,
      };

      http.Response response = await http.put(
        Uri.parse("${EndPoints.baseUrl}wallet/disconnect_connection"),
        body: json.encode(data),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        if (response.statusCode == 400 || response.statusCode == 400) {}
        print(
          "somethingWentWrong@addingexternalProject==> ${response.statusCode}\n ${response.body}",
        );
        return false;
      }
    } catch (e) {
      return false;
    }
  }

///// How to get a new token everywhere.

  Future getTransactionRequestAPi(String requestKey) async {
    final locateUser = locator<AuthServices>();
    print("get transaction api is calling...");
    print(requestKey.toString());

    var token = await locateUser.getUserToken();
    print("Fetch User data");
    final response = await http.get(
      Uri.parse("${EndPoints.getTransaction}?request_key=$requestKey"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "$token",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Status Code = ${response.statusCode}");

      return response.body;
    } else if (response.statusCode == 404) {
      print(
          "Success@getTransactionAPI====>${response.statusCode}, ${response.body}");
      return false;
    } else {
      print("Error@Fetchinguser====>${response.statusCode}");
      print(response.body);
      return false;
    }
  }

  ///Added ........................
  ///Get prices API
  Future getPricesAPi() async {
    final locateUser = locator<AuthServices>();

    var token = await locateUser.getUserToken();
    final response = await http.get(
      Uri.parse("${EndPoints.getPrices}"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      print("Success@getPriceAPI====>${response.statusCode}, ${response.body}");
      return false;
    } else {
      //print("Error@Fetchingprices====>${response.statusCode}");
      return {
        "tokens": {
          "MSQ": {"name": "MSQ", "price": -1}
        }
      };
    }
  }

  Future<dynamic> sendTransactionApi({
    final requestKey,
  }) async {
    log("send transaction api called");
    final locateUser = locator<AuthServices>();

    var token = await locateUser.getUserToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "$token",
      'Authorization': 'Bearer $token',
    };
    Map body = {
      "request_key": requestKey,
    };
    final http.Response response = await http.post(
      Uri.parse("${EndPoints.sendTransaction}"),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("trasaction successfully");
      return null;
      // return jsonDecode(response.body);
    } else {
      log("Response Code: ${response.statusCode.toString()}");
      log("Response Body: ${response.body.toString()}");
      return jsonDecode(response.body);
    }
  }

  swapCoin({
    required String amount,
    required TokenType from,
    TokenType? to,
  }) async {
    final locateUser = locator<AuthServices>();
    var token = await locateUser.getUserToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "$token",
      'Authorization': 'Bearer $token',
    };
    Map body = {
      "amount": amount,
      "email": locateUser.firebaseUser!.email,
    };
    String url = "";
    if (from == TokenType.MSQ) {
      url = EndPoints.msqToMsqp;
    }
    if (from == TokenType.MSQP) {
      url = EndPoints.msqpToMsq;
    }
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    print("Coverting $amount $from");
    print(response.body);
    print(response.statusCode);
  }

  ///
  /// Refresh RPA Balance
  ///
  Future<bool> refreshBalanceRPA() async {
    final locateUser = locator<AuthServices>();
    var token = await locateUser.getUserToken();
    // final url =
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "$token",
      'Authorization': 'Bearer $token',
    };
    try {
      final http.Response response = await http.get(
        Uri.parse(EndPoints.refreshBalanceRPA),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
        throw "Error: ${response.reasonPhrase!}";
      }
    } catch (e) {
      throw "Unexpected Error occured: $e";
    }
  }
}
