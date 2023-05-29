import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';

import '../../../core/constants/AppColor.dart';
import '../../widgets/custom_app_bar.dart';

class CheckParticipationDetailScreen extends StatefulWidget {
  const CheckParticipationDetailScreen({Key? key}) : super(key: key);

  @override
  State<CheckParticipationDetailScreen> createState() =>
      _CheckParticipationDetailScreenState();
}

class _CheckParticipationDetailScreenState
    extends State<CheckParticipationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor0,
      appBar: customAppBar("나의 참여금액",
          center: true, backArrow: true, isBottomBorder: true),
      body: Padding(
        padding: commonPadding(0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: commonPadding(20, 0),
              child: Text(
                "결제대금 지급기간 동안 일일 분할지급 되며",
                style:
                    poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
              ),
            ),
            Padding(
              padding: commonPadding(20, 4),
              child: Text(
                "매주 월요일 주간 정산하며 지급됩니다.",
                style:
                    poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
              ),
            ),
            SizedBox(height: 24),
            DividerWidget(),
            ListTile(
              leading:
                  Icon(Icons.arrow_back_ios, color: Colors.black, size: 16),
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              dense: true,
              visualDensity: VisualDensity(vertical: -4),
              minVerticalPadding: 0,
              tileColor: Colors.white,
              horizontalTitleGap: 8,
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
              title: Row(
                children: [
                  DateSelectedWidget(date: "2023년\n1월 4주차", selected: false),
                  DateSelectedWidget(date: "2023년\n1월 5주차", selected: true),
                  DateSelectedWidget(date: "2023년\n2월 2주차", selected: false),
                ],
              ),
            ),
            DividerWidget(),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    DividerWidget(),
                    DetailListWidget(),
                    DividerWidget(),
                    DetailListWidget(),
                    DividerWidget(),
                    DetailListWidget(),
                    DividerWidget(),
                    DetailListWidget(),
                    DividerWidget(),
                    DetailListWidget(),
                    DividerWidget(),
                    DetailListWidget(selected: true),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateSelectedWidget extends StatelessWidget {
  const DateSelectedWidget(
      {Key? key, required this.date, required this.selected})
      : super(key: key);
  final String date;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        color: selected ? AppColor.greyColor0 : Colors.white,
        child: Text(
          date,
          textAlign: TextAlign.center,
          style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor70),
        ),
      ),
    );
  }
}

class DetailListWidget extends StatelessWidget {
  const DetailListWidget({Key? key, this.selected = false}) : super(key: key);
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? AppColor.primaryColor0 : AppColor.greyColor0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "2023-01-24",
                style:
                    poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
              ),
              if (selected)
                Text(
                  "정산일",
                  style: poppinsTextStyle(
                      14, FontWeight.w600, AppColor.greyColor70),
                )
            ],
          )),
          Expanded(
            child: Column(
              children: [
                Text(
                  "일일지급금",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor50),
                ),
                Text(
                  "누적지급금",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor50),
                ),
                if (selected)
                  Text(
                    "누적지급금",
                    style: poppinsTextStyle(
                        14, FontWeight.w600, AppColor.primaryColor100),
                  )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "113,340원",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor100),
                ),
                Text(
                  "113,340원",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor100),
                ),
                if (selected)
                  Text(
                    "792,340원",
                    style: poppinsTextStyle(
                        14, FontWeight.w600, AppColor.primaryColor100),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
