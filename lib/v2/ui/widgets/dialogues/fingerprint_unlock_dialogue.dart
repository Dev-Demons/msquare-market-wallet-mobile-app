import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/ui/widgets/dialogues/dialogue_single_button.dart';
import 'package:msquare_market/v2/ui/widgets/dialogues/password_validation_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';
import '../../../core/constants/style.dart';
import '../../../core/services/local_auth.dart';
import '../../screens/wallet/successfuly_connected.dart';
import '../divider_widget.dart';
import '../password_snackbar.dart';

/// A [View] that displays a generic dialog for Fingerprint Authentication
/// irrespective of on which screen it has been called.

class FingerprintUnlockDialogue extends StatelessWidget {
  /// [Constructor] that accepts a model and returns generic dialog.
  FingerprintUnlockDialogue({Key? key, required this.model}) : super(key: key);

  /// Variable that holds model.
  var model;

  /// [BioMetricAuthenticationServices] variable that handles biometric authentications
  /// for [User].
  BioMetricAuthenticationServices bioMetricServices =
      locator<BioMetricAuthenticationServices>();

  /// A [boolean] flag that handles whether transaction is done or not.
  bool transactionDone = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        titlePadding: EdgeInsets.fromLTRB(20, 24, 20, 8),
        actionsPadding: EdgeInsets.fromLTRB(20, 16, 20, 24),
        // Unlock Wallet label
        title: Text(
          "unlock_wallet".tr,
          textAlign: TextAlign.center,
          style: poppinsTextStyle(16, FontWeight.w500, greyColor100),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scan Finger To Connect Label
            Text(
              "scan_finger_to_connect".tr,
              textAlign: TextAlign.center,
              style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
            ),
            IconButton(
              iconSize: 50,
              onPressed: () async {
                var response = await model.performTransactionWithFingerprint();
                if (response.containsKey("reroute")) {
                  model.controller!.dispose();
                  Get.back();
                  Get.to(() =>
                      SuccessFullyConnectedWallet(status: response["reroute"]));
                }
                showCustomSnackBar("fingerprint_authentication",
                    response["msg"], response["color"]);
              },
              icon: model.loader
                  ? CircularProgressIndicator()
                  : Icon(
                      Icons.fingerprint,
                      size: 50,
                      color: primaryColor70,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 20),
              // Scan Finger label
              child: Text(
                "scan_finger".tr,
                style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: DividerWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or".tr,
                    style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
                  ),
                ),
                Expanded(
                  child: DividerWidget(),
                ),
              ],
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          DialogSingleMaterialButton(
            onPressed: () {
              Get.back();
              showDialog(
                context: context,
                builder: (context) => PasswordValidationDialogue(model: model),
              );
            },
            passwordVerified: false,
            buttonTitle: "use_password".tr,
          ),
        ],
      ),
    );
  }
}
