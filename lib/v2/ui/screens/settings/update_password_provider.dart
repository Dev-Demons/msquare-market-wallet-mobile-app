import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../locator.dart';
import '../../../core/services/API/user_api_service.dart';
import '../../../core/services/auth_services.dart';

/// A [Class] that acts as [ViewModel] for our [View] which in here is [UpdatePasswordScreen]

class UpdatePasswordProvider extends BaseViewModal {
  /// [UserAPIServices] object that handles API Services related to [User].
  UserAPIServices? _userAPIService;

  /// [TextEditingController] for current password [TextInputField]
  TextEditingController? currentPasswordController;

  /// [TextEditingController] for new password [TextInputField]
  TextEditingController? newPasswordController;

  /// [TextEditingController] for confirm password [TextInputField]
  TextEditingController? confirmPasswordController;

  /// [Boolean] flag that handles whether to show text input in [TextInputFields]
  /// or not.
  bool? isObscure;

  /// [AuthServices] object that handles local and firebase services
  final locateUser = locator<AuthServices>();
  bool? enableButton;
  bool? borderRed;
  UpdatePasswordProvider() {
    setState(ViewState.busy);
    isObscure = true;
    enableButton = false;
    borderRed = false;
    _userAPIService = UserAPIServices();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    setState(ViewState.idle);
  }
  clear() {
    _userAPIService = null;
    currentPasswordController = null;
    newPasswordController = null;
    confirmPasswordController = null;
    enableButton = false;
  }

  showHidePassword() {
    isObscure = !isObscure!;
    notifyListeners();
  }

  updatePassword() async {
    setState(ViewState.busy);
    var returnResponse;
    var response = await _userAPIService?.validateUser(
      email: locateUser.firebaseUser!.email!,
      password: currentPasswordController!.text,
    );
    if (response) {
      var result = await _userAPIService?.updatePassword(
          currentPassword: currentPasswordController!.text,
          newPassword: newPasswordController!.text);
      if (result) {
        returnResponse = {
          "msg": "pass_change_success".tr,
          "color": successColor30
        };
      } else {
        returnResponse = {"msg": "pass_change_fail".tr, "color": dangerColor10};
      }
    } else {
      returnResponse = {"msg": "invalid_password".tr, "color": dangerColor10};
    }
    setState(ViewState.idle);
    return returnResponse;
  }
}
