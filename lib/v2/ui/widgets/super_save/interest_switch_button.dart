import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/borders.dart';
import '../../../core/constants/style.dart';

class InterestSwitchButton extends StatelessWidget {
  const InterestSwitchButton(
      {Key? key, required this.title, this.onPressed, required this.selected})
      : super(key: key);

  final String title;
  final onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
          onPressed: onPressed,
          shape: commonRoundedRectangularBorder(hasColor: false),
          padding: EdgeInsets.all(12),
          elevation: 0,
          visualDensity: VisualDensity(horizontal: -4),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: poppinsTextStyle(12, FontWeight.w500,
                selected ? Colors.white : AppColor.greyColor50),
          ),
          color: selected ? AppColor.primaryColor100 : AppColor.greyColor10),
    );
  }
}
