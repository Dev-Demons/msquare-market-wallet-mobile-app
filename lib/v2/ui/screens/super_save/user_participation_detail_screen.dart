import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/functions.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/models/super_save/participation_detail_model.dart';
import 'package:msquare_market/v2/ui/screens/super_save/check_participation_details_screen.dart';
import 'package:msquare_market/v2/ui/screens/super_save/user_participation_detail_provider.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/AppColor.dart';
import '../../../core/enums/view_state.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/super_save/interest_switch_button.dart';

class UserParticipationDetailScreen extends StatefulWidget {
  const UserParticipationDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserParticipationDetailScreen> createState() =>
      _UserParticipationDetailScreenState();
}

class _UserParticipationDetailScreenState
    extends State<UserParticipationDetailScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserParticipationDetailProvider(),
      child: Consumer<UserParticipationDetailProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.greyColor0,
            appBar: customAppBar("나의 참여금액",
                center: true, backArrow: true, isBottomBorder: true),
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor100,
                    ),
                  )
                : RefreshIndicator(
                    color: AppColor.primaryColor100,
                    onRefresh: () async {
                      await model.fetchSuperSaveHistory();
                    },
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColor.greyColor10,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.greyColor20)),
                          child: Row(
                            children: [
                              InterestSwitchButton(
                                title: "지급 중",
                                selected: selectedIndex == 0,
                                onPressed: () {
                                  selectedIndex = 0;
                                  setState(() {});
                                },
                              ),
                              InterestSwitchButton(
                                title: "지급 완료",
                                selected: selectedIndex == 1,
                                onPressed: () {
                                  selectedIndex = 1;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "총 ${model.history.length}건",
                            style: poppinsTextStyle(
                                16, FontWeight.w600, AppColor.greyColor100),
                          ),
                        ),
                        model.history.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: model.history.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = model.history[index];
                                  return MyContributionCardWidget(model: item);
                                })
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.greyColor30),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "There are no search results",
                                  style: poppinsTextStyle(16, FontWeight.w600,
                                      AppColor.greyColor30),
                                )),
                              ),

                        // MyContributionCardWidget(),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class MyContributionCardWidget extends StatelessWidget {
  const MyContributionCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SuperSaveModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: commonRoundedRectangularBorder(),
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      child: Padding(
        padding: commonPadding(20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColor.primaryColor0,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                "90일",
                style: poppinsTextStyle(
                    12, FontWeight.w500, AppColor.primaryColor100),
              ),
            ),
            CustomRowTextWidget(
                first: "전송수량", second: "10,000MSQ", isBlack: true),
            SuperSaveDividerWidget(),
            CustomRowTextWidget(
                first: "MSQ 외상매도 전 시가총액",
                second:
                    "${priceString(model.depositAmountInWon.toString())} 원"),
            CustomRowTextWidget(
                first: "외상매도 결제대금",
                second: "${priceString(model.totalPayoutAmount.toString())} 원"),
            CustomRowTextWidget(
                first: "일일결제대금",
                second: "${priceString(model.dailyPayoutAmount.toString())} 원"),
            CustomRowTextWidget(
                first: "외상매도 시점 MSQ 시세",
                second:
                    "${priceString(model.depositAmountInMSQ.toString())} MSQ"),
            CustomRowTextWidget(
                first: "외상매도 일시",
                second: convertTimeStampToTimeWithSecsFormat(model.startDate!)),
            CustomRowTextWidget(
                first: "외상대금 결제일시",
                second: convertTimeStampToTimeWithSecsFormat(model.endDate!)),
            SizedBox(height: 24),
            CustomMaterialButton(
              title: "자세히 보기",
              btnColor: Colors.white,
              textColor: AppColor.primaryColor100,
              borderColor: AppColor.primaryColor100,
              onPressed: () {
                Get.to(() => CheckParticipationDetailScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
