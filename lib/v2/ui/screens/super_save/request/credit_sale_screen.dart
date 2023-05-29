import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/functions.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/super_save_request_provider.dart';
import 'package:msquare_market/v2/ui/screens/super_save/super_save_apply_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_container_widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_expansion_tile.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/style.dart';
import '../../../widgets/custom_text_input_field.dart';
import '../../../widgets/divider_widget.dart';
import '../../../widgets/super_save/credit_sale_edit_widget.dart';
import '../../../widgets/super_save/credit_sale_input_button.dart';
import '../../../widgets/super_save/interest_switch_button.dart';

class CreditSaleScreen extends StatefulWidget {
  const CreditSaleScreen({Key? key}) : super(key: key);

  @override
  State<CreditSaleScreen> createState() => _CreditSaleScreenState();
}

class _CreditSaleScreenState extends State<CreditSaleScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SuperSaveRequestModel;
    return ChangeNotifierProvider(
      create: (context) => SuperSaveRequestProvider(),
      child: Consumer<SuperSaveRequestProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: SuperSaveAppBar(
                title: Text(
              "외상매도 신청",
              style: poppinsTextStyle(20, FontWeight.w600, Colors.white),
            )),
            body: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                CustomContainerWidget(
                  child: CreditSaleEditWidget(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    color: AppColor.primaryColor100,
                    dashPattern: [6, 3],
                    radius: Radius.circular(8),
                    strokeWidth: 2,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor0,
                          borderRadius: BorderRadius.circular(8)),
                      child: CustomRowTextWidget(
                          first: "외상매도 신청가능한도",
                          second:
                              priceString(args.possibleToParticipate!) + "원"),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text(
                    "외상매도 신청 MSQ 원화 환산금액",
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SuperSaveCustomTextInputField(
                    controller: model.amountController,
                    align: TextAlign.end,
                    error: model.hasError,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
                    onChanged: (v) {
                      model.amountOnChanged(v, args.possibleToParticipate!);
                    },
                    validator: (String? value) {
                      String? response;
                      if (value!.isNotEmpty) {
                        if (int.parse(value.replaceAll(',', '')) < 1000000) {
                          response = "100만원부터 신청 가능합니다.";
                        } else if (int.parse(value.replaceAll(',', '')) >
                            int.parse(args.possibleToParticipate!
                                .toString()
                                .replaceAll(',', '')
                                .replaceAll('원', ''))) {
                          response = "신청가능한도를 초과하였습니다.";
                        } else if (int.parse(value.replaceAll(',', '')) %
                                1000000 !=
                            0) {
                          response = "100만원 단위로 신청 가능합니다.";
                        }
                      }
                      return response;
                    },
                    hintText: "1,000,000",
                    suffix: "원",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CreditSaleInputButton(
                        text: "+100만원",
                        onPressed: () {
                          model.oneMillionWonOnPressed(
                              args.possibleToParticipate!);
                        },
                      ),
                      SizedBox(width: 4),
                      CreditSaleInputButton(
                        text: "+1,000만원",
                        onPressed: () {
                          model.tenMillionWonOnPressed(
                              args.possibleToParticipate!);
                        },
                      ),
                      SizedBox(width: 4),
                      CreditSaleInputButton(
                        text: "+1억원",
                        onPressed: () {
                          model.hundredMillionWonOnPressed(
                              args.possibleToParticipate!);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "외상매도 신청 MSQ 수량",
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: SuperSaveCustomTextInputField(
                      controller: model.cryptoController,
                      hintText: "0",
                      suffix: "MSQ",
                      readOnly: true),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "현재가 1MSQ=10,000원",
                    textAlign: TextAlign.right,
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor40),
                  ),
                ),
                SuperSaveDividerWidget(horizontal: 20),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "외상매도 결제대금 지급기간(지급률)",
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        color: AppColor.greyColor10,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.greyColor20)),
                    child: Row(
                      children: [
                        InterestSwitchButton(
                          title: "90일(102%)",
                          selected: model.selectedIndex == 0,
                          onPressed: model.percent102OnPressed,
                        ),
                        InterestSwitchButton(
                          title: "180일(107%)",
                          selected: model.selectedIndex == 1,
                          onPressed: model.percent107OnPressed,
                        ),
                        InterestSwitchButton(
                          title: "365일(120%)",
                          selected: model.selectedIndex == 2,
                          onPressed: model.percent120OnPressed,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "외상매도 결제대금 산정",
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: SuperSaveCustomTextInputField(
                      controller: model.interestRateController,
                      formatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      readOnly: true,
                      hintText: "1,200,000",
                      suffix: "원"),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "외상매도 결제대금 지급방식",
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: MaterialButton(
                    onPressed: () {},
                    shape: commonRoundedRectangularBorder(),
                    elevation: 0,
                    color: AppColor.greyColor10,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "일일균등지급",
                      style: poppinsTextStyle(
                          14, FontWeight.w500, AppColor.greyColor70),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "외상매도 결제대금 일일균등 지급금 산정",
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: SuperSaveCustomTextInputField(
                    controller: model.perDayController,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
                    hintText: "3,290",
                    suffix: "원",
                    readOnly: true,
                  ),
                ),
                SuperSaveDividerWidget(horizontal: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomExpansionTile(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: MaterialButton(
                    onPressed: () {
                      if (model.isEnabled) {
                        args.addPaymentDetails(
                            model.paymentPeriod[model.selectedIndex],
                            model.paymentRate[model.selectedIndex],
                            "일일균등지급",
                            int.parse(model.cryptoController.text
                                .replaceAll(',', '')),
                            int.parse(model.amountController.text
                                .replaceAll(',', '')),
                            int.parse(model.interestRateController.text
                                .replaceAll(',', '')),
                            int.parse(model.perDayController.text
                                .replaceAll(',', '')));
                        Get.to(() => SuperSaveApplyScreen(), arguments: args);
                      } else {
                        showCustomSnackBar(
                            "Super Save Request",
                            "Please resolve the errors.",
                            AppColor.dangerColor10);
                      }
                    },
                    shape: commonRoundedRectangularBorder(hasColor: false),
                    elevation: 0,
                    color: model.isEnabled
                        ? AppColor.primaryColor100
                        : AppColor.greyColor20,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "다음",
                      style: poppinsTextStyle(
                          14,
                          FontWeight.w500,
                          model.isEnabled
                              ? Colors.white
                              : AppColor.greyColor40),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
        text: priceString(newValue.text.replaceAll(',', '')),
        selection: new TextSelection.collapsed(offset: newValue.text.length));
  }
}
