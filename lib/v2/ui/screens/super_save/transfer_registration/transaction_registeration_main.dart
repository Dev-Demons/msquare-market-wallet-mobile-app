import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/transaction_registeration_iden_select.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/dialogues/bottom_sheet_notch_line.dart';
import '../../../widgets/divider_widget.dart';
import '../../../widgets/super_save/dashboard_widgets/bullet_text.dart';
import 'package:get/get.dart';

import '../../../widgets/super_save/transaction_registration/custom_row_text_icon_widget.dart';

class TransactionRegistrationMainScreen extends StatefulWidget {
  const TransactionRegistrationMainScreen({Key? key}) : super(key: key);

  @override
  State<TransactionRegistrationMainScreen> createState() =>
      _TransactionRegistrationMainScreenState();
}

class _TransactionRegistrationMainScreenState
    extends State<TransactionRegistrationMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, backgroundColor: Colors.transparent),
      backgroundColor: AppColor.greyColor20,
      bottomSheet: Container(
        height: 460,
        padding: EdgeInsets.only(top: 20),
        color: AppColor.greyColor20,
        child: Container(
          height: 440,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          foregroundDecoration: BoxDecoration(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              BottomSheetNotchLineWidget(),
              CustomRowTextIconWidget(
                  title: 'SUPER SAVE 거래 등록 안내',
                  onPressed: () {
                    Get.back();
                  }),
              SuperSaveDividerWidget(),
              BulletText(
                text:
                    "SUPER SAVE 이용 시 타인의 정보도용 방지 및 지급금 입금,양도소득세 정산 등을 위한 본인인증 및 계좌등록이 필요합니다.",
              ),
              BulletText(
                text: "SUPER SAVE 첫 이용 시에만 거래 등록이 필요하며 다음 참여부터는 생략됩니다.",
              ),
              BulletText(
                text:
                    "거래 등록 완료 시 등록 정보는 회원정보에 업데이트 되며, 담당자의 확인 후 SUPER SAVE 이용이 가능합니다.",
              ),
              SizedBox(height: 40),
              CustomMaterialButton(
                  title: "SUPER SAVE 거래 등록",
                  onPressed: () {
                    Get.to(() => TransactionIdentificationSelection());
                  },
                  textColor: Colors.white,
                  btnColor: AppColor.primaryColor100),
            ],
          ),
        ),
      ),
    );
  }
}
