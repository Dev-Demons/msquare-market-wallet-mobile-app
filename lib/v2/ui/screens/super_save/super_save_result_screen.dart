import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/participate/super_save_participate.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/credit_sale_application.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'dashboard/super_save_dashboard_screen.dart';

class SuperSaveResultScreen extends StatefulWidget {
  const SuperSaveResultScreen(
      {Key? key,
      this.first = "외상매도 신청이 \n완료되었습니다.",
      this.second = "지금부터 SUPER SAVE에 참여해볼까요?"})
      : super(key: key);
  final String first;
  final String second;
  @override
  State<SuperSaveResultScreen> createState() => _SuperSaveResultScreenState();
}

class _SuperSaveResultScreenState extends State<SuperSaveResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("외상매도 신청", center: true, isBottomBorder: true),
      backgroundColor: AppColor.greyColor0,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColor.successColor30,
              child: Icon(Icons.check, color: Colors.white, size: 32),
            ),
            SizedBox(height: 24),
            Text(
              widget.first,
              textAlign: TextAlign.center,
              style:
                  poppinsTextStyle(24, FontWeight.w600, AppColor.greyColor100),
            ),
            SizedBox(height: 12),
            Text(
              widget.second,
              textAlign: TextAlign.center,
              style:
                  poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomMaterialButton(
          title: "SUPER SAVE 바로가기",
          textColor: Colors.white,
          btnColor: AppColor.primaryColor100,
          onPressed: () {
            final tempArgs = ModalRoute.of(context)!.settings.arguments;
            if (tempArgs == null) {
              Get.offAll(() => BottomNavigation(indexValue: 0));
              Get.to(() => SuperSaveMainScreen());
            } else {
              final args = tempArgs as SuperSaveRequestModel;
              Get.to(() => CreditSaleApplicationScreen(), arguments: args);
            }
          },
        ),
      ),
    );
  }
}
