import 'package:flutter/material.dart';
import 'package:msquare_market/v2/ui/screens/withdrawal_user/withdrawal_user_rules.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/credit_sale_edit_widget.dart';
import '../../../core/constants/AppColor.dart';
import '../../../core/constants/style.dart';
import '../../widgets/custom_button.dart';
import 'package:get/get.dart';

class WithdrawalUser extends StatefulWidget {
  const WithdrawalUser({Key? key}) : super(key: key);

  @override
  State<WithdrawalUser> createState() => _WithdrawalUserState();
}

class _WithdrawalUserState extends State<WithdrawalUser> {
  String? selected;
  TextEditingController boxController = TextEditingController();
  final list = ["앱을 사용하지 않음", "오류로 사용이 불편함", "사용법이 어려움", "직접 입력"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // custom app bar
      appBar: customAppBar("서비스 탈퇴", backArrow: true, center: true),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          CreditSaleEditWidget(
            first: "탈퇴 사유를 입력해주세요.",
            second: "",
            inverse: true,
          ),
          ...list.map(
            (e) => ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 0,
              dense: true,
              visualDensity: VisualDensity(horizontal: -4),
              leading: Radio(
                visualDensity: VisualDensity(horizontal: -4),
                value: e,
                groupValue: selected,
                onChanged: (String? v) {
                  setState(() {
                    selected = v;
                  });
                },
              ),
              title: Text(
                e,
                style: poppinsTextStyle(
                    14, FontWeight.w500, AppColor.greyColor100),
              ),
            ),
          ),
          list.indexOf(selected ?? "앱을 사용하지 않음") == 3
              ? CustomTextInputField(
                  controller: boxController,
                  keyboard: TextInputType.text,
                  hintText: "사유 입력",
                  maxLines: 7,
                )
              : const SizedBox(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: CustomMaterialButton(
          title: "확인",
          onPressed: () {
            if (selected != null)
              Get.to(() => WithdrawalUserRules(),
                  arguments: {"reason": selected!, "desc": boxController.text});
          },
          btnColor: selected == null
              ? AppColor.greyColor10
              : AppColor.primaryColor100,
          textColor: selected == null ? AppColor.greyColor40 : Colors.white,
        ),
      ),
    );
  }
}
