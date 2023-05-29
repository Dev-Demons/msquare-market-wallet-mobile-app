import 'package:flutter/material.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/style.dart';

class BulletText extends StatelessWidget {
  const BulletText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle, size: 4, color: AppColor.greyColor50),
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      minLeadingWidth: 0,
      horizontalTitleGap: 12,
      title: Text(
        text,
        style: poppinsTextStyle(14, FontWeight.w400, AppColor.greyColor50),
      ),
    );
  }
}
