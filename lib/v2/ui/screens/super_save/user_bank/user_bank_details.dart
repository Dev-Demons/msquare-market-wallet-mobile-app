import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/functions.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_provider.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/super_save_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../../../../locator.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/constants/borders.dart';
import '../../../../core/models/super_save/bank_model.dart';
import '../../../widgets/custom_app_bar.dart';

class UserBankDetails extends StatefulWidget {
  const UserBankDetails({Key? key}) : super(key: key);

  @override
  State<UserBankDetails> createState() => _UserBankDetailsState();
}

class _UserBankDetailsState extends State<UserBankDetails> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final model = args['model'] as UserBankProvider;
    final bank = args['bank'] as BankModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("내 계좌",
          backArrow: true, center: true, isBottomBorder: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.white,
              shape: commonRoundedRectangularBorder(),
              leading: Image.asset('assets/super_save/banks/1.png'),
              title: Row(
                children: [
                  Text(
                    bank.bankName!,
                    style: poppinsTextStyle(
                        16, FontWeight.w600, AppColor.greyColor100),
                  ),
                  if (bank.isMainAccount!)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor0,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "주계좌",
                        style: poppinsTextStyle(
                            12, FontWeight.w600, AppColor.primaryColor100),
                      ),
                    )
                ],
              ),
              subtitle: Text(
                bank.bankAccount!,
                style:
                    poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: commonRoundedRectangularBorder(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    CustomRowTextWidget(
                        first: "예금주",
                        second: locator<AuthServices>().myAppUser.name!),
                    CustomRowTextWidget(
                        first: "등록일시",
                        second: convertTimeStampToTimeWithSecsFormat(
                            bank.createdAt!)),
                  ],
                ),
              ),
            ),
            Spacer(),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        color: AppColor.primaryColor100),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: CustomMaterialButton(
                          title: "계좌 삭제",
                          onPressed: () async {
                            if (!bank.isMainAccount!) {
                              setState(() {
                                isLoading = true;
                              });
                              var response = await model.deleteBankAccount(
                                  bankID: bank.uuid!);
                              setState(() {
                                isLoading = false;
                              });
                              if (response['error']) {
                                showCustomSnackBar(
                                    'User Bank Account',
                                    'Bank Account not deleted',
                                    AppColor.dangerColor10);
                              } else {
                                Get.back();
                                Get.back();
                                Get.to(() => UserBankScreen());
                                showCustomSnackBar('User Bank Account',
                                    'Bank Account', AppColor.successColor30);
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      SuperSaveDashboardAlertDialog(
                                          title:
                                              "Main Account cannot be deleted."));
                            }
                          },
                          btnColor: Colors.white,
                          textColor: AppColor.primaryColor100,
                          borderColor: AppColor.primaryColor100,
                        ),
                      ),
                      SizedBox(width: 16),
                      if (!bank.isMainAccount!)
                        Expanded(
                          child: CustomMaterialButton(
                            title: "주계좌로 설정",
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var response = await model.changeMainAccount(
                                  bankID: bank.uuid!);
                              setState(() {
                                isLoading = false;
                              });
                              if (response['error']) {
                                showCustomSnackBar(
                                    'User Bank Account',
                                    'Main Bank Account Not Changed',
                                    AppColor.dangerColor10);
                              } else {
                                Get.back();
                                Get.back();
                                Get.to(() => UserBankScreen());
                                showCustomSnackBar(
                                    'User Bank Account',
                                    'Main Bank Account Changed',
                                    AppColor.successColor30);
                              }
                            },
                            btnColor: AppColor.primaryColor100,
                            textColor: Colors.white,
                          ),
                        ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
