import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/core/services/deep_link_payment.dart';
import 'package:msquare_market/v2/ui/screens/authentications/createid/create_id.dart';
import 'package:msquare_market/v2/ui/screens/authentications/login/login_screen.dart';
import 'package:msquare_market/v2/ui/screens/payment/mobile_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/locator_services/internet_connectivity_service.dart';
import '../../core/services/locator_services/password_attempt.dart';
import './onboarding/onboarding_screen.dart';
import "./homescreen/base_screen.dart";
import 'fallback_error/no_internet_screen.dart';

/// A [Screen]/[Model] made up of type [StatelessWidget]
/// that displays the designed splash screen

class SplashScreenV2 extends StatefulWidget {
  @override
  State<SplashScreenV2> createState() => _SplashScreenV2State();
}

class _SplashScreenV2State extends State<SplashScreenV2> {
  /// A [boolean] that acts as flag to handle onBoarding Screens.
  bool? onBoarding = false;

  final _internetService = locator<InternetConnectivityService>();
  final _authServices = locator<AuthServices>();
  @override
  void initState() {
    super.initState();
    // calls load preferences
    loadPrefs();
    // calls delay function
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      delay();
    });
  }

  /// [Function] that initializes [SharedPreferences] and checks
  /// onboarding in local storage.
  loadPrefs() async {
    // initialize shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // fetch and save onboarding from local
    onBoarding = prefs.getBool("onBoarding");
    print("onBoarding = $onBoarding");
  }

  /// [Function] that navigates [User] to specific page on the basis
  /// of:
  /// - [User] is logged in and [User]'s ID is created navigate to
  /// [BottomNavigation]
  /// - [User] is logged in and [User]'s ID is not created navigate
  /// to [CreateIdScreen]
  /// - [User] has already onboarded than navigate to [LoginScreen]
  /// - [User] has not onboarded than navigate to [OnBoardingScreen]
  delay() async {
    _internetService.init();
    if (await _internetService.checkConnection()) {
      Get.offAll(() => NoInternetScreen());
    } else {
      // / [AuthServices] object that handles [User]'s authentications

      await _authServices.init();
      locator<PasswordAttempt>();
      //await Future.delayed(Duration(seconds: 3));
      // check user is logged in and has created ID screen
      if (_authServices.isLogin && _authServices.isIdCreated) {
        // Navigate to Bottom Navigation
        if (locator<DeepLinkPayment>().hasDeepLink) {
          Get.offAll(() => MobilePaymentScreen());
        } else {
          Get.offAll(() => BottomNavigation(indexValue: 0));
        }
      }
      // check user is logged in and has not created ID screen
      else if (_authServices.isLogin && !_authServices.isIdCreated) {
        // Navigate to Create ID Screen
        Get.offAll(() => CreateIdScreen());
      } else {
        //check user has onboarding
        if (onBoarding != null && onBoarding == true) {
          // Navigate to Login Screen
          Get.offAll(() => LoginScreen());
        } else {
          // Navigate to OnBoarding Screen
          Get.offAll(() => OnBoardingScreen());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          //Splash logo
          Image.asset(
            "assets/v2/splashlogo.png",
            scale: 1.2,
          ),
        ],
      ),
    );
  }
}
