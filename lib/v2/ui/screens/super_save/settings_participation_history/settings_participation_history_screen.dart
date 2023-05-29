import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/screens/super_save/settings_participation_history/participation_history_provider.dart';
import 'package:msquare_market/v2/ui/widgets/custom_app_bar.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_expansion_tile.dart';
import 'package:msquare_market/v2/ui/widgets/super_save/custom_row_text-widget.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/AppColor.dart';
import '../../../../core/enums/view_state.dart';
import '../../../widgets/super_save/consumption_rate_tile.dart';
import '../../../widgets/super_save/daily_participation_list_tile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SettingsParticipationHistoryScreen extends StatefulWidget {
  const SettingsParticipationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SettingsParticipationHistoryScreen> createState() =>
      _SettingsParticipationHistoryScreenState();
}

class _SettingsParticipationHistoryScreenState
    extends State<SettingsParticipationHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ParticipationHistoryProvider(),
        child: Consumer<ParticipationHistoryProvider>(
            builder: (context, model, child) {
          return Scaffold(
            appBar: customAppBar("SUPER SAVE 지급내역",
                backArrow: true, center: true, isBottomBorder: true),
            backgroundColor: Colors.white,
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor100,
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "참여 현황 총 2건",
                              style: poppinsTextStyle(
                                  16, FontWeight.w600, AppColor.greyColor100),
                            ),
                            Text(
                              "참여중 기준",
                              style: poppinsTextStyle(
                                  16, FontWeight.w500, AppColor.greyColor50),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        elevation: 0,
                        shape: commonRoundedRectangularBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              CustomRowTextWidget(
                                  first: "총 지급완료 외상대금",
                                  second:
                                      "${model.participationHistoryModel!.totalPayout!}원"),
                              CustomRowTextWidget(
                                  first: "총 잔여 외상대금",
                                  second:
                                      "${model.participationHistoryModel!.remainingBalance!}원"),
                              CustomRowTextWidget(
                                  first: "총 일일균등지급금",
                                  second:
                                      "${model.participationHistoryModel!.dailyPayout!}원"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      PieChart(
                        dataMap: {
                          "지급예정 금액": 69.79,
                          "지급완료 금액": 30.21,
                        },
                        chartType: ChartType.ring,
                        colorList: [
                          AppColor.primaryColor20,
                          AppColor.primaryColor100,
                        ],
                        chartRadius: 100,
                        ringStrokeWidth: 28,
                        degreeOptions: DegreeOptions(initialAngle: -90),
                        chartValuesOptions: ChartValuesOptions(
                            decimalPlaces: 2,
                            chartValueBackgroundColor: Colors.white,
                            chartValueStyle: poppinsTextStyle(
                                12, FontWeight.w500, AppColor.greyColor100),
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true),
                        legendOptions: LegendOptions(showLegends: false),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Spacer(),
                            ChartLegendWidget(
                                label: "지급완료 금액",
                                color: AppColor.primaryColor100),
                            ChartLegendWidget(
                                label: "지급예정 금액",
                                color: AppColor.primaryColor20),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "참여 건별 지급 현황 총 2건",
                              style: poppinsTextStyle(
                                  16, FontWeight.w600, AppColor.greyColor100),
                            ),
                            Text(
                              "참여중 기준",
                              style: poppinsTextStyle(
                                  16, FontWeight.w500, AppColor.greyColor50),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: ConsumptionRateTile(
                            title: "10,000MSQ (전송일시 01-02 09:00)",
                            percent: 10.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ConsumptionRateTile(
                            title: "10,000MSQ (전송일시 01-02 09:00)", percent: 15),
                      ),
                      SizedBox(height: 40),
                      StickyHeader(
                        header: Material(
                          color: Colors.white,
                          child: ListTile(
                            shape: commonRoundedRectangularBorder(radius: 0),
                            tileColor: Colors.white,
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            horizontalTitleGap: 0,
                            visualDensity: VisualDensity(horizontal: -4),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            title: Text(
                              "지급내역",
                              style: poppinsTextStyle(
                                  16, FontWeight.w600, AppColor.greyColor100),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "2023-03",
                                  style: poppinsTextStyle(16, FontWeight.w500,
                                      AppColor.greyColor50),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerRight,
                                    onPressed: () async {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 200,
                                              color: Colors.white,
                                              child: CupertinoDatePicker(
                                                  onDateTimeChanged: (v) {},
                                                  initialDateTime:
                                                      DateTime(2022),
                                                  maximumDate: DateTime(2030),
                                                  mode: CupertinoDatePickerMode
                                                      .date),
                                            );
                                          });
                                    },
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColor.greyColor50,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        content: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "- 결제대금 지급기간 동안 일일 분할지급 되며, 매주 월요일 주간 정산하며 지급됩니다.",
                                style: poppinsTextStyle(
                                    14, FontWeight.w400, AppColor.greyColor50),
                              ),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "2023-03-01",
                                    style: poppinsTextStyle(16, FontWeight.w600,
                                        AppColor.greyColor100),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: "누적지급금 ",
                                        style: poppinsTextStyle(
                                            16,
                                            FontWeight.w500,
                                            AppColor.greyColor50),
                                        children: [
                                          TextSpan(
                                            text: "400,000원",
                                            style: poppinsTextStyle(
                                                16,
                                                FontWeight.w600,
                                                AppColor.greyColor100),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            SuperSaveDividerWidget(vertical: 12),
                            DailyParticipationListTile(),
                            SizedBox(height: 48),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "2023-03-01",
                                    style: poppinsTextStyle(16, FontWeight.w600,
                                        AppColor.greyColor100),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: "누적지급금 ",
                                        style: poppinsTextStyle(
                                            16,
                                            FontWeight.w500,
                                            AppColor.greyColor50),
                                        children: [
                                          TextSpan(
                                            text: "400,000원",
                                            style: poppinsTextStyle(
                                                16,
                                                FontWeight.w600,
                                                AppColor.greyColor100),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            SuperSaveDividerWidget(vertical: 12),
                            DailyParticipationListTile(),
                            DailyParticipationListTile(),
                            DailyParticipationListTile(),
                            DailyParticipationListTile(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomExpansionTile(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        }));
  }
}

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker({
    required DateTime currentTime,
    required DateTime minTime,
    required DateTime maxTime,
  }) : super(minTime: minTime, maxTime: maxTime, currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}

class ChartLegendWidget extends StatelessWidget {
  const ChartLegendWidget({Key? key, required this.label, required this.color})
      : super(key: key);
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        horizontalTitleGap: 16,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        leading: Container(color: color, width: 16, height: 16),
        title: Text(
          label,
          style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
        ),
      ),
    );
  }
}
