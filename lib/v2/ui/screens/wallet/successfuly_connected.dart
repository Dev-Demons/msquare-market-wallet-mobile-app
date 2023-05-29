import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import '../../../core/constants/colors.dart';
import '../homescreen/base_screen.dart';

/// A [View] that displays ConnectedWallet Screen which shows whether
/// wallet was connected or not.

class SuccessFullyConnectedWallet extends StatelessWidget {
  /// Variable that stores the connection message to show on screen
  final status;

  /// [Constructor] that accepts connection message.
  SuccessFullyConnectedWallet({this.status});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7F9),
      appBar: customAppBar("transaction_request".tr,
          center: true, isBottomBorder: true),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  // Status Message
                  status == "confirmed"
                      ? Image.asset(
                          "assets/v2/success.png",
                        )
                      : Image.asset(
                          "assets/v2/failed.png",
                        ),
                  SizedBox(
                    height: 25,
                  ),
                  // Status Message Label
                  status == "confirmed"
                      ? Text(
                          "transaction_confirmed".tr,
                          textAlign: TextAlign.center,
                          style: poppinsTextStyle(
                              20, FontWeight.w500, Colors.black),
                        )
                      : Text(
                          "transaction_failed".tr,
                          textAlign: TextAlign.center,
                          style: poppinsTextStyle(
                              20, FontWeight.w500, Colors.black),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  // Status Message Description
                  status == "confirmed"
                      ? Text(
                          "transaction_confirm_msg".tr,
                          textAlign: TextAlign.center,
                          style: poppinsTextStyle(
                              14, FontWeight.w500, greyColor50),
                        )
                      : Text(
                          "$status",
                          textAlign: TextAlign.center,
                          style: poppinsTextStyle(
                              14, FontWeight.w500, greyColor50),
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  // Navigate Back to Home Screen
                  InkWell(
                    onTap: () {
                      Get.offAll(() => BottomNavigation(indexValue: 0));
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor70),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        "back_to_home".tr,
                        style: TextStyle(
                            color: primaryColor70, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
