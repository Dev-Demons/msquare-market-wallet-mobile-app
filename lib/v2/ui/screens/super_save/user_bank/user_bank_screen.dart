import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/ui/screens/super_save/bank_integration/connect_bank_account.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_details.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_provider.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_expansion_tile.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/dashboard_widgets/period_tag.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/style.dart';

class UserBankScreen extends StatefulWidget {
  const UserBankScreen({Key? key}) : super(key: key);

  @override
  State<UserBankScreen> createState() => _UserBankScreenState();
}

class _UserBankScreenState extends State<UserBankScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserBankProvider(),
      child: Consumer<UserBankProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("내 계좌",
                backArrow: true, center: true, isBottomBorder: true),
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                        color: AppColor.primaryColor100),
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    children: [
                      Text(
                        "총 ${model.banks.length}건",
                        style: poppinsTextStyle(
                            16, FontWeight.w600, AppColor.greyColor100),
                      ),
                      SizedBox(height: 10),
                      model.banks.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.symmetric(vertical: 32),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: AppColor.greyColor20)),
                              child: Center(
                                child: Text(
                                  "등록된 계좌가 없습니다.",
                                  style: poppinsTextStyle(14, FontWeight.w500,
                                      AppColor.greyColor30),
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: model.banks.length,
                              itemBuilder: (context, index) {
                                var bank = model.banks[index];
                                return ListTile(
                                  tileColor: Colors.white,
                                  shape: commonRoundedRectangularBorder(),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Get.to(() => UserBankDetails(),
                                          arguments: {
                                            'model': model,
                                            'bank': bank
                                          });
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColor.greyColor50,
                                    ),
                                  ),
                                  leading: Image.asset(
                                      'assets/super_save/banks/${index + 1}.png'),
                                  minLeadingWidth: 0,
                                  minVerticalPadding: 0,
                                  title: Row(
                                    children: [
                                      Text(
                                        bank.bankName!,
                                        style: poppinsTextStyle(
                                            16,
                                            FontWeight.w600,
                                            AppColor.greyColor100),
                                      ),
                                      if (bank.isMainAccount!)
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                              color: AppColor.primaryColor0,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            "주계좌",
                                            style: poppinsTextStyle(
                                                12,
                                                FontWeight.w600,
                                                AppColor.primaryColor100),
                                          ),
                                        )
                                    ],
                                  ),
                                  subtitle: Text(
                                    bank.bankAccount!,
                                    style: poppinsTextStyle(14, FontWeight.w500,
                                        AppColor.greyColor50),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 16);
                              },
                            ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ConnectBankAccount(), arguments: model);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: AppColor.primaryColor100)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColor.primaryColor100,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "은행 계좌 등록",
                                style: poppinsTextStyle(14, FontWeight.w500,
                                    AppColor.primaryColor100),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SuperSaveDividerWidget(),
                      CustomExpansionTile(
                        text: "- 주계좌로 등록된 계좌에서 거래가 체결됩니다.",
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
