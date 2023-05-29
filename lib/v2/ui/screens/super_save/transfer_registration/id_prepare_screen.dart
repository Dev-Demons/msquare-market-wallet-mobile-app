import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/upload_id_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/upload_profile_screen.dart';

import '../../../../core/constants/AppColor.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/super_save/credit_sale_edit_widget.dart';
import '../../../widgets/super_save/dashboard_widgets/period_tag.dart';
import 'package:get/get.dart';

class IDPrepareScreen extends StatefulWidget {
  const IDPrepareScreen({Key? key}) : super(key: key);

  @override
  State<IDPrepareScreen> createState() => _IDPrepareScreenState();
}

class _IDPrepareScreenState extends State<IDPrepareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("SUPER SAVE 거래 등록",
          backArrow: true, center: true, isBottomBorder: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        children: [
          CreditSaleEditWidget(
            first: "신분증을 준비해주세요.",
            second: "본인확인을 위해 신분증 인증이 필요합니다.",
            inverse: true,
          ),
          SizedBox(height: 20),
          StepTagWidget(number: 1, name: "신분증/여권 사진"),
          SizedBox(height: 12),
          SvgPicture.asset('assets/super_save/prepare_id_2.svg'),
          SizedBox(height: 8),
          Text(
            "클릭하여 카메라가 작동되면 직접 촬영하세요.",
            style: poppinsTextStyle(14, FontWeight.w400, AppColor.greyColor50),
          ),
          SizedBox(height: 24),
          StepTagWidget(number: 2, name: "신분증/여권+얼굴사진"),
          SizedBox(height: 12),
          SvgPicture.asset('assets/super_save/prepare_id_1.svg'),
          SizedBox(height: 8),
          Text(
            "클릭하여 카메라가 작동되면 신분증을 얼굴 밑에 놓고 촬영하세요.",
            style: poppinsTextStyle(14, FontWeight.w400, AppColor.greyColor50),
          ),
          SizedBox(height: 24),
          CustomMaterialButton(
            title: "다음",
            btnColor: AppColor.primaryColor100,
            textColor: Colors.white,
            onPressed: () {
              final args = ModalRoute.of(context)!.settings.arguments
                  as SuperSaveRequestModel;
              Get.to(() => UploadIDScreen(), arguments: args);
            },
          ),
        ],
      ),
    );
  }
}
