import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/models/super_save/transaction_register_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_input_field.dart';
import '../../../widgets/super_save/credit_sale_edit_widget.dart';
import 'id_prepare_screen.dart';

class ResidentRegistrationScreen extends StatefulWidget {
  const ResidentRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<ResidentRegistrationScreen> createState() =>
      _ResidentRegistrationScreenState();
}

class _ResidentRegistrationScreenState
    extends State<ResidentRegistrationScreen> {
  TextEditingController dobController = TextEditingController();
  TextEditingController regController = TextEditingController();
  bool hasError = false;
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TransactionRegisterModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("SUPER SAVE 거래 등록",
          backArrow: true, center: true, isBottomBorder: true),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        children: [
          CreditSaleEditWidget(
            first: "주민등록번호를 입력해주세요.",
            second: "민감정보는 개인정보보호법에 따라 암호화하여 안전하게 보호됩니다.",
            inverse: true,
          ),
          const SizedBox(height: 24),
          Text(
            "주민등록번호",
            style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: SuperSaveWithoutSuffixTextInputField(
                controller: dobController..text = args.dob!.substring(2),
                align: TextAlign.start,
                hintText: "880102",
                readOnly: true,
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: SuperSaveWithoutSuffixTextInputField(
                align: TextAlign.start,
                controller: regController,
                type: TextInputType.phone,
                error: hasError,
                hintText: "뒤 7자리",
                validator: (String? v) {
                  if (v!.isEmpty) {
                    return "iInput cannot be empty";
                  } else if (v.length != 7) {
                    return "Registration Number must be 7-digits";
                  }
                  return null;
                },
                onChanged: (String? v) {
                  hasError = (v!.isEmpty || v.length != 7);
                  isEnabled = !hasError;
                  setState(() {});
                },
                isObscure: true,
              )),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomMaterialButton(
          title: "다음",
          btnColor: isEnabled ? AppColor.primaryColor100 : AppColor.greyColor20,
          textColor: isEnabled ? Colors.white : AppColor.greyColor40,
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (isEnabled) {
              args.addNationReg("Korean", regController.text);
              Get.to(() => IDPrepareScreen(), arguments: args);
            } else {
              showCustomSnackBar(
                  "Resident Registration",
                  "Registration must have only 7 digits",
                  AppColor.dangerColor10);
            }
          },
        ),
      ),
    );
  }
}
