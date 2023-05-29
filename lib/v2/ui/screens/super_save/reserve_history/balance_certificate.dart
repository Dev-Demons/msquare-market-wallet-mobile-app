import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/screens/super_save/total_participation_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_participation_detail_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';

class BalanceCertificateScreen extends StatefulWidget {
  const BalanceCertificateScreen({Key? key}) : super(key: key);

  @override
  State<BalanceCertificateScreen> createState() =>
      _BalanceCertificateScreenState();
}

class _BalanceCertificateScreenState extends State<BalanceCertificateScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: CustomAppBarWithClose(title: "잔액증명서"),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.greyColor0,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.greyColor20)),
                  child: args['url'].toString().contains('http')
                      ? Image.network(
                          args['url'],
                          loadingBuilder: (context, widget, builder) {
                            return Center(child: widget);
                          },
                        )
                      : Center(
                          child: Text(
                            "잔액증명서 img",
                            style: poppinsTextStyle(
                                20, FontWeight.w600, AppColor.greyColor100),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              CustomMaterialButton(
                title: "확인",
                textColor: Colors.white,
                btnColor: AppColor.primaryColor100,
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
