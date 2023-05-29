import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/models/super_save/dashboard_model.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/functions.dart';
import '../../../../core/constants/style.dart';
import '../../../screens/super_save/dashboard/super_save_dashboard_provider.dart';
import '../../custom_button.dart';
import '../../divider_widget.dart';
import '../custom_row_text-widget.dart';
import 'common_participation_container.dart';

class CompletedParticipationWidget extends StatelessWidget {
  CompletedParticipationWidget({Key? key, required this.completedParticipation})
      : super(key: key);

  final CompletedParticipation completedParticipation;

  @override
  Widget build(BuildContext context) {
    return completedParticipation.isDisplay == 0
        ? CommonContainerForParticipationDashboard(
            title: completedParticipation.message!)
        : ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              CustomRowTextWidget(
                  first: "총 외상매도 결제금액",
                  second: completedParticipation.requestCount!),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: completedParticipation.data.length,
                itemBuilder: (context, index) {
                  var item = completedParticipation.data[index];
                  return CompletedWidget(completedTransaction: item);
                },
              )
            ],
          );
  }
}

class CompletedWidget extends StatelessWidget {
  CompletedWidget({Key? key, required this.completedTransaction})
      : super(key: key);

  final CompletedTransaction completedTransaction;

  List<Color> buttonColors = [
    AppColor.successColor0.withOpacity(0.7),
    AppColor.primaryColor0,
    AppColor.dangerColor0
  ];

  List<Color> textColors = [
    AppColor.successColor50,
    AppColor.primaryColor100,
    AppColor.dangerColor20
  ];
  List<String> titles = ["승인 대기", "승인 완료", "승인 거절"];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: commonRoundedRectangularBorder(),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColor.primaryColor0,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                completedTransaction.paymentPeriod!,
                style: poppinsTextStyle(
                    12, FontWeight.w500, AppColor.primaryColor100),
              ),
            ),
            CustomRowTextWidget(
                first: "전송수량",
                second: completedTransaction.totalAmountInMSQ!,
                isBlack: true),
            SuperSaveDividerWidget(),
            CustomRowTextWidget(
                first: "승인일시",
                second: convertTimeStampToTimeWithSecsFormat(
                    completedTransaction.requestDate!)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomRowTextWidget(
                  first: "외상매도 결제금액",
                  second: completedTransaction.totalAmountInWon!),
            ),
            SizedBox(height: 40),
            CustomMaterialButton(
              onPressed: () {},
              btnColor: buttonColors[completedTransaction.status!],
              title: titles[completedTransaction.status!],
              textColor: textColors[completedTransaction.status!],
            ),
          ],
        ),
      ),
    );
  }
}
