import 'package:flutter/material.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/style.dart';

class CommonContainerForParticipationDashboard extends StatelessWidget {
  const CommonContainerForParticipationDashboard(
      {Key? key, required this.title})
      : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.greyColor20)),
      child: Center(
        child: Text(
          title,
          style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor30),
        ),
      ),
    );
  }
}
