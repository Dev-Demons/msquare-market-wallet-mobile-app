import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/credit_sale_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:get/get.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../widgets/super_save/credit_sale_edit_widget.dart';

class CreditSaleApplicationScreen extends StatefulWidget {
  const CreditSaleApplicationScreen({Key? key}) : super(key: key);

  @override
  State<CreditSaleApplicationScreen> createState() =>
      _CreditSaleApplicationScreenState();
}

class _CreditSaleApplicationScreenState
    extends State<CreditSaleApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: customAppBar("외상매도 신청",
          backArrow: true, center: true, isBottomBorder: true),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreditSaleEditWidget(inverse: true, first: "신청인 정보를 입력해 주세요."),
            SizedBox(height: 24),
            Text(
              "이름",
              style:
                  poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
            ),
            SizedBox(height: 8),
            SuperSaveWithoutSuffixTextInputField(
              hintText: "홍길동",
              readOnly: true,
              align: TextAlign.start,
              controller: TextEditingController(text: "testUser345"),
            ),
            SizedBox(height: 16),
            Text(
              "생년월일",
              style:
                  poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
            ),
            SizedBox(height: 8),
            SuperSaveWithoutSuffixTextInputField(
              hintText: "19880102",
              readOnly: true,
              align: TextAlign.start,
              controller: TextEditingController(text: "1988-01-08"),
            ),
            SizedBox(height: 16),
            Text(
              "휴대폰번호",
              style:
                  poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
            ),
            SizedBox(height: 8),
            SuperSaveWithoutSuffixTextInputField(
              hintText: "010-1234-5678",
              align: TextAlign.start,
              readOnly: true,
              controller: TextEditingController(text: "010-1234-5678"),
            ),
            Spacer(),
            CustomMaterialButton(
              title: "다음",
              btnColor: AppColor.primaryColor100,
              textColor: Colors.white,
              onPressed: () {
                SuperSaveRequestModel model = SuperSaveRequestModel(
                    "testUser345", "1988-01-08", "010-1234-5678");
                model.possibleToParticipate = args['possibleToParticipate'];
                Get.to(() => CreditSaleScreen(), arguments: model);
              },
            )
          ],
        ),
      ),
    );
  }
}
