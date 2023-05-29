import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/borders.dart';
import '../../../core/constants/style.dart';

class ConsumptionRateTile extends StatelessWidget {
  const ConsumptionRateTile(
      {Key? key,
      required this.title,
      required this.percent,
      this.weight = FontWeight.w700,
      this.isDashboard = false})
      : super(key: key);
  final String title;
  final double percent;
  final FontWeight weight;
  final bool isDashboard;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: commonRoundedRectangularBorder(hasColor: !isDashboard),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDashboard ? 0 : 20, vertical: isDashboard ? 4 : 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor50),
                ),
                Text(
                  "${percent}%",
                  style: poppinsTextStyle(16, weight, AppColor.greyColor100),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: LinearProgressIndicator(
                  value: percent / 100,
                  minHeight: 6,
                  backgroundColor: AppColor.primaryColor10,
                  color: AppColor.primaryColor100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
