import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/ui/screens/super_save/reserve_history/balance_certificate.dart';
import 'package:msquare_market/v2/ui/screens/super_save/reserve_history/reserve_history_provider.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/functions.dart';
import '../../../../core/models/super_save/reserve_model.dart';

class ReserveHistoryScreen extends StatefulWidget {
  const ReserveHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ReserveHistoryScreen> createState() => _ReserveHistoryScreenState();
}

class _ReserveHistoryScreenState extends State<ReserveHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReserveHistoryProvider(),
      child: Consumer<ReserveHistoryProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("지급준비금",
                backArrow: true, center: true, isBottomBorder: true),
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                        color: AppColor.primaryColor100),
                  )
                : model.reserves.isEmpty
                    ? Center(
                        child: Text(
                          'No Record Found',
                          style: poppinsTextStyle(
                              16, FontWeight.w500, AppColor.greyColor50),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                            child: Text(
                              "총 ${model.reserves.length}건",
                              style: poppinsTextStyle(
                                  16, FontWeight.w600, AppColor.greyColor100),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: model.reserves.length,
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemBuilder: (context, index) {
                                var data = model.reserves[index];
                                return PayOutHistoryWidget(data: data);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 8);
                              },
                            ),
                          ),
                        ],
                      ),
          );
        },
      ),
    );
  }
}

class PayOutHistoryWidget extends StatelessWidget {
  const PayOutHistoryWidget({Key? key, required this.data}) : super(key: key);

  final ReserveModel data;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: commonRoundedRectangularBorder(),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomRowTextWidget(first: "확인일시", second: data.confirmationDate!),
            CustomRowTextWidget(first: "은행", second: data.bank!),
            CustomRowTextWidget(first: "계좌번호", second: data.accountNumber!),
            CustomRowTextWidget(
                first: "계좌잔액", second: priceString(data.accountBalance!) + "원"),
            SizedBox(height: 28),
            CustomMaterialButton(
              title: "잔액증명서 확인",
              textColor: AppColor.primaryColor100,
              btnColor: Colors.white,
              borderColor: AppColor.primaryColor100,
              onPressed: () {
                Get.to(() => BalanceCertificateScreen(),
                    arguments: {"url": data.bankCertificateUrl!});
              },
            )
          ],
        ),
      ),
    );
  }
}
