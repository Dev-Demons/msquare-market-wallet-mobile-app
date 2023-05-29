import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/borders.dart';
import '../../../core/constants/style.dart';

class CreditSaleInputButton extends StatelessWidget {
  const CreditSaleInputButton({Key? key, required this.text, this.onPressed})
      : super(key: key);
  final String text;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(shape: MaterialStateProperty.resolveWith((_) {
            return commonRoundedRectangularBorder(radius: 4);
          })),
          child: Text(
            text,
            style:
                poppinsTextStyle(12, FontWeight.w500, AppColor.primaryColor100),
          )),
    );
  }
}
