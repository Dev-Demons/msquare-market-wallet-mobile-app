import 'package:flutter/material.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/style.dart';

class PeriodTag extends StatelessWidget {
  const PeriodTag({
    Key? key,
    required this.tag,
    this.inverse = false,
  }) : super(key: key);

  final String tag;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: inverse ? AppColor.greyColor0 : AppColor.primaryColor0,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        tag,
        style: inverse
            ? poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100)
            : poppinsTextStyle(12, FontWeight.w500, AppColor.primaryColor100),
      ),
    );
  }
}

class StepTagWidget extends StatelessWidget {
  const StepTagWidget({Key? key, required this.number, required this.name})
      : super(key: key);

  final int number;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PeriodTag(tag: "촬영 $number", inverse: true),
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            name,
            style: poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100),
          ),
        )
      ],
    );
  }
}
