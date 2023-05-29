import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';

import '../../../../core/constants/functions.dart';

class SuperSaveRequestProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  int selectedIndex = 0;
  TextEditingController amountController = TextEditingController();
  TextEditingController cryptoController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController perDayController = TextEditingController();
  List paymentPeriod = [90, 180, 365];
  List paymentRate = [102, 107, 120];
  bool isEnabled = false;
  bool hasError = false;
  SuperSaveRequestProvider();

  changeEnabled(String amount, String possible) {
    int tempAmount = int.parse(amount.replaceAll(',', ''));
    int possibleToParticipate =
        int.parse(possible.toString().replaceAll(',', '').replaceAll('원', ''));
    isEnabled = (tempAmount >= 1000000 &&
        tempAmount < possibleToParticipate &&
        tempAmount % 1000000 == 0);

    hasError = !isEnabled;
  }

  amountOnChanged(String? v, String possible) {
    if (v!.isNotEmpty) {
      changeEnabled(v, possible);
      cryptoController.text =
          priceString((int.parse(v.replaceAll(',', '')) ~/ 10000).toString());
      interestRateController.text =
          performMultiplyOnStringAndInt(v, paymentRate[selectedIndex] / 100);
      perDayController.text = performDivisionOnStringAndInt(
          interestRateController.text, paymentPeriod[selectedIndex]);
    } else {
      cryptoController.clear();
    }
    notifyListeners();
  }

  oneMillionWonOnPressed(String possible) {
    int amount = 1000000;
    String current =
        amountController.text.isEmpty ? "0" : amountController.text;
    amountController.text =
        (int.parse(current.replaceAll(',', '')) + amount).toString();
    cryptoController.text =
        (int.parse(amountController.text) ~/ 10000).toString();
    amountController.text =
        priceString(amountController.text.replaceAll(',', ''));
    cryptoController.text = priceString(cryptoController.text);
    interestRateController.text = performMultiplyOnStringAndInt(
        amountController.text, paymentRate[selectedIndex] / 100);
    perDayController.text = performDivisionOnStringAndInt(
        interestRateController.text, paymentPeriod[selectedIndex]);
    changeEnabled(amountController.text, possible);
    notifyListeners();
  }

  tenMillionWonOnPressed(String possible) {
    int amount = 10000000;
    String current =
        amountController.text.isEmpty ? "0" : amountController.text;
    amountController.text =
        (int.parse(current.replaceAll(',', '')) + amount).toString();
    cryptoController.text =
        (int.parse(amountController.text) ~/ 10000).toString();
    amountController.text =
        priceString(amountController.text.replaceAll(',', ''));
    cryptoController.text =
        priceString(cryptoController.text.replaceAll(',', ''));
    interestRateController.text = performMultiplyOnStringAndInt(
        amountController.text, paymentRate[selectedIndex] / 100);
    perDayController.text = performDivisionOnStringAndInt(
        interestRateController.text, paymentPeriod[selectedIndex]);
    changeEnabled(amountController.text, possible);
    notifyListeners();
  }

  hundredMillionWonOnPressed(String possible) {
    int amount = 100000000;
    String current =
        amountController.text.isEmpty ? "0" : amountController.text;
    amountController.text =
        (int.parse(current.replaceAll(',', '')) + amount).toString();
    cryptoController.text =
        (int.parse(amountController.text) ~/ 10000).toString();
    amountController.text =
        priceString(amountController.text.replaceAll(',', ''));
    cryptoController.text = priceString(cryptoController.text);
    interestRateController.text = performMultiplyOnStringAndInt(
        amountController.text, paymentRate[selectedIndex] / 100);
    perDayController.text = performDivisionOnStringAndInt(
        interestRateController.text, paymentPeriod[selectedIndex]);

    changeEnabled(amountController.text, possible);
    notifyListeners();
  }

  percent102OnPressed() {
    selectedIndex = 0;
    if (amountController.text.isNotEmpty) {
      interestRateController.text =
          performMultiplyOnStringAndInt(amountController.text, 1.02);
      perDayController.text =
          performDivisionOnStringAndInt(interestRateController.text, 90);
    } else {
      interestRateController.clear();
      perDayController.clear();
    }
    notifyListeners();
  }

  percent107OnPressed() {
    selectedIndex = 1;

    if (amountController.text.isNotEmpty) {
      interestRateController.text =
          performMultiplyOnStringAndInt(amountController.text, 1.07);
      perDayController.text =
          performDivisionOnStringAndInt(interestRateController.text, 180);
    } else {
      interestRateController.clear();
      perDayController.clear();
    }
    notifyListeners();
  }

  percent120OnPressed() {
    selectedIndex = 2;
    if (amountController.text.isNotEmpty) {
      interestRateController.text =
          performMultiplyOnStringAndInt(amountController.text, 1.2);
      perDayController.text =
          performDivisionOnStringAndInt(interestRateController.text, 365);
    } else {
      interestRateController.clear();
      perDayController.clear();
    }
    notifyListeners();
  }

  sendSuperSaveRequest({required SuperSaveRequestModel req}) async {
    setState(ViewState.busy);
    print(req.toJSON());
    var response = await _superSaveAPIService.sendRequest(requestModel: req);
    setState(ViewState.idle);
    print(response);
    return response;
  }
}
