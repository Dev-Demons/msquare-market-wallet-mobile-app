import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/screens/super_save/super_save_apply_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/participate/super_save_participate.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/functions.dart';
import '../../../../core/models/super_save/dashboard_model.dart';
import '../../custom_button.dart';
import '../../divider_widget.dart';
import '../custom_row_text-widget.dart';
import 'common_participation_container.dart';
import 'period_tag.dart';

class PossibleParticipationWidget extends StatelessWidget {
  const PossibleParticipationWidget(
      {Key? key, required this.possibleParticipation})
      : super(key: key);
  final PossibleParticipation possibleParticipation;
  @override
  Widget build(BuildContext context) {
    return possibleParticipation.isDisplay == 0
        ? CommonContainerForParticipationDashboard(
            title: possibleParticipation.message!)
        : Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                shape: commonRoundedRectangularBorder(),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PeriodTag(tag: possibleParticipation.paymentPeriod!),
                      CustomRowTextWidget(
                        first: "전송수량",
                        second: possibleParticipation.totalAmountInMSQ!,
                        isBlack: true,
                      ),
                      SuperSaveDividerWidget(),
                      CustomRowTextWidget(
                          first: "신청일시",
                          second: convertTimeStampToTimeFormat(
                              possibleParticipation.requestDate!)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomRowTextWidget(
                            first: "마감일시",
                            second: convertTimeStampToTimeFormat(
                                possibleParticipation.endDate!)),
                      ),
                      CustomRowTextWidget(
                          first: "외상매도 신청 \nMSQ 원화 환산금액",
                          second: possibleParticipation.totalAmountInWon!),
                      SizedBox(height: 40),
                      CustomMaterialButton(
                        onPressed: () {
                          Get.to(() => SuperSaveParticipateScreen(),
                              arguments: possibleParticipation);
                        },
                        btnColor: AppColor.primaryColor100,
                        title: "참여하기",
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
