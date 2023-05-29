import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/style.dart';

/// A [StatelessWidget] that shows a generic alert dialog

class CustomAlertDialog extends StatelessWidget {
  /// [Constructor] that takes:
  /// - [title] of type [String]
  /// - [message] of type [String]
  /// - [actions] of type [List]
  /// - [align] of type [MainAxisAlignment]
  ///
  /// and returns a Generic Alert Dialog
  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.message,
      required this.actions,
      this.align = MainAxisAlignment.end})
      : super(key: key);

  /// [String] variable to store the alert dialog title
  final String title;

  /// [String] variable to store the alert dialog message
  final String message;

  /// [List] of actions for the alert dialog
  final actions;

  /// [MainAxisAlignment] for the alert dialog
  final MainAxisAlignment align;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alert Dialog Title
          Text(
            title.tr,
            textAlign: TextAlign.center,
            style: poppinsTextStyle(20, FontWeight.w500, greyColor100),
          ),
          SizedBox(
            height: 20,
          ),
          // Alert Dialog Message
          Text(message.tr,
              textAlign: TextAlign.center,
              style: poppinsTextStyle(14, FontWeight.w500, greyColor50)),
        ],
      ),
      // Alert Dialog Alignment
      actionsAlignment: align,
      // Alert Dialog Actions
      actions: actions,
    );
  }
}
