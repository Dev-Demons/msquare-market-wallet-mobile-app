import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/functions.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/ui/screens/super_save/dashboard/announcement_guide.dart';
import 'package:msquare_market/v2/ui/screens/super_save/dashboard/super_save_dashboard_provider.dart';
import 'package:msquare_market/v2/ui/screens/super_save/request/credit_sale_application.dart';
import 'package:msquare_market/v2/ui/screens/super_save/reserve_history/reserve_history_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/borders.dart';
import '../../../widgets/super_save/consumption_rate_tile.dart';
import '../../../widgets/super_save/dashboard_widgets/completed_participation_widget.dart';
import '../../../widgets/super_save/dashboard_widgets/possible_participation_widget.dart';
import '../../../widgets/super_save/stake_info_tile.dart';

import '../../../widgets/super_save/super_save_alert_dialog.dart';
import '../request/credit_sale_screen.dart';
import '../transfer_registration/transaction_registeration_main.dart';
import '../user_participation_detail_screen.dart';

class SuperSaveMainScreen extends StatefulWidget {
  const SuperSaveMainScreen({Key? key}) : super(key: key);

  @override
  State<SuperSaveMainScreen> createState() => _SuperSaveMainScreenState();
}

class _SuperSaveMainScreenState extends State<SuperSaveMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SuperSaveDashboardProvider(),
      child: Consumer<SuperSaveDashboardProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.greyColor0,
            appBar: SuperSaveAppBar(
                title: SvgPicture.asset('assets/super_save/logo.svg'),
                backArrow: false),
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor100,
                    ),
                  )
                : RefreshIndicator(
                    color: AppColor.primaryColor100,
                    onRefresh: () async {
                      await model.fetchUserDashboardData();
                    },
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 20),
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              stops: [0.2, 0.9],
                              end: Alignment.topRight,
                              colors: [
                                AppColor.primaryColor100,
                                AppColor.superSaveGradientSecondColor,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    convertCurrentTimeStampToTimeFormat(),
                                    style: poppinsTextStyle(
                                        14, FontWeight.w400, Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: model.refresh,
                                        child: Text(
                                          "새로고침",
                                          style: poppinsTextStyle(14,
                                              FontWeight.w400, Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: model.refresh,
                                        child: Icon(Icons.refresh,
                                            color: Colors.white, size: 16),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: StakeInfoTile(
                                  title: "지급준비금",
                                  subtitle: convertAmountToWon(
                                      model.dashboardModel!.reserves!),
                                  onPressed: () {
                                    Get.to(() => ReserveHistoryScreen());
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: StakeInfoTile(
                                        title: "전체참여금액",
                                        subtitle: convertAmountToWon(model
                                            .dashboardModel!
                                            .totalParticipationAmount!)),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: StakeInfoTile(
                                      title: "참여가능한도",
                                      subtitle: convertAmountToWon(model
                                          .dashboardModel!.remainingAmount!),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 200,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 12),
                                                        height: 4,
                                                        width: 44,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColor
                                                              .greyColor20,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "참여가능한도 안내",
                                                          style: poppinsTextStyle(
                                                              20,
                                                              FontWeight.w700,
                                                              AppColor
                                                                  .greyColor100),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          icon: Icon(
                                                            Icons.close,
                                                            size: 32,
                                                            color: AppColor
                                                                .greyColor30,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                      child: Text(
                                                        "참여가능한도는 매일 갱신되며, 매일 지급되는 일일균등지급금 만큼 한도가 복원됩니다.",
                                                        style: poppinsTextStyle(
                                                            14,
                                                            FontWeight.w400,
                                                            AppColor
                                                                .greyColor50),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ConsumptionRateTile(
                                    title: "지급준비금 소진율",
                                    percent:
                                        model.dashboardModel!.consumptionRate!),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Card(
                            shape: commonRoundedRectangularBorder(),
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CustomRowTextWidget(
                                      first: "나의 잔여 외상대금",
                                      second: model.dashboardModel!
                                          .userSuperSave!.remainingBalance!),
                                  CustomRowTextWidget(
                                      first: "나의 일일균등지급금",
                                      second: model.dashboardModel!
                                          .userSuperSave!.myDailyPayout!),
                                  ConsumptionRateTile(
                                    isDashboard: true,
                                    title: "외상대금 지급율",
                                    percent: model
                                        .dashboardModel!
                                        .userSuperSave!
                                        .creditedAmountPercentage!,
                                    weight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 24),
                                  MaterialButton(
                                    onPressed: () {
                                      Get.to(() =>
                                          UserParticipationDetailScreen());
                                    },
                                    elevation: 0,
                                    textColor: AppColor.primaryColor100,
                                    padding: commonPadding(20, 16),
                                    shape: commonMaterialButtonBorder(
                                        color: AppColor.primaryColor100),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("자세히 보기"),
                                        SizedBox(width: 12),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            tileColor: model.enabled
                                ? AppColor.primaryColor100
                                : AppColor.greyColor30,
                            onTap: () {
                              var result = model.routingLogic();
                              if (result['route']) {
                                Get.to(
                                  () => result['widget'],
                                  arguments: result.contains('args')
                                      ? result['args']
                                      : {},
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return result['widget'];
                                  },
                                );
                              }
                            },
                            dense: true,
                            shape: commonRoundedRectangularBorder(),
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            minVerticalPadding: 0,
                            minLeadingWidth: 0,
                            horizontalTitleGap: 16,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            leading: SvgPicture.asset(
                                'assets/super_save/clipboard.svg'),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SUPER SAVE 신청하기",
                                  style: poppinsTextStyle(
                                      14, FontWeight.w500, Colors.white),
                                ),
                                Text(
                                  model.enabled
                                      ? convertTimeStampToTime(
                                          model.currentTime)
                                      : "",
                                  style: poppinsTextStyle(
                                      14, FontWeight.w500, Colors.white),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        // Announcement Guide
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: ListTile(
                            onTap: () {
                              var temp = model.dashboardModel!.myRequestStatus!;
                              Get.to(() => AnnouncementGuideScreen(),
                                  arguments: {
                                    'isTransactionRegistered':
                                        temp.isTransactionRegistered,
                                    "possibleToParticipate":
                                        model.dashboardModel!.remainingAmount!,
                                    "displayTimePopup": !model.enabled,
                                    "displayPopUpError": (temp.isParticipate ==
                                                1 &&
                                            temp.status! < 2)
                                        ? model.disablePopUpErrors[temp.status!]
                                        : "",
                                  });
                            },
                            leading: SvgPicture.asset(
                                'assets/super_save/speaker.svg'),
                            tileColor: Colors.white,
                            dense: true,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            horizontalTitleGap: 16,
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: commonRoundedRectangularBorder(),
                            title: Text("SUPER SAVE 이용가이드",
                                style: poppinsTextStyle(14, FontWeight.w500,
                                    AppColor.greyColor100)),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: AppColor.greyColor100, size: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                color: AppColor.greyColor10,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColor.greyColor20)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                      onPressed: () {
                                        model.changeTab();
                                      },
                                      shape: commonRoundedRectangularBorder(
                                          hasColor: false),
                                      elevation: 0,
                                      child: Text(
                                        "참여가능",
                                        style: poppinsTextStyle(
                                            14,
                                            FontWeight.w500,
                                            model.buy
                                                ? Colors.white
                                                : AppColor.greyColor50),
                                      ),
                                      color: model.buy
                                          ? AppColor.primaryColor100
                                          : AppColor.greyColor10),
                                ),
                                Expanded(
                                  child: MaterialButton(
                                      onPressed: () {
                                        model.changeTab();
                                      },
                                      shape: commonRoundedRectangularBorder(
                                          hasColor: false),
                                      elevation: 0,
                                      child: Text(
                                        "참여완료",
                                        style: poppinsTextStyle(
                                            14,
                                            FontWeight.w500,
                                            model.buy
                                                ? AppColor.greyColor50
                                                : Colors.white),
                                      ),
                                      color: model.buy
                                          ? AppColor.greyColor10
                                          : AppColor.primaryColor100),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: model.buy
                              ? PossibleParticipationWidget(
                                  possibleParticipation: model
                                      .dashboardModel!.possibleParticipation!)
                              : CompletedParticipationWidget(
                                  completedParticipation: model
                                      .dashboardModel!.completedParticipation!),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
