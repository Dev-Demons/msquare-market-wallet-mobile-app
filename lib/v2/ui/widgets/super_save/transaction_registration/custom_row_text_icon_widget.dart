import 'package:flutter/material.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/style.dart';

class CustomRowTextIconWidget extends StatelessWidget {
  const CustomRowTextIconWidget({Key? key, required this.title, this.onPressed})
      : super(key: key);

  final String title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: poppinsTextStyle(20, FontWeight.w700, AppColor.greyColor100),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.close,
            size: 32,
            color: AppColor.greyColor30,
          ),
        )
      ],
    );
  }
}
