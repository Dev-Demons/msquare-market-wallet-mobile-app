import 'package:msquare_market/v2/core/enums/token_type.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/services/API/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';
import '../../../core/constants/colors.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/password_model.dart';
import '../../../core/services/API/transaction_api_service.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/auth_services.dart';
import '../../../core/services/local_auth.dart';
import '../../../core/services/locator_services/password_attempt.dart';

/// A [ViewModel] that handles data interaction between model, services
/// and view.

class SwapProvider extends BaseViewModal {
  /// [Double] variable that holds the value of amount to be converted
  double convertFromAmount = 0.0;

  /// [Double] variable that holds the value of amount converted into
  double convertToAmount = 0.0;

  /// [String] variable that stores the hint for from field
  String? fromHintField;

  /// [String] variable that stores the hint for to field
  String? toHintField;

  /// [Boolean] variable that acts as flag to know if the tokens have been
  /// swapped or not.
  bool reversed = false;

  /// [PasswordModel] variable that handles password attempts data.
  PasswordModel passwordData = PasswordModel();

  /// [String] variable that stores the token we are converting from
  String fromTokenType;

  /// [String] variable that stores the token we are converting to
  String toTokenType;

  bool isAbsorbing = true;

  /// [Boolean] variable that acts as flag to enable the action button
  bool enableNext = false;

  /// [Boolean] variable that acts as flag to check of the user is authenticated
  /// or not.
  bool isAuthenticated = false;

  /// [Boolean] variable that acts as flag to show [CircularProgressIndicator].
  bool loader = false;

  /// [Boolean] variable that acts as flag to show red border in the [TextInputField]
  bool borderRed = false;

  /// [BiometricAuthenticationServices] variable that handles biometric authentications
  BioMetricAuthenticationServices _bioMetricServices =
      locator<BioMetricAuthenticationServices>();

  /// [TransactionAPIServices] variable that transaction processing API
  TransactionAPIServices _transactionAPI = TransactionAPIServices();

  /// [TextEditingController] for convertTo field
  TextEditingController convertToController = TextEditingController();

  /// [TextEditingController] for convertFrom field
  TextEditingController convertFromController = TextEditingController();

  //TODO: New Change to be added once API is made and get a go ahead from project leader
  double? exchangeRate = 2.0;
  double? gasFee = 0.003;
  double? totalGasFee = 0.003;

  /// [Function] to check if biometric services are enabled.
  bool isBioMetricEnabled() {
    return _bioMetricServices.isBioMetricEnabled;
  }

  SwapProvider(this.fromTokenType, this.toTokenType) {
    fromHintField = fromTokenType;
    toHintField = toTokenType;
    fetchNewBalances();
  }

  changeLoading(v) {
    loader = v;
    notifyListeners();
  }

  changeAuthentication(v) {
    isAuthenticated = v;
    notifyListeners();
  }

  setMax() {
    if (reversed) {
      convertFromController.text = convertToAmount.toString();
      convertToController.text = (convertToAmount / 2).toString();
    } else {
      convertFromController.text = convertFromAmount.toString();
      convertToController.text = (convertFromAmount * 2).toString();
    }

    enableNext = true;
    notifyListeners();
  }

  void swapValues() {
    ///swap values
    var temp = convertToController.text.toString();
    convertToController.text = convertFromController.text.toString();
    convertFromController.text = temp;

    ///Swap token name
    var tempHintText = fromHintField;
    fromHintField = toHintField;
    toHintField = tempHintText;
    reversed = !reversed;
    notifyListeners();
  }

  resetValues() {
    convertFromController.text = "";
    convertToController.text = "";
    enableNext = false;
    notifyListeners();
  }

  calculateConversion(bool trig) {
    //in case triggered from first field
    if (trig) {
      if (reversed) {
        convertToController.text =
            (double.parse(convertFromController.text) / exchangeRate!)
                .toString();
      } else {
        convertToController.text =
            (double.parse(convertFromController.text) * exchangeRate!)
                .toString();
      }
    } else {
      if (reversed) {
        convertFromController.text =
            (double.parse(convertToController.text) * exchangeRate!).toString();
      } else {
        convertFromController.text =
            (double.parse(convertToController.text) / exchangeRate!).toString();
      }
    }
    notifyListeners();
  }

  changeNextButton(bool value) {
    enableNext = value;
    notifyListeners();
  }

