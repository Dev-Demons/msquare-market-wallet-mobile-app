import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/nice_webview_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/resident_registration_screen.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/constants/style.dart';
import '../../../../core/models/super_save/transaction_register_model.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/dialogues/bottom_sheet_notch_line.dart';
import '../../../widgets/divider_widget.dart';
import '../../../widgets/super_save/dashboard_widgets/bullet_text.dart';
import 'package:get/get.dart';

import '../../../widgets/super_save/transaction_registration/custom_row_text_icon_widget.dart';
import '../../../widgets/super_save/transaction_registration/identification_selection_widget.dart';
import 'foreign_registration_screen.dart';

class TransactionIdentificationSelection extends StatefulWidget {
  const TransactionIdentificationSelection({Key? key}) : super(key: key);

  @override
  State<TransactionIdentificationSelection> createState() =>
      _TransactionIdentificationSelectionState();
}

class _TransactionIdentificationSelectionState
    extends State<TransactionIdentificationSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, backgroundColor: Colors.transparent),
      backgroundColor: AppColor.greyColor20,
      bottomSheet: Container(
        height: 310,
        padding: EdgeInsets.only(top: 20),
        color: AppColor.greyColor20,
        child: Container(
          height: 290,
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
                  title: '본인인증 유형 선택',
                  onPressed: () {
                    Get.back();
                  }),
              SizedBox(height: 24),
              IdentificationSelectionWidget(
                onTap: () {
                  Get.to(() => NiceWebViewScreen(),
                      arguments: {"isKorean": true});
                },
                title: "내국인 본인인증",
                subtitle: "만 14세 이상 내국인",
                asset: "man",
              ),
              SizedBox(height: 8),
              IdentificationSelectionWidget(
                onTap: () {
                  Get.to(() => NiceWebViewScreen(),
                      arguments: {"isKorean": false});
                },
                title: "외국인 본인인증",
                subtitle: "국내거주 또는 방문 외국인",
                asset: "plane",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
