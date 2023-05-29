import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';

class BottomSheetNotchLineWidget extends StatelessWidget {
  const BottomSheetNotchLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 4,
        width: 44,
        decoration: BoxDecoration(
          color: AppColor.greyColor20,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
