import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/withdrawal_user/withdrawal_user_rules_provider.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/enums/view_state.dart';

class WithdrawalUserRules extends StatelessWidget {
  const WithdrawalUserRules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WithdrawalUserRulesProvider(),
      builder: (context, child) {
        return Consumer<WithdrawalUserRulesProvider>(
          builder: (context, model, child) {
            return Scaffold(
              backgroundColor: Colors.white,
              // custom app bar
              appBar: customAppBar("서비스 탈퇴", backArrow: true, center: true),

              body: model.state == ViewState.busy
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor100,
                      ),
                    )
                  : ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      children: [
                        Row(
                          children: [
                            Text(
                              "탈퇴 전 꼭 확인해주세요.",
                              style: poppinsTextStyle(
                                  20, FontWeight.w700, greyColor100),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "- 서비스를 탈퇴하시면 모든 개인정보가 파기 됩니다.",
                          textAlign: TextAlign.left,
                          style: poppinsTextStyle(
                              14, FontWeight.w400, greyColor50),
                        ),
                        Text(
                          "- 기타 의무 보관 정보는 관련 법령에 따라 별도 보관하고, 일정 기간 보유한 되 파기됩니다.",
                          textAlign: TextAlign.left,
                          style: poppinsTextStyle(
                              14, FontWeight.w400, greyColor50),
                        ),
                        Text(
                          "- 재가입 시 회원정보, 계좌정보 등은 자동으로 복구되지 않습니다.",
                          textAlign: TextAlign.left,
                          style: poppinsTextStyle(
                              14, FontWeight.w400, greyColor50),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "- 탈퇴 신청 시 영업일 기준 24시간 이내 처리 되며,",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: greyColor50,
                                fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' 탈퇴 후 6개월 이내 재가입이 불가능합니다.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: dangerColor10,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '- 회원 탈퇴 신청 시 로그아웃 ',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: dangerColor10,
                                fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '처리 되며,',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor50,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' 로그인 및 모든 서비스 이용이 불가능',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: dangerColor10,
                                      fontSize: 14)),
                              TextSpan(
                                  text: '합니다.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor50,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          shape: commonRoundedRectangularBorder(),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "잔액 확인",
                                  style: poppinsTextStyle(
                                      16, FontWeight.w600, greyColor100),
                                ),
                                SizedBox(height: 14),
                                CustomRowTextWidget(
                                    first: "누적지급금",
                                    second: "${model.cumulativeAmount}원"),
                                CustomRowTextWidget(
                                    first: "입금 계좌",
                                    second:
                                        "${model.userMainBank.bankName} ${model.userMainBank.bankAccount}"),
                                SizedBox(height: 24),
                                Text(
                                  "남은 잔액은 등록된 계좌로 입금됩니다.",
                                  style: poppinsTextStyle(
                                      14, FontWeight.w500, primaryColor70),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                              color: primaryColor10,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "탈퇴 신청은 철회되지 않으니 신중히 결정해주세요.",
                            style: poppinsTextStyle(
                                14, FontWeight.w600, greyColor70),
                          ),
                        ),
                        model.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primaryColor100),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: CustomMaterialButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      btnColor: Colors.white,
                                      borderColor: AppColor.primaryColor100,
                                      title: "취소",
                                      textColor: primaryColor70,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomMaterialButton(
                                      onPressed: () async {
                                        final args = ModalRoute.of(context)!
                                            .settings
                                            .arguments as Map;
                                        var response =
                                            await model.userWithdrawal(
                                                reason: args['reason'],
                                                desc: args['desc']);
                                        if (!response['error']) {
                                          _showMyDialog(context);
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            locator<AuthServices>().logout();
                                          });
                                        }
                                      },
                                      btnColor: AppColor.primaryColor100,
                                      title: "탈퇴 신청",
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: null,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                "탈퇴 신청이 완료 되어\n로그아웃 됩니다.",
                style: poppinsTextStyle(
                  16,
                  FontWeight.w600,
                  greyColor100,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 40,
              ),
              Center(
                  child: CircularProgressIndicator(
                      color: AppColor.primaryColor100)),
            ],
          ),
        ),
      );
    },
  );
}
