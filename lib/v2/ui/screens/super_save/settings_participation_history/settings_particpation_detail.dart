import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_expansion_tile.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';

import '../../../widgets/divider_widget.dart';

class SettingsParticipationDetailScreen extends StatefulWidget {
  const SettingsParticipationDetailScreen({Key? key}) : super(key: key);

  @override
  State<SettingsParticipationDetailScreen> createState() =>
      _SettingsParticipationDetailScreenState();
}

class _SettingsParticipationDetailScreenState
    extends State<SettingsParticipationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor0,
      appBar: CustomAppBarWithClose(title: "거래확인증"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Text(
            "거래정보",
            style: poppinsTextStyle(20, FontWeight.w700, AppColor.greyColor100),
          ),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: commonRoundedRectangularBorder(),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  DetailRowTextWidget(first: "거래번호", second: "111-22-3333333"),
                  DetailRowTextWidget(first: "거래유형", second: "입금"),
                  DetailRowTextWidget(
                      first: "거래명", second: "10,000MSQ(전송일시 01-03 09:00)"),
                  DetailRowTextWidget(first: "지급금액", second: "200,000원"),
                  DetailRowTextWidget(first: "받는사람", second: "홍길동"),
                  DetailRowTextWidget(first: "은행명", second: "하나둘은행"),
                  DetailRowTextWidget(first: "계좌번호", second: "123-45-67890"),
                  DetailRowTextWidget(
                      first: "거래일시", second: "2023-01-01 09:00:00"),
                  SuperSaveDividerWidget(),
                  DetailRowTextWidget(first: "보낸사람", second: "엠스퀘어글로벌주식회사"),
                  DetailRowTextWidget(first: "대표자명", second: "최병호"),
                  DetailRowTextWidget(first: "사업자등록번호", second: "117-86-02275"),
                  DetailRowTextWidget(
                      first: "주소", second: "서울시 서초구 강남대로53길 88층 2-11호"),
                ],
              ),
            ),
          ),
          Text(
            "- 위의 내용이 정상적으로 거래되었음을 확인합니다.",
            style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
          ),
          SizedBox(height: 12),
          Text(
            "- 거래확인증은 고객 편의를 위해 제공되는 것으로,현금영수증, 매출전표 등 증빙서류로 사용하실 수 없습니다.",
            style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
          ),
          SizedBox(height: 12),
          Text(
            "- 본 확인증을 임의로 위·변조하여 행사할 경우 형법(제251조 및 234조)에 따라 처벌받을 수 있습니다.",
            style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
          ),
        ],
      ),
    );
  }
}
