import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/dialogues/dialogue_single_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/style.dart';
import '../../screens/wallet/successfuly_connected.dart';
import '../password_snackbar.dart';

/// A [StatefulWidget] that displays a generic Dialog for Password Validation.
class PasswordValidationDialogue extends StatefulWidget {
  /// A [Constructor] that accepts a variable of model
  const PasswordValidationDialogue({Key? key, required this.model})
      : super(key: key);

  /// Variable to store model
  final model;
  @override
  State<PasswordValidationDialogue> createState() =>
      _PasswordValidationDialogueState();
}

class _PasswordValidationDialogueState
    extends State<PasswordValidationDialogue> {
  /// [Boolean] flag to check password verification
  bool passwordVerified = false;

  /// [Boolean] flag to check text obscureness
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        titlePadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
        actionsPadding: EdgeInsets.fromLTRB(20, 32, 20, 24),
        // Enter Password Label
        title: Text(
          "enter_pass".tr,
          textAlign: TextAlign.center,
          style: interTextStyle(16, FontWeight.w600, greyColor100),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextInputField(
              borderColor: widget.model.borderRed ? dangerColor10 : greyColor30,
              controller: widget.model.passwordData.passwordController,
              isObscure: isObscure,
              hintText: "pass".tr,
              keyboard: TextInputType.text,
              // Text Visibility On and Off
              suffixIcon: isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              suffixOnTap: () {
                isObscure = !isObscure;
                setState(() {});
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 8)),
            // Remaining Attempts Label
            Text(
              "${widget.model.passwordData.totalAttempts.toString()} " +
                  "attempts_remaining".tr,
              style: interTextStyle(14, FontWeight.w500, successColor30),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          DialogSingleMaterialButton(
            buttonTitle: "ok".tr,
            onPressed: () async {
              setState(() {
                passwordVerified = true;
              });
              // perform Transaction function
              var response =
                  await widget.model.performTransactionWithPassword();
              Get.back();
              if (response.containsKey("reroute")) {
                Get.to(() =>
                    SuccessFullyConnectedWallet(status: response["reroute"]));
              } else if (response["color"] == dangerColor10) {
                showPasswordSnackBar(
                    response["msg"].toString().tr, response["color"]);
              } else {
                Get.back();
                showPasswordSnackBar(
                  response["msg"].toString().tr,
                  response["color"],
                );
              }

              setState(() {
                passwordVerified = false;
              });
            },
            passwordVerified: passwordVerified,
          )
        ],
      );
    });
  }
}
