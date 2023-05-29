import 'package:flutter/material.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/style.dart';

class BankSelectionScreen extends StatefulWidget {
  const BankSelectionScreen({Key? key}) : super(key: key);

  @override
  State<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class _BankSelectionScreenState extends State<BankSelectionScreen> {
  List<String> bankNames = [
    "NH농협",
    "카카오뱅크",
    "KB국민은행",
    "신한은행",
    "우리은행",
    "토스뱅크",
    "IBK기업은행",
    "하나은행",
    "새마을금고",
    "BNK부산은행",
    "DGB대구은행",
    "케이뱅크",
    "신협은행",
    "우체국예금",
    "SC제일은행",
    "BNK경남은행",
    "광주은행",
    "수협",
    "전북은행",
    "저축은행",
    "제주은행",
    "한국씨티은행",
    "KDB산업은행",
    "산림조합중앙회",
    "SBI저축은행",
    "BOA",
    "중국은행",
    "중국은행",
    "중국공상은행",
    "도이치뱅크",
    "JP모건",
    "BNP파리바은행",
    "중국건설은행"
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithClose(title: "은행 선택"),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.25),
            itemCount: bankNames.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  Future.delayed(Duration(milliseconds: 400), () {
                    Get.back(result: bankNames[selectedIndex!]);
                  });
                },
                child: Container(
                  margin: EdgeInsets.zero,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: selectedIndex == index
                              ? AppColor.primaryColor100
                              : AppColor.greyColor20,
                          width: 1)),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColor.greyColor0,
                          child: Image.asset(
                              'assets/super_save/banks/${index + 1}.png')),
                      const SizedBox(height: 8),
                      Text(
                        bankNames[index],
                        textAlign: TextAlign.center,
                        style: poppinsTextStyle(
                            14, FontWeight.w500, AppColor.greyColor100),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
