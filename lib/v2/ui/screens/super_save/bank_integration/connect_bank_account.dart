import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/core/models/super_save/transaction_register_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';
import 'package:msquare_market/v2/ui/screens/settings/success_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/bank_integration/bank_selection_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/super_save_result_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_details.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_provider.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_bank/user_bank_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/dialogues/custom_alert_dialog.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/credit_sale_edit_widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/super_save_alert_dialog.dart';

import '../../../../core/constants/borders.dart';

class ConnectBankAccount extends StatefulWidget {
  const ConnectBankAccount({Key? key}) : super(key: key);

  @override
  State<ConnectBankAccount> createState() => _ConnectBankAccountState();
}

class _ConnectBankAccountState extends State<ConnectBankAccount> {
  bool isHint = true;
  String? bankName;
  TextEditingController accountController = TextEditingController();
  bool isLoading = false;
  bool isEnabled = false;
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("SUPER SAVE 거래 등록",
          backArrow: true, center: true, isBottomBorder: true),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          CreditSaleEditWidget(
            inverse: true,
            first: "계좌를 등록해주세요.",
            second: "지급금 입금 및 양도소득세 정산을 위해 필요합니다.",
          ),
          SizedBox(height: 24),
          Text("은행 선택"),
          SizedBox(height: 8),
          ListTile(
            onTap: () async {
              var result = await Get.to(() => BankSelectionScreen());
              if (result != null) {
                bankName = result.toString();
              }
              setState(() {});
            },
            shape: commonRoundedRectangularBorder(),
            contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
            dense: true,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            minVerticalPadding: 0,
            minLeadingWidth: 0,
            title: Text(
              bankName ?? "은행 선택",
              style: TextStyle(
                  color: bankName == null
                      ? AppColor.greyColor50
                      : AppColor.greyColor100),
            ),
            trailing: IconButton(
              onPressed: () async {
                var result = await Get.to(() => BankSelectionScreen());
                if (result != null) {
                  bankName = result.toString();
                }
                setState(() {});
              },
              icon:
                  Icon(Icons.keyboard_arrow_down, color: AppColor.greyColor100),
            ),
          ),
          SizedBox(height: 16),
          Text("계좌번호 입력"),
          SizedBox(height: 8),
          SuperSaveCustomTextInputField(
            hintText: "숫자만 입력",
            suffix: "",
            type: TextInputType.phone,
            align: TextAlign.start,
            error: hasError,
            controller: accountController,
            validator: (String? v) {
              if (v!.isEmpty) {
                return "Input cannot be empty";
              } else if (v.length != 13) {
                return "Account Number must be 13-digits";
              }
              return null;
            },
            onChanged: (String? v) {
              hasError = (v!.isEmpty || v.length != 13);
              isEnabled = !hasError;
              setState(() {});
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor100,
                ),
              )
            : CustomMaterialButton(
                title: "확인",
                textColor: Colors.white,
                btnColor: AppColor.primaryColor100,
                borderColor: null,
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final args = ModalRoute.of(context)!.settings.arguments;
                  if (isEnabled) {
                    if (args is TransactionRegisterModel) {
                      setState(() {
                        isLoading = true;
                      });
                      var response = await SuperSaveAPIService()
                          .registerTransaction(requestModel: args);
                      setState(() {
                        isLoading = false;
                      });
                      if (response['error']) {
                        showCustomSnackBar('Transaction Registration',
                            response['data'], AppColor.dangerColor10);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SuperSaveDashboardAlertDialog(
                                title: "계좌 등록이 완료되었습니다.",
                                onPressed: () {
                                  Get.to(
                                    () => SuperSaveResultScreen(
                                      first: "거래 등록이 완료되었습니다.",
                                      second:
                                          "영업일 기준 1일 이내로\n담당자가 등록된 정보를 확인하며\n등록 완료 시 SUPER SAVE가 가능합니다.",
                                    ),
                                  );
                                },
                              );
                            });
                      }
                    } else {
                      final model = args as UserBankProvider;
                      setState(() {
                        isLoading = true;
                      });
                      var result = await model.addBankAccount(
                          name: bankName!, account: accountController.text);
                      if (result['error']) {
                        showCustomSnackBar('Bank Account',
                            'Bank Account not added', AppColor.dangerColor10);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SuperSaveDashboardAlertDialog(
                                  title: "계좌 등록이 완료되었습니다.",
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                    Get.to(() => UserBankScreen());
                                  });
                            });
                      }
                      setState(() {
                        isLoading = true;
                      });
                    }
                  } else {
                    showCustomSnackBar(
                        "Bank Account",
                        "Please provide 13-digit account number",
                        AppColor.dangerColor10);
                  }
                },
              ),
      ),
    );
  }
}
