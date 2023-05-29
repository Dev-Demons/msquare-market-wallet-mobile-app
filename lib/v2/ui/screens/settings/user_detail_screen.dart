import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/withdrawal_user/withdrawal_user.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';

import '../../../core/constants/AppColor.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("User",
          backArrow: true, center: true, isBottomBorder: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: commonRoundedRectangularBorder(),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CustomRowTextWidget(first: "Username", second: "gildong"),
                    CustomRowTextWidget(first: "User ID", second: "gildong123"),
                    CustomRowTextWidget(first: "이메일", second: "gmail.com"!),
                    CustomRowTextWidget(first: "이름", second: "홍길동"),
                    CustomRowTextWidget(first: "생년월일", second: "1988-01-01"),
                    CustomRowTextWidget(
                        first: "휴대폰번호", second: "010-1234-5678"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => WithdrawalUser());
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColor.greyColor20))),
                child: Text(
                  "서비스 탈퇴",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
