import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/style.dart';

class CustomRowTextWidget extends StatelessWidget {
  const CustomRowTextWidget(
      {Key? key,
      required this.first,
      required this.second,
      this.isBlack = false})
      : super(key: key);
  final String first;
  final String second;
  final bool isBlack;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: poppinsTextStyle(
              isBlack ? 16 : 14,
              isBlack ? FontWeight.w600 : FontWeight.w500,
              isBlack ? AppColor.greyColor100 : AppColor.greyColor50),
        ),
        Text(
          second,
          style: poppinsTextStyle(16, FontWeight.w500, AppColor.greyColor100),
        )
      ],
    );
  }
}

class DetailRowTextWidget extends StatelessWidget {
  const DetailRowTextWidget(
      {Key? key,
      required this.first,
      required this.second,
      this.isBlack = false})
      : super(key: key);
  final String first;
  final String second;
  final bool isBlack;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            first,
            style: poppinsTextStyle(
                isBlack ? 16 : 14,
                isBlack ? FontWeight.w600 : FontWeight.w500,
                isBlack ? AppColor.greyColor100 : AppColor.greyColor50),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            second,
            textAlign: TextAlign.right,
            style: poppinsTextStyle(16, FontWeight.w500, AppColor.greyColor100),
          ),
        )
      ],
    );
  }
}
