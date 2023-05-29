import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_container_widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/stake_info_tile.dart';

import '../../../core/constants/borders.dart';

class TotalParticipationScreen extends StatefulWidget {
  const TotalParticipationScreen({Key? key}) : super(key: key);

  @override
  State<TotalParticipationScreen> createState() =>
      _TotalParticipationScreenState();
}

class _TotalParticipationScreenState extends State<TotalParticipationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SuperSaveAppBar(
        title: Text(
          "전체 참여금액",
          style: poppinsTextStyle(24, FontWeight.w700, Colors.white),
        ),
      ),
      body: ListView(
        children: [
          CustomContainerWidget(
            child: Column(
              children: [
                StakeInfoTile(title: "전체 참여금액", subtitle: "7억 1110만원"),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child:
                            StakeInfoTile(title: "전체 참여인원", subtitle: "10명")),
                    SizedBox(width: 8),
                    Expanded(
                        child:
                            StakeInfoTile(title: "전체 참여이력", subtitle: "20건")),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "전체 참여이력",
              style:
                  poppinsTextStyle(20, FontWeight.w700, AppColor.greyColor100),
            ),
          ),
          TotalParticipationDetailWidget(
            name: "홍*동",
            date: "2023-04-30 12:00:00",
            payment: "70,000,000원",
          ),
          TotalParticipationDetailWidget(
            name: "김*정",
            date: "2023-04-29 11:00:00",
            payment: "35,000,000원",
          ),
          TotalParticipationDetailWidget(
            name: "홍길동",
            date: "2023-04-30 12:00:00",
            payment: "70,000,000원",
          ),
        ],
      ),
    );
  }
}

class TotalParticipationDetailWidget extends StatelessWidget {
  const TotalParticipationDetailWidget(
      {Key? key, required this.name, required this.date, required this.payment})
      : super(key: key);
  final String name;
  final String date;
  final String payment;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      shape: commonRoundedRectangularBorder(),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomRowTextWidget(first: "이름", second: name),
            CustomRowTextWidget(first: "승인일시", second: date),
            CustomRowTextWidget(first: "외상매도 결제대금", second: payment),
          ],
        ),
      ),
    );
  }
}
