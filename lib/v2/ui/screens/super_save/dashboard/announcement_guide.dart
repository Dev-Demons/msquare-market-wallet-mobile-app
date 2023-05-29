import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/screens/super_save/bank_integration/bank_selection_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/credit_sale_application.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/credit_sale_screen.dart';
import '../../../widgets/super_save/super_save_alert_dialog.dart';
import '../transfer_registration/transaction_registeration_main.dart';

class AnnouncementGuideScreen extends StatefulWidget {
  const AnnouncementGuideScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementGuideScreen> createState() =>
      _AnnouncementGuideScreenState();
}

class _AnnouncementGuideScreenState extends State<AnnouncementGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("이용가이드",
          backArrow: true, isBottomBorder: true, center: true),
      body: ListView(
        children: [
          Padding(
            padding: commonPadding(20, 30),
            child: Text(
              "SUPER SAVE란?",
              style:
                  poppinsTextStyle(24, FontWeight.w700, AppColor.greyColor100),
            ),
          ),
          Image.asset('assets/super_save/guide_bg_image.jpg'),
          Padding(
            padding: commonPadding(20, 20),
            child: Text(
              "슈퍼세이브는 MSQUARE의 실물경제 플랫폼 생태계 확산을 위한 글로벌 유저증가와 그로인한 MSQ,MSQX의 실사용 고정매수세 확대를 목표로 합니다.",
              style:
                  poppinsTextStyle(16, FontWeight.w400, AppColor.greyColor50),
            ),
          ),
          Padding(
            padding: commonPadding(20, 0),
            child: Text(
              "슈퍼세이브는 지급준비금 100% 한도내에서 운영되는 안정성과 MSQUARE에서 인정하는 가치를 반영하여 산정한 외상매도 결제대금 지급률이 신청 MSQ의 가치보다 최대 20%가 높게 책정됩니다.",
              style:
                  poppinsTextStyle(16, FontWeight.w400, AppColor.greyColor50),
            ),
          ),
          Padding(
            padding: commonPadding(20, 20),
            child: Text(
              "MSQUARE 실물경제 플랫폼 유저 증가속도를 가파른 상승곡선으로 만들어줄 신박한 플랫폼이 바로 슈퍼 세이브입니다.",
              style:
                  poppinsTextStyle(16, FontWeight.w400, AppColor.greyColor50),
            ),
          ),
          SizedBox(height: 40),
          CustomStepperWidget(index: 1, title: "외상매도 신청할 MSQ 준비하기"),
          CustomStepperWidget(index: 2, title: "외상매도 신청"),
          CustomStepperWidget(
            index: 3,
            title: "요청하신 MSQ 수량을 10분이내",
            subtitle: "SUPER SAVE 지갑으로 전송",
          ),
          CustomStepperWidget(index: 4, title: "전송된 TXID값 입력"),
          CustomStepperWidget(
            index: 5,
            title: "SUPER SAVE 지갑전송 내용 확인",
            subtitle: "및 최종 승인 결정 진행",
          ),
          SizedBox(height: 40),
          Padding(
            padding: commonPadding(20, 20),
            child: MaterialButton(
                onPressed: () {
                  final args =
                      ModalRoute.of(context)!.settings.arguments as Map;
                  if (args["displayTimePopup"]) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SuperSaveDashboardAlertDialog(
                              title:
                                  "SUPER SAVE가 마감되었습니다. 매일 10시부터 16시까지 신청 가능합니다.");
                        });
                  } else {
                    if (args['isTransactionRegistered'] == 0) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SuperSaveDashboardAlertDialog(
                                title: "담당자 확인 후 SUPER SAVE 이용이 가능합니다.");
                          });
                    } else if (args['isTransactionRegistered'] == 2) {
                      Get.to(() => TransactionRegistrationMainScreen());
                    } else if (args['displayPopUpError'] != "") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SuperSaveDashboardAlertDialog(
                                title: args['displayPopUpError']);
                          });
                    } else {
                      Get.to(
                        () => CreditSaleApplicationScreen(),
                        arguments: {
                          "possibleToParticipate": args["possibleToParticipate"]
                        },
                      );
                    }
                  }
                },
                shape: commonRoundedRectangularBorder(hasColor: false),
                color: AppColor.primaryColor100,
                elevation: 0,
                padding: commonPadding(0, 16),
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  "SUPER SAVE 신청하기",
                  style: poppinsTextStyle(14, FontWeight.w500, Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

class CustomStepperWidget extends StatelessWidget {
  const CustomStepperWidget(
      {Key? key, required this.index, required this.title, this.subtitle = ""})
      : super(key: key);
  final int index;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 5),
                height: 30,
                width: 30,
                child: Text(
                  index.toString(),
                  style: poppinsTextStyle(
                      16, FontWeight.w500, AppColor.primaryColor100),
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor100)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Text(title,
                    style: poppinsTextStyle(
                        16, FontWeight.w600, AppColor.greyColor100)),
              ),
            ],
          ),
          index < 5
              ? Container(
                  margin: const EdgeInsets.only(left: 22),
                  padding: EdgeInsets.only(left: 48),
                  height: 50,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                    color: AppColor.primaryColor100,
                  ))),
                  child: Text(subtitle,
                      style: poppinsTextStyle(
                          16, FontWeight.w600, AppColor.greyColor100)),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 68),
                  child: Text(subtitle,
                      style: poppinsTextStyle(
                          16, FontWeight.w600, AppColor.greyColor100)),
                ),
        ],
      ),
    );
  }
}
