import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/borders.dart';
import '../../../core/constants/style.dart';

class StakeInfoTile extends StatelessWidget {
  const StakeInfoTile(
      {Key? key, required this.title, required this.subtitle, this.onPressed})
      : super(key: key);
  final String title;
  final String subtitle;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: commonRoundedRectangularBorder(),
      child: ListTile(
        tileColor: Colors.white,
        dense: true,
        onTap: onPressed,
        minVerticalPadding: 0,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: commonRoundedRectangularBorder(),
        title: Text(
          title,
          style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
        ),
        subtitle: Text(
          subtitle,
          style: poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100),
        ),
      ),
    );
  }
}
