import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/functions.dart';
import 'package:msquare_market/v2/core/models/super_save/dashboard_model.dart';
import 'package:msquare_market/v2/core/models/super_save/transaction_register_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/super_save_request_provider.dart';
import 'package:msquare_market/v2/ui/screens/super_save/super_save_result_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/credit_sale_edit_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/AppColor.dart';
import '../../../core/constants/borders.dart';
import '../../../core/constants/style.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/super_save/request_model.dart';
import '../../widgets/super_save/custom_expansion_tile.dart';
import '../../widgets/super_save/custom_row_text-widget.dart';
import '../../widgets/super_save/dashboard_widgets/bullet_text.dart';

class SuperSaveApplyScreen extends StatefulWidget {
  const SuperSaveApplyScreen({Key? key}) : super(key: key);

  @override
  State<SuperSaveApplyScreen> createState() => _SuperSaveApplyScreenState();
}

class _SuperSaveApplyScreenState extends State<SuperSaveApplyScreen> {
  bool hasError = false;
  bool isEnabled = false;
  TextEditingController agreementController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SuperSaveRequestModel;
    return ChangeNotifierProvider(
      create: (context) => SuperSaveRequestProvider(),
      child: Consumer<SuperSaveRequestProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customAppBar("외상매도 신청",
                backArrow: true, center: true, isBottomBorder: true),
            backgroundColor: AppColor.greyColor0,
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                CreditSaleEditWidget(
                  inverse: true,
                ),
                SizedBox(height: 24),
                Card(
                  color: Colors.white,
                  shape: commonRoundedRectangularBorder(),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CustomRowTextWidget(first: "이름", second: args.name!),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: CustomRowTextWidget(
                              first: "생년월일", second: args.dob!),
                        ),
                        CustomRowTextWidget(
                            first: "휴대폰번호", second: args.contact!),
                        SuperSaveDividerWidget(),
                        CustomRowTextWidget(
                            first: "외상매도 결제대금 \n지급기간(지급률)",
                            second:
                                "${args.paymentPeriod!}일(${args.paymentRate!}%)"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: CustomRowTextWidget(
                              first: "외상매도 결제대금 \n지급방식",
                              second: args.paymentMethod!),
                        ),
                        CustomRowTextWidget(
                            first: "외상매도 신청 \nMSQ 수량",
                            second:
                                "${performAdditionOnStringAndInt(args.depositAmountInMSQ!.toString(), 0)}MSQ"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: CustomRowTextWidget(
                              first: "외상매도 신청 \nMSQ 원화 환산금액",
                              second:
                                  "${performAdditionOnStringAndInt(args.depositAmountInWon!.toString(), 0)}원"),
                        ),
                        CustomRowTextWidget(
                            first: "외상매도 결제대금",
                            second:
                                "${performAdditionOnStringAndInt(args.totalPayoutAmount!.toString(), 0)}원"),
                        SizedBox(height: 16),
                        CustomRowTextWidget(
                            first: "외상매도 일일균등 \n지급금",
                            second:
                                "${performAdditionOnStringAndInt(args.dailyPayoutAmount!.toString(), 0)}원"),
                      ],
                    ),
                  ),
                ),
                CustomExpansionTile(),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          )),
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    height: 400,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 24),
                                            height: 4,
                                            width: 44,
                                            decoration: BoxDecoration(
                                              color: AppColor.greyColor20,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "서비스 이용 동의",
                                              style: poppinsTextStyle(
                                                  20,
                                                  FontWeight.w700,
                                                  AppColor.greyColor100),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                size: 32,
                                                color: AppColor.greyColor30,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: Text(
                                            "아래의 내용을 읽고 “동의함”을 입력해주세요.",
                                            style: poppinsTextStyle(
                                                14,
                                                FontWeight.w400,
                                                AppColor.greyColor50),
                                          ),
                                        ),
                                        SuperSaveDividerWidget(),
                                        Text(
                                          "동의사항",
                                          style: poppinsTextStyle(
                                              16,
                                              FontWeight.w700,
                                              AppColor.greyColor100),
                                        ),
                                        BulletText(
                                            text:
                                                "본인은 신청한 내용으로 MSQ 외상매도에 동의합니다."),
                                        SizedBox(height: 32),
                                        SuperSaveWithoutSuffixTextInputField(
                                          hintText: "동의함",
                                          align: TextAlign.center,
                                          controller: agreementController,
                                          error: hasError,
                                          onChanged: (v) {
                                            if (v!.isNotEmpty) {
                                              hasError = !((v == "동의함") ||
                                                  (v == 'agree'));
                                            } else {
                                              hasError = true;
                                            }
                                            isEnabled = !hasError;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        model.state == ViewState.busy
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColor
                                                            .primaryColor100),
                                              )
                                            : CustomMaterialButton(
                                                title: "확인",
                                                onPressed: () async {
                                                  if (isEnabled) {
                                                    setState(() {
                                                      model.setState(
                                                          ViewState.busy);
                                                    });
                                                    var result = await model
                                                        .sendSuperSaveRequest(
                                                            req: args);
                                                    setState(() {
                                                      model.setState(
                                                          ViewState.idle);
                                                    });
                                                    if (result['error']) {
                                                      showCustomSnackBar(
                                                          '외상매도 신청',
                                                          result['data'],
                                                          AppColor
                                                              .dangerColor10);
                                                    } else {
                                                      Get.to(
                                                        () =>
                                                            SuperSaveResultScreen(),
                                                      );
                                                    }
                                                  } else {
                                                    showCustomSnackBar(
                                                        "Super Save Request",
                                                        "Agreement is necessary",
                                                        AppColor.dangerColor10);
                                                  }
                                                },
                                                textColor: isEnabled
                                                    ? Colors.white
                                                    : AppColor.greyColor40,
                                                btnColor: isEnabled
                                                    ? AppColor.primaryColor100
                                                    : AppColor.greyColor20,
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                    },
                    shape: commonRoundedRectangularBorder(hasColor: false),
                    elevation: 0,
                    color: AppColor.primaryColor100,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "다음",
                      style:
                          poppinsTextStyle(14, FontWeight.w500, Colors.white),
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
