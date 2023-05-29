import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:get/get.dart';
import '../../../../core/models/super_save/dashboard_model.dart';
import '../../../../core/services/API/super_save_api_service.dart';
import '../../../widgets/super_save/super_save_alert_dialog.dart';
import '../request/credit_sale_application.dart';
import '../transfer_registration/transaction_registeration_main.dart';

class SuperSaveDashboardProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  SuperSaveDashboardModel? dashboardModel;
  bool buy = true;
  DateTime currentTime = DateTime.now();
  bool enabled = false;
  bool mounted = true;
  List disablePopUpErrors = [
    "SUPER SAVE 참여 가능한 외상매도 신청건이 있습니다. 참여 완료 후 다시 신청해주세요",
    "당신은 이미 SUPER SAVE 에 참여했습니다."
  ];
  SuperSaveDashboardProvider() {
    init();
  }
  init() async {
    setState(ViewState.busy);
    await fetchUserDashboardData();
    timer();
    setState(ViewState.idle);
  }

  List<int> calculateDifference(DateTime timestamp, TimeSetting data) {
    var split = data.timeZoneDiff!.split(':');
    int hour = data.isAhead
        ? (timestamp.hour + int.parse(split[0]))
        : timestamp.hour - int.parse(split[0]);
    int minute = data.isAhead
        ? (timestamp.minute + int.parse(split[0]))
        : timestamp.minute - int.parse(split[1]);
    return [hour, minute];
  }

  void timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      tz.initializeTimeZones();
      var seoul = tz.getLocation('GMT');
      DateTime timeStamp = tz.TZDateTime.now(seoul);
      var data = dashboardModel!.timeSetting!;

      var diff = calculateDifference(timeStamp, data);
      timeStamp = timeStamp.copyWith(
        hour: diff[0],
        minute: diff[1],
      );
      int start = int.parse(data.startTime!.split(':')[0]);
      int end = int.parse(data.endTime!.split(':')[0]);

      if (timeStamp.hour >= start && timeStamp.hour < end) {
        enabled = true;
        currentTime = timeStamp.copyWith(
            hour: (end - 1) - timeStamp.hour,
            minute: 59 - timeStamp.minute,
            second: 60 - timeStamp.second);
      } else {
        enabled = false;
        timer.cancel();
      }
      if (mounted) notifyListeners();
    });
  }

  fetchUserDashboardData() async {
    var response = await _superSaveAPIService.fetchDashboardData();
    print(response);
    if (!response['error']) {
      dashboardModel = SuperSaveDashboardModel.fromJSON(response['data']);
    }
    notifyListeners();
  }

  changeTab() {
    buy = !buy;
    notifyListeners();
  }

  refresh() async {
    setState(ViewState.busy);
    await fetchUserDashboardData();
    setState(ViewState.idle);
  }

  routingLogic() {
    var response = {};
    if (enabled) {
      var temp = dashboardModel!.myRequestStatus!;
      if (temp.isTransactionRegistered == 0) {
        response = {
          'route': false,
          'widget': SuperSaveDashboardAlertDialog(
              title: "담당자 확인 후 SUPER SAVE 이용이 가능합니다.")
        };
      } else if (temp.isTransactionRegistered == 2) {
        response = {
          'route': true,
          'widget': TransactionRegistrationMainScreen()
        };
      } else if (temp.isParticipate == 1 && temp.status! < 2) {
        response = {
          'route': false,
          'widget': SuperSaveDashboardAlertDialog(
              title: disablePopUpErrors[temp.status!])
        };
      } else {
        response = {
          'route': true,
          'widget': CreditSaleApplicationScreen(),
          'args': {"possibleToParticipate": dashboardModel!.remainingAmount!}
        };
      }
    } else {
      response = {
        'route': false,
        'widget': SuperSaveDashboardAlertDialog(
            title: "SUPER SAVE가 마감되었습니다. 매일 10시부터 16시까지 신청 가능합니다.")
      };

      return response;
    }
  }

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }
}
