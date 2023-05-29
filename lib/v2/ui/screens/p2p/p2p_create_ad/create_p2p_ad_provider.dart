import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/models/user_model.dart';

import '../../../../../locator.dart';
import '../../../../core/constants/static_values.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/models/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/API/order_api_service.dart';
import '../../../../core/services/auth_services.dart';

/// [VideModel] that provides and processes data for our [View] which here
/// is [P2PCreateAdScreen]
class P2PCreateAdProvider extends BaseViewModal {
  /// [String] to store current transaction type
  String? currentType;

  /// [String] to store current token
  String? currentToken;

  /// [String] to store currency to be exhanged in
  String? askCurrency;

  /// [String] to store demand amount
  String? amount;

  /// [String] to store ask price
  String? askPrice;

  /// [TextEditingController] to handle amount [TextInput]
  TextEditingController? amountController;

  /// [TextEditingController] to handle price [TextInput]
  TextEditingController? priceController;

  /// [OrderAPIService] that handles [OrderAPI]s
  OrderAPIService _orderAPI = OrderAPIService();

  /// [AuthServices] variable to user [AuthenticationServices] for the [User].
  var _auth = locator<AuthServices>();

  /// [Token] list that stores the tokens info of the current user
  List<Token> tokenPrices = [];

  /// A [boolean] flag that is used to check if we can proceed with transaction.
  bool isEnabled = false;

  /// Main Constructor
  P2PCreateAdProvider() {
    currentType = transactionType[0];
    currentToken = tokens[0];
    askCurrency = "P2UP";
    amount = "0";
    askPrice = "0";
    isEnabled = false;
    amountController = TextEditingController();
    priceController = TextEditingController();
    _auth = locator<AuthServices>();
    //TODO:check this change
    //The issue is that tokens logic has been changed and we need to
    // change multiple things
    tokenPrices = _auth.myAppUser.wallet!.tokens!;
  }

  /// [Function] that currently swaps tokens on token change.
  tokenSelectionOnChange(String? value) {
    askCurrency = currentToken;
    currentToken = value;
    notifyListeners();
  }

  /// [Function[ that handles the transaction type when it is changed
  listingTypeSelectionOnChange(String? value) {
    currentType = value;
    notifyListeners();
  }

  /// [Function] that handles the amount value when it is changed
  amountValueOnChange(String value) {
    if (value.length != 0) {
      isEnabled = true;
      amount = value;
      notifyListeners();
    }
  }

  /// [Function] that handles the ask price when it is changed
  askPriceValueOnChange(String value) {
    if (value.length != 0) {
      isEnabled = true;
      askPrice = value;
      notifyListeners();
    }
  }

  /// [Function] that clears every thing once called
  clear() {
    currentType = transactionType[0];
    currentToken = tokens[0];
    askCurrency = "P2UP";
    amount = "0";
    askPrice = "0";
    isEnabled = false;
    amountController!.clear();
    priceController!.clear();
    notifyListeners();
  }

  /// [Function] that creates P2P Ad
  createP2PAd() async {
    if (isEnabled) {
      setState(ViewState.busy);
      String msg = "your_order_has_been_placed";
      Color color = successColor30;
      var response = await createP2PValidations();
      if (response["msg"] == "true") {
        try {
          var result = await _orderAPI.buyAndSellOrder(
              currency: currentToken!,
              amount: double.parse(amount!),
              isBuy: currentType == "Buy",
              askCurrency: askCurrency!,
              askPrice: double.parse(askPrice!));
          if (result) {
            msg = "your_order_has_been_placed";
            color = successColor30;
            clear();
          } else {
            msg = "order_not_placed";
            color = dangerColor10;
          }
        } catch (e) {
          print(e);
        }
      } else {
        setState(ViewState.idle);
        return response;
      }
      setState(ViewState.idle);
      return {"msg": msg, "color": color};
    } else {
      return {"msg": "resolve_errors", "color": dangerColor10};
    }
  }

  /// [Function[ that handles:
  /// - [amount] must not be greater than [User]'s balance
  /// - [amount] must not be less than or equal to 0
  String? amountValidation(String? value) {
    String? output;
    isEnabled = true;
    if (value!.length == 0) {
      output = "null_value".tr;
    } else {
      if (RegExp(r'^(\d+(?:[\.])\d+?)$').hasMatch(value) ||
          RegExp(r'^(\d+)$').hasMatch(value)) {
        if (currentType == "Sell") {
          if (double.parse(value) >
              tokenPrices
                  .firstWhere((element) => element.name == askCurrency)
                  .balance!) {
            isEnabled = false;
            output = "not_enough_balance".tr;
          }
        }
      }
    }
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    return output;
  }

  /// [Function[ that handles:
  /// - [askPrice] must not be greater than [User]'s balance
  /// - [askPrice] must not be less than or equal to 0
  String? priceValidation(String? value) {
    String? output;
    isEnabled = true;
    if (value!.length == 0) {
      output = "null_value".tr;
    } else {
      if (RegExp(r'^(\d+(?:[\.])\d+?)$').hasMatch(value) ||
          RegExp(r'^(\d+)$').hasMatch(value)) {
        if (currentType == "Buy") {
          if (double.parse(value) >
              tokenPrices
                  .firstWhere((element) => element.name == currentToken)
                  .balance!) {
            isEnabled = false;
            output = "not_enough_balance".tr;
          }
        }
      }
    }
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    return output;
  }

  /// [Function] that handles all the validations necessary for
  /// the Ad Placing to be successful.
  createP2PValidations() async {
    if (double.parse(amount!) == 0) {
      return {
        "msg": "Amount".tr + " " + "null_value".tr,
        "color": dangerColor10
      };
    } else if (double.parse(askPrice!) == 0) {
      return {
        "msg": "Price".tr + " " + "null_value".tr,
        "color": dangerColor10
      };
    } else if (currentType == "Sell") {
      if (double.parse(amount!) >
          tokenPrices
              .firstWhere((element) => element.name == currentToken)
              .balance!) {
        return {
          "msg": "not_enough_${currentToken!.toLowerCase()}",
          "color": dangerColor10
        };
      }
    } else if (currentType == "Buy") {
      if (double.parse(askPrice!) >
          tokenPrices
              .firstWhere((element) => element.name == askCurrency)
              .balance!) {
        return {
          "msg": "not_enough_${askCurrency!.toLowerCase()}",
          "color": dangerColor10
        };
      }
    }
    return {"msg": "true", "color": successColor30};
  }
}
