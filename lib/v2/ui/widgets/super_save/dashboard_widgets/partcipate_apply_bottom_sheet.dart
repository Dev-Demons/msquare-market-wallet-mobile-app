import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/style.dart';
import '../../../../core/enums/view_state.dart';
import '../../../screens/super_save/participate/super_save_participate_provider.dart';
import '../../../screens/super_save/super_save_apply_screen.dart';
import '../../../screens/super_save/super_save_result_screen.dart';
import '../../custom_button.dart';
import '../../custom_text_input_field.dart';
import '../../divider_widget.dart';
import '../../password_snackbar.dart';
import 'bullet_text.dart';

class ParticipateApplyBottomSheet extends StatefulWidget {
  const ParticipateApplyBottomSheet(
      {Key? key, required this.model, required this.reqID})
      : super(key: key);
  final SuperSaveParticipateProvider model;
  final String reqID;
  @override
  State<ParticipateApplyBottomSheet> createState() =>
      _ParticipateApplyBottomSheetState();
}

class _ParticipateApplyBottomSheetState
    extends State<ParticipateApplyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: 500,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: commonPadding(20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                height: 4,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColor.greyColor20,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "서비스 이용 동의",
                  style: poppinsTextStyle(
                      20, FontWeight.w700, AppColor.greyColor100),
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
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                "아래의 내용을 읽고 “동의함”을 입력해주세요.",
                textAlign: TextAlign.left,
                style:
                    poppinsTextStyle(14, FontWeight.w400, AppColor.greyColor50),
              ),
            ),
            SuperSaveDividerWidget(vertical: 12),
            Expanded(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Text(
                      "동의사항",
                      style: poppinsTextStyle(
                          16, FontWeight.w700, AppColor.greyColor100),
                    ),
                    BulletText(text: "슈퍼세이브는 외상거래입니다."),
                    BulletText(
                        text:
                            "외상거래는 거래에서 매매계약이 성립되어 상품이 인도되었 지만, 그에 대한 대금은 일정기간이 지난 후에 결제되는 거래를 말하며, 외상매매 또는 신용 거래라고 하기도 합니다. 이러한 신용거래는 신용을 기반으로 장래 채무를 지급하는 대차관계가 발생합니다."),
                    BulletText(
                        text:
                            "MSQ를 슈퍼세이브 지갑에 전송하는 시점 거래는 완료되는 것이며, 소유권은 MSQUARE 본사로 이전되며 소유권 행사 또한 자율권한입니다."),
                    BulletText(
                        text:
                            "유저는 외상거래 결제대금에 대한 채권이, MSQUARE 본사는 채무가 발생하게 되며, 약정한 지급기한내에 대금 결제를 마무리하는 것에 서로 동의함을 뜻합니다."),
                    BulletText(
                        text:
                            "슈퍼세이브는 자본시장법 또는 금융소비자보호법 등에 의해 보호받을 수 있는 금융상품이 아닙니다.."),
                    SizedBox(height: 40),
                    SuperSaveWithoutSuffixTextInputField(
                      hintText: "동의함",
                      align: TextAlign.center,
                      controller: widget.model.agreementController,
                      error: widget.model.hasError,
                      onChanged: (v) {
                        if (v!.isNotEmpty) {
                          widget.model.hasError =
                              !((v == "동의함") || (v == 'agree'));
                        } else {
                          widget.model.hasError = true;
                        }
                        widget.model.isEnabled = !widget.model.hasError;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 8),
                    widget.model.state == ViewState.busy
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor100),
                          )
                        : CustomMaterialButton(
                            title: "확인",
                            onPressed: () async {
                              setState(() {
                                widget.model.setState(ViewState.busy);
                              });
                              if (widget.model.isEnabled) {
                                var response = await widget.model
                                    .sendParticipationRequest(
                                        reqID: widget.reqID);
                                if (response['error']) {
                                  showCustomSnackBar('Super Save Participate',
                                      response["data"], AppColor.dangerColor10);
                                } else {
                                  Get.to(() => SuperSaveResultScreen(
                                        first: "SUPER SAVE 참여가\n완료되었습니다.",
                                        second: "",
                                      ));
                                }
                              } else {
                                showCustomSnackBar(
                                    'Super Save Participate',
                                    "Agreement is necessary",
                                    AppColor.dangerColor10);
                              }
                              setState(() {
                                widget.model.setState(ViewState.idle);
                              });
                            },
                            textColor: widget.model.isEnabled
                                ? Colors.white
                                : AppColor.greyColor40,
                            btnColor: widget.model.isEnabled
                                ? AppColor.primaryColor100
                                : AppColor.greyColor20,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
