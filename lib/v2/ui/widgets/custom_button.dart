import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final title;
  final btnColor;
  final textColor;
  final onPressed;
  final isQR;
  final borderColor;
  final double radius;
  CustomMaterialButton(
      {this.title,
      this.btnColor,
      this.textColor,
      this.onPressed,
      this.isQR = false,
      this.borderColor,
      this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor ?? btnColor)),
      minWidth: !isQR ? (MediaQuery.of(context).size.width) : 100,
      onPressed: onPressed,
      textColor: textColor,
      color: btnColor,
      child:
          Text(title, style: poppinsTextStyle(14, FontWeight.w500, textColor)),
    );
  }
}
