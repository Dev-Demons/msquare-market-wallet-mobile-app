import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/ui/screens/settings/success_screen.dart';
import 'package:msquare_market/v2/ui/screens/settings/update_password_provider.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_input_field.dart';

/// A [Screen] that displays Screen to change password. This view accepts:
/// - Current Password
/// - New Password
/// - Confirm New Password
///
/// and passed to Update Password function in [UpdatePasswordProvider] where, updatePassword
/// API is called after password validation
class UpdatePasswordScreen extends StatefulWidget {
  /// Default [Constructor]
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Set UpdatePasswordProvider as ViewModel
      create: (context) => UpdatePasswordProvider(),
      child: Consumer<UpdatePasswordProvider>(
        builder: (context, model, child) {
          return Scaffold(
            // Change Password Label for AppBar title
            appBar: customAppBar(
              "change_password".tr,
              backArrow: true,
              isBottomBorder: true,
              center: true,
              backArrowFunction: () {
                // clear the stored resources for better space usage.
                model.clear();
                Get.back();
              },
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 20,
                  // Lock Icon
                  leading: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  horizontalTitleGap: 12,
                  // Change Password First Message
                  title: Text(
                    "confirm_change_password_1".tr,
                    style: poppinsTextStyle(16, FontWeight.w500, greyColor100),
                  ),
                  // Change Password Second Message
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "confirm_change_password_2".tr,
                      style: poppinsTextStyle(16, FontWeight.w500, greyColor50),
                    ),
                  ),
                ),
                // TextInputInputField for Current Password
                CustomTextInputField(
                  keyboard: TextInputType.text,
                  hintText: "current_password".tr,
                  isObscure: model.isObscure!,
                  controller: model.currentPasswordController,
                  onChanged: (value) {},
                  suffixIcon: model.isObscure!
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  suffixOnTap: () {
                    model.showHidePassword();
                  },
                ),
                // TextInputInputField for New Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: CustomTextInputField(
                    keyboard: TextInputType.text,
                    hintText: "new_password".tr,
                    isObscure: model.isObscure!,
                    controller: model.newPasswordController,
                    borderColor: model.borderRed! ? dangerColor10 : greyColor30,
                    onChanged: (value) {},
                    suffixIcon: model.isObscure!
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    suffixOnTap: () {
                      model.showHidePassword();
                    },
                  ),
                ),
                // TextInputInputField for New Password Confirmation
                CustomTextInputField(
                  keyboard: TextInputType.text,
                  hintText: "confirm_new_password".tr,
                  isObscure: model.isObscure!,
                  borderColor: model.borderRed! ? dangerColor10 : greyColor30,
                  controller: model.confirmPasswordController,
                  onChanged: (value) {
                    if (model.newPasswordController!.text == value) {
                      model.enableButton = true;
                      model.borderRed = false;
                    } else {
                      model.enableButton = false;
                      model.borderRed = true;
                    }
                    setState(() {});
                  },
                  suffixIcon: model.isObscure!
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  suffixOnTap: () {
                    model.showHidePassword();
                  },
                ),
              ],
            ),
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // Change Password Button
            floatingActionButton: model.state == ViewState.busy
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomMaterialButton(
                      onPressed: () async {
                        if (model.enableButton!) {
                          var response = await model.updatePassword();
                          if (response["color"] == successColor30) {
                            Get.to(() => SuccessScreen());
                          } else {
                            showCustomSnackBar("change_password".tr,
                                response["msg"], response["color"]);
                          }
                        } else {
                          showCustomSnackBar("change_password".tr,
                              "np_cp_not_match".tr, dangerColor10);
                        }
                      },
                      btnColor:
                          model.enableButton! ? primaryColor70 : greyColor20,
                      textColor: Colors.white,
                      title: "update_password".tr,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
