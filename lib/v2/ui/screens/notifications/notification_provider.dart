import 'dart:convert';

import 'package:msquare_market/v2/core/device_type.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/models/notification_model.dart';
import 'package:msquare_market/v2/core/services/API/user_api_service.dart';
import 'package:msquare_market/v2/core/services/api_services.dart';
import 'package:flutter/material.dart';
import '../../../../locator.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/history.dart';

class NotificationProvider extends BaseViewModal {
  UserAPIServices _userAPIServices = UserAPIServices();
  List<NotificationResponse> notifications = [];
  NotificationProvider() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    await fetchAnnouncements();
    setState(ViewState.idle);
  }

  fetchAnnouncements() async {
    var result = await _userAPIServices.announcement();
    if (result['error']) {
      notifications = [];
    } else {
      for (var item in result['data']) {
        notifications
            .add(NotificationResponse.fromJson(jsonDecode(item['data'])));
      }
    }
  }
}
