import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';

RoundedRectangleBorder commonRoundedRectangularBorder(
    {bool hasColor = true, double radius = 8}) {
  return hasColor
      ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: AppColor.greyColor20, width: 1))
      : RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}

RoundedRectangleBorder commonMaterialButtonBorder({required Color color}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: color, width: 1));
}

commonPadding(double h, double v) {
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

RoundedRectangleBorder customFABBorder({bool hasColor = true}) {
  return hasColor
      ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: BorderSide(color: AppColor.greyColor20, width: 1))
      : RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
}
