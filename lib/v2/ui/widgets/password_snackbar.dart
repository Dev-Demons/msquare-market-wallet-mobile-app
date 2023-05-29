import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
/*
* This file contains only snack-bar for the whole application.
* Following things are kept to mind:
* - Get.closeAllSnackbars() - clears all the snack-bar if any open
* - Get.snackbar() - shows the snack-bar.
* */

/// [Function] that shows success and failure [SnackBar] for Password
/// Authentication. This function aceepts:
/// - [message] of type [String]
/// - [textColor] of type [Color]
void showPasswordSnackBar(String message, Color textColor) {
  Get.closeAllSnackbars();
  Get.snackbar(
    // Snack Bar title
    "pass_verify".tr,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: textColor,
    borderRadius: 0,
    margin: EdgeInsets.zero,
  );
}

/// [Function] that shows custom [SnackBar] for any kind of message. This function aceepts:
/// - [title] of type [String]
/// - [textColor] of type [Color]
/// - [duration] of type [Duration]
void showCustomSnackBar(String title, String message, Color textColor,
    {Duration duration = const Duration(seconds: 3)}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title.tr,
    message.tr,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: textColor,
    borderRadius: 0,
    margin: EdgeInsets.zero,
    duration: duration, //default is 3 secs
  );
}

// if it throws an error call it like this, inside a binding function
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//      showPersistentSnackBar();
//      });
//
/// [Function] that shows persistent Snack bar for beta testers and
/// internal developers to know which environment we are working on. So,
/// that if any issue arises, we should know which environment to check.
void showPersistentSnackBar(
  String title,
  String message,
) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message.tr,
      icon: Icon(
        Icons.lightbulb_rounded,
        color: Colors.yellow,
      ),
      backgroundColor: greyColor100,
      // duration: Duration(seconds: 2),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: 8,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    ),
  );
}

/// [Function] that shows a [SnackBar] for internet connection. It accepts:
/// - [isOnline] - [boolean] flag to lets us know if we have stable connection
///
/// and returns the corresponding snackbar.
void showInternetConnectionSnackBar({required bool isOnline}) {
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      icon: Icon(
        isOnline ? Icons.wifi : Icons.wifi_off_rounded,
        color: isOnline ? successColor30 : dangerColor10,
      ),
      message: isOnline ? "internet_restored".tr : "no_internet_connection".tr,
      // backgroundColor: isOnline ? successColor30 : greyColor100,
      duration: Duration(seconds: 2),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    ),
  );
}