  final locateUser = locator<AuthServices>();
  final _apiServices = ApiServices();
  fetchNewBalances() async {
    setState(ViewState.busy);
    final userTokens = await UserAPIServices().fetchCurrentUserTokens();
    if (userTokens != false) {
      await locateUser.myAppUser.wallet!.addTokens(userTokens);
    }
    notifyListeners();
    convertFromAmount = locateUser.myAppUser.wallet!.tokens!
        .firstWhere((element) => element.name == fromTokenType)
        .balance!;
    convertToAmount = locateUser.myAppUser.wallet!.tokens!
        .firstWhere((element) => element.name == toTokenType)
        .balance!;
    setState(ViewState.idle);
  }

  // performTransactionWithFingerprint() async {
  //   changeLoading(true);
  //   setState(ViewState.busy);
  //   String msg = "fingerprint_failed";
  //   Color msgColor = dangerColor10;
  //   isAuthenticated = await _bioMetricServices.authenticateUser();
  //   if (isAuthenticated) {
  //     Get.back();
  //     var res = await swapToken();
  //     msg = res["msg"];
  //     msgColor = res["color"];
  //     Get.back();
  //     Get.back();
  //   }
  //   changeLoading(false);
  //   setState(ViewState.idle);
  //   return {"msg": msg, "color": msgColor};
  // }

  Future<bool> validateUser() async {
    return await UserAPIServices().validateUser(
      email: locateUser.myAppUser.email!,
      password: passwordData.passwordController.text,
    );
  }

  Future swapToken() async {
    String msg = "amount_not_swapped";
    Color color = dangerColor10;
    var response = await _transactionAPI.swapToken(
      amount: convertFromController.text,
      tokenType: tokenTypeMapping[fromTokenType],
      plainPassword: passwordData.passwordController.text,
    );
    if (response) {
      msg = "amount_swapped";
      color = successColor30;
    }
    return {"msg": msg, "color": color};
  }

  performTransactionWithPassword() async {
    changeLoading(true);
    var response;
    var passwordAttempts =
        locator<PasswordAttempt>().getPasswordAttemptsData(1);
    if (passwordAttempts[0] == "false") {
      if (passwordData.totalAttempts > 1) {
        bool isAuthenticated = await validateUser();
        borderRed = !isAuthenticated;
        if (isAuthenticated) {
          response = await swapToken();
          passwordData.passwordController.clear();
          passwordData.totalAttempts = 10;
        } else {
          passwordData.reduceAttempts();
          response = {"msg": "wrong_password".tr, "color": dangerColor10};
        }
      } else {
        locator<PasswordAttempt>()
            .setPasswordAttemptsData("swap", true, DateTime.now().toString());
        response = {"msg": "pass_limit_reached".tr, "color": dangerColor10};
      }
    } else {
      passwordData.totalAttempts = 0;
      int diff = DateTime.now()
          .difference(DateTime.parse(passwordAttempts[1]))
          .inMinutes;
      if (diff < 5) {
        response = {
          "msg": "try_again_msg_1".tr + "${5 - diff}" + "try_again_msg_2".tr,
          "color": dangerColor10
        };
      } else {
        passwordData.totalAttempts = 10;
        locator<PasswordAttempt>()
            .setPasswordAttemptsData("swap", false, "null");
        response = {"msg": "Password Limit Reset", "color": successColor30};
      }
    }
    changeLoading(false);
    return response;
  }

  String? convertFromValidator(value) {
    var limit = (reversed ? convertToAmount : convertFromAmount);
    if (value!.isEmpty) {
      return "null_value".tr;
    } else if (double.parse(value) > limit) {
      return "not_enough_balance".tr;
    }
    return null;
  }

  convertFromOnChanged(v) {
    var limit = (reversed ? convertToAmount : convertFromAmount);
    if (convertFromController.text != "") {
      changeNextButton(true);
      calculateConversion(true);
      totalGasFee = (gasFee! * double.parse(v));
      if (double.parse(v) > limit) {
        changeNextButton(false);
      }
    } else {
      changeNextButton(false);
      convertToController.text = "";
    }
  }

  convertToOnChanged(v) {
    if (convertToController.text != "") {
      changeNextButton(true);
      calculateConversion(false);
    } else {
      changeNextButton(false);
      convertToController.text = "";
    }
  }
}
