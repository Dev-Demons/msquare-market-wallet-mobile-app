import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/style.dart';

class IdentificationSelectionWidget extends StatelessWidget {
  const IdentificationSelectionWidget(
      {Key? key,
      required this.title,
      required this.asset,
      required this.subtitle,
      this.onTap})
      : super(key: key);

  final String title;
  final String subtitle;
  final String asset;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: onTap,
        shape: commonRoundedRectangularBorder(),
        tileColor: Colors.white,
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        minVerticalPadding: 0,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        title: Text(
          title,
          style: poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100),
        ),
        subtitle: Text(
          subtitle,
          style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: AppColor.primaryColor0,
          child: SvgPicture.asset('assets/svg_icons/$asset.svg'),
        ),
      ),
    );
  }
}
