import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({Key? key, this.child}) : super(key: key);
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          stops: [0.2, 0.9],
          end: Alignment.topRight,
          colors: [
            AppColor.primaryColor100,
            AppColor.superSaveGradientSecondColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
