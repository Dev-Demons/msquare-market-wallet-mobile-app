import 'package:flutter/material.dart';
import '../../../core/constants/AppColor.dart';
import '../../../core/constants/borders.dart';
import '../../../core/constants/style.dart';
import 'package:get/get.dart';

class SuperSaveDashboardAlertDialog extends StatelessWidget {
  const SuperSaveDashboardAlertDialog(
      {Key? key, required this.title, this.onPressed})
      : super(key: key);

  final String title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: commonPadding(28, 24),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100),
      ),
      actionsPadding: commonPadding(28, 16),
      actions: [
        MaterialButton(
          onPressed: onPressed ??
              () {
                Get.back();
              },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          minWidth: MediaQuery.of(context).size.width,
          color: AppColor.primaryColor100,
          child: Text(
            "확인",
            style: poppinsTextStyle(14, FontWeight.w600, Colors.white),
          ),
        )
      ],
    );
  }
}
