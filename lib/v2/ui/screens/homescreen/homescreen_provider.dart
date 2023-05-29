import 'dart:async';
import 'dart:developer';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/services/API/user_api_service.dart';
import 'package:msquare_market/v2/core/services/api_services.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/constants/colors.dart';
import '../../../core/device_type.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/user_model.dart';
import '../../components/custom_snackbar.dart';

/// A [ViewModel] that handles data between [Model]s and our [View] which
/// here is [HomeScreen]

class HomeScreenProvider extends BaseViewModal {
  /// [AuthServices] object
  final locateUser = locator<AuthServices>();

  /// [DeviceType] object that handles [Device]'s dimension.
  final locateSize = locator<DeviceType>();

  /// [APIServices] object that handles [API] requests
  final _apiServices = ApiServices();

  /// [MyAppUser] object that handles [User]'s data
  UserModel myAppUser = UserModel();

  /// [Integer] value that changes [Image] Index
  int imageIndex = 0;

  /// [Double] to store total balance
  var availableBalance = 0.00;

  /// value that stores trend values
  var trendValue = 0.00;

  UserAPIServices _userAPI = UserAPIServices();

  IconData trendIcon = Icons.trending_up;
  Color trendColor = successColor30;

  /// [List] of type [string] that helps in handling
  /// password attempts;
  /// - [Index] 0 represents barcode screen
  /// - [Index] 1 represents swap screen
  /// - [Index] 2 represents setting screen
  List<List<String>> passwordAttempts = [];

  /// [Function] that accepts an [argument] of type [integer] and
  /// changes the [Image] index with that [argument]
  changeImageIndex(int x) {
    imageIndex = x;
    notifyListeners();
  }

  /// A [constructor] that calls the [init] function to
  /// initialize the values.
  HomeScreenProvider() {
    init();
  }

  /// [Function] that initialize with:
  /// - [fetchNewBalances]
  /// - [fetchPrices]
  /// - [myAppUser]
  init() async {
    //Stagging and Dev Env Check
    checkEnv();
    setState(ViewState.busy);
    // fetch new balances
    await fetchNewBalances();
    // assign new myAppUser
    myAppUser = locateUser.myAppUser;
    setState(ViewState.idle);
  }

  checkEnv() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build

      if (EndPoints.baseUrl.contains("api.dev")) {
        showPersistentSnackBar(
          "Development Environment",
          "You are browsing in Development Environment, Incase of any issue or bug, include details about your environment in in bug reports\nThis pop-up will not show in production app/env",
        );
      } else if (EndPoints.baseUrl.contains("api.stg")) {
        showPersistentSnackBar(
          "Staging Environment",
          "You are browsing in Staging Environment, Incase of any issue or bug, include details about your environment in bug reports\nThis pop-up will not show in production app/env",
        );
      }
    });
    log("You are in ${EndPoints.baseUrl}");
  }

  ///
  /// TODO:: This part of code seems to be repeated twice
  /// We can abstract his into a service which refreshed balance
  /// making it independent of the view
  ///
  /// [Function] that fetches the [Token] balances from
  /// the [API]
  fetchNewBalances() async {
    try {
      final userTokens = await _userAPI.fetchCurrentUserTokens();
      final pricesData = await _apiServices.getPricesAPi();
      if (userTokens != false && pricesData != false) {
        await locateUser.myAppUser
            .updateTokenInfo(userTokens, pricesData["tokens"]);
      }
      myAppUser = locateUser.myAppUser;
      notifyListeners();
    } catch (e) {
      log("catch@fetchNewBalances ${e.toString()}");
    }
  }

  Stream<void> fetchLiveBalanceAndTrend() async* {
    yield* Stream.periodic(Duration(seconds: 1), (_) async {
      await fetchNewBalances();
    }).asyncMap((event) async => await event);
  }

  /// Function that will issue a request to RPA Device
  /// RPA Device will calculate the user cashbacks
  ///
  syncBalanceCallRPA(BuildContext context) async {
    try {
      final result = await _apiServices.refreshBalanceRPA();
      if (result) {
        showToast(message: "Balance Sync");
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }
}
