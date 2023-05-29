import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/style.dart';

class CreditSaleEditWidget extends StatelessWidget {
  const CreditSaleEditWidget(
      {Key? key,
      this.inverse = false,
      this.first = "결제대금 정보를 입력해주세요.",
      this.second = "외상매도 신청에 필요한 정보를 입력해주세요."})
      : super(key: key);
  final bool inverse;
  final String first;
  final String second;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/svg_icons/edit.svg',
            color: inverse ? AppColor.greyColor100 : AppColor.greyColor0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            first,
            style: poppinsTextStyle(20, FontWeight.w700,
                inverse ? AppColor.greyColor100 : AppColor.greyColor0),
          ),
        ),
        if (second != "")
          Text(
            second,
            style: poppinsTextStyle(14, FontWeight.w400,
                inverse ? AppColor.greyColor50 : AppColor.greyColor0),
          )
      ],
    );
  }
}
