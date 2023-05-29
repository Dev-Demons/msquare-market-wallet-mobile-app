import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/style.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile(
      {Key? key,
      this.text =
          "- 외상매도 결제대금 지급방식은 선택한 외상매도의 결제대금 지급기간 동안 일일 분할지급 되며, 매주 월요일 주간 정산하여 일괄 지급됩니다."})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: RoundedRectangleBorder(),
      collapsedShape: RoundedRectangleBorder(),
      initiallyExpanded: true,
      tilePadding: EdgeInsets.zero,
      iconColor: AppColor.greyColor40,
      collapsedIconColor: AppColor.greyColor40,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      title: Text(
        "알려드립니다.",
        style: poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100),
      ),
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: poppinsTextStyle(14, FontWeight.w400, AppColor.greyColor50),
        )
      ],
    );
  }
}
