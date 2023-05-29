import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';

import '../../../core/constants/style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../homescreen/base_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("", backArrow: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          CircleAvatar(
            backgroundColor: successColor30,
            radius: 28,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 12),
            child: Text(
              "Password Changed!",
              style: poppinsTextStyle(20, FontWeight.w500, greyColor100),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "Your password has been changed successfully",
              textAlign: TextAlign.center,
              style: poppinsTextStyle(16, FontWeight.w500, greyColor50),
            ),
          )
        ],
      ),
      // Floating action button set to center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomMaterialButton(
          onPressed: () {
            Get.offAll(() => BottomNavigation(indexValue: 0));
          },
          btnColor: primaryColor70,
          textColor: Colors.white,
          title: "back_to_home".tr,
        ),
      ),
    );
  }
}
