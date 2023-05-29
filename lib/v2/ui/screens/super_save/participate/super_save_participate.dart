import 'dart:async';
import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/models/super_save/dashboard_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/bank_integration/connect_bank_account.dart';
import 'package:msquare_market/v2/ui/screens/super_save/participate/super_save_participate_provider.dart';
import 'package:msquare_market/v2/ui/screens/super_save/super_save_apply_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/super_save_result_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_expansion_tile.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/super_save_alert_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/style.dart';
import '../../../../core/enums/view_state.dart';
import '../../../widgets/dialogues/custom_alert_dialog.dart';
import '../../../widgets/super_save/credit_sale_edit_widget.dart';
import 'package:get/get.dart';

import '../../../widgets/super_save/dashboard_widgets/partcipate_apply_bottom_sheet.dart';

class SuperSaveParticipateScreen extends StatefulWidget {
  const SuperSaveParticipateScreen({Key? key}) : super(key: key);

  @override
  State<SuperSaveParticipateScreen> createState() =>
      _SuperSaveParticipateScreenState();
}

class _SuperSaveParticipateScreenState
    extends State<SuperSaveParticipateScreen> {
  int timer = 0;
  bool showAlert = true;
  void timerModule() {
    timer = 599;
    Timer.periodic(const Duration(seconds: 1), (time) {
      if (--timer == 0) {
        time.cancel();
        if (showAlert) {
          showDialog(
              context: context,
              builder: (context) {
                return SuperSaveDashboardAlertDialog(
                  title: "TXID 입력시간이 초과되었습니다. 다시 시도해주세요.",
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                );
              });
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    timerModule();
    super.initState();
  }

  String timerUI() {
    int minutes = (timer / 60).floor();
    int seconds = (timer % 60);
    String result = "0$minutes:${seconds > 9 ? seconds : "0$seconds"}";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PossibleParticipation;
    return ChangeNotifierProvider(
      create: (context) => SuperSaveParticipateProvider(args: args),
      child: Consumer<SuperSaveParticipateProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customAppBar("SUPER SAVE 참여",
                backArrow: true, isBottomBorder: true, center: true),
            backgroundColor: AppColor.greyColor0,
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                CreditSaleEditWidget(
                  inverse: true,
                  first: "외상매도를 신청한 MSQ를 \n보내주세요.",
                  second: "",
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 24),
                  color: Colors.white,
                  elevation: 0,
                  shape: commonRoundedRectangularBorder(),
                  child: Padding(
                    padding: commonPadding(20, 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "SUPER SAVE ",
                                  style: poppinsTextStyle(16, FontWeight.w600,
                                      AppColor.primaryColor100),
                                  children: [
                                    TextSpan(
                                      text: "MSQ 지갑주소 ",
                                      style: poppinsTextStyle(
                                          14, FontWeight.w500, Colors.black),
                                    )
                                  ]),
                            ),
                            Row(
                              children: [
                                Text(
                                  "복사",
                                  style: poppinsTextStyle(14, FontWeight.w500,
                                      AppColor.greyColor50),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.copy_outlined,
                                    color: AppColor.greyColor50, size: 16)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          args.companyWalletID!,
                          style: poppinsTextStyle(
                              16, FontWeight.w400, AppColor.greyColor50),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("전송 TXID 입력"),
                    Text(
                      timerUI(),
                      style: poppinsTextStyle(
                          14, FontWeight.w500, AppColor.primaryColor100),
                    ),
                  ],
                ),
                SuperSaveCustomTextInputField(
                    hintText: "전송 TXID 입력",
                    suffix: "",
                    type: TextInputType.text,
                    align: TextAlign.start,
                    error: model.hasError,
                    validator: (String? v) {
                      return v!.isEmpty ? "TX ID cannot be empty" : null;
                    },
                    onChanged: model.txOnChanged,
                    controller: model.txController),
                SizedBox(height: 24),
                Text("외상매도 신청 MSQ 원화 환산금액"),
                SuperSaveCustomTextInputField(
                    hintText: "100,000,000",
                    suffix: "원",
                    readOnly: true,
                    controller: model.wonController),
                SizedBox(height: 24),
                Text("외상매도 신청 MSQ 수량"),
                SuperSaveCustomTextInputField(
                    hintText: "10,000",
                    suffix: "MSQ",
                    readOnly: true,
                    controller: model.msqController),
                Text(
                  "현재가 1MSQ=10,000원",
                  textDirection: TextDirection.rtl,
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor40),
                ),
                SizedBox(height: 24),
                Text("외상매도 결제대금 계좌 선택"),
                SuperSaveCustomTextInputField(
                    hintText: "10,000",
                    suffix: "1",
                    align: TextAlign.start,
                    readOnly: true,
                    controller: model.bankController),
                SizedBox(height: 12),
                MaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  textColor: AppColor.primaryColor100,
                  padding: commonPadding(20, 16),
                  visualDensity: VisualDensity(horizontal: -4, vertical: -1),
                  shape: commonMaterialButtonBorder(
                      color: AppColor.primaryColor100),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 12),
                      Text(
                        "계좌 신규등록",
                        style: poppinsTextStyle(
                            14, FontWeight.w500, AppColor.primaryColor100),
                      ),
                    ],
                  ),
                ),
                SuperSaveDividerWidget(),
                CustomExpansionTile(),
                SizedBox(height: 64),
                CustomMaterialButton(
                  title: "다음",
                  textColor: (timer > 0 && model.isBottomSheetEnabled)
                      ? Colors.white
                      : AppColor.greyColor40,
                  btnColor: (timer > 0 && model.isBottomSheetEnabled)
                      ? AppColor.primaryColor100
                      : AppColor.greyColor10,
                  borderColor:
                      timer < 1 ? AppColor.greyColor20 : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      showAlert = false;
                    });
                    if (showAlert) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SuperSaveDashboardAlertDialog(
                              title: "TXID 입력시간이 초과되었습니다. 다시 시도해주세요.",
                              onPressed: () {
                                Get.back();
                                Get.back();
                              },
                            );
                          });
                    } else {
                      if (model.isBottomSheetEnabled) {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )),
                            context: context,
                            builder: (context) {
                              return ParticipateApplyBottomSheet(
                                  model: model, reqID: args.requestID!);
                            });
                      } else {
                        showCustomSnackBar("Super Save Request",
                            "Resolve Errors", AppColor.dangerColor10);
                      }
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
