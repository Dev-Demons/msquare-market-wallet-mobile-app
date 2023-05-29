import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:msquare_market/v2/core/models/user_model.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';

import 'billing_method_tests.dart';
import 'create_user_tests.dart';
import 'main_screens/history_screeen_tests.dart';
import 'main_screens/home_screen_tests.dart';
import 'login_screen_tests.dart';
import 'main_screens/settings_screen_tests.dart';
import 'onboarding_screen_tests.dart';
import 'main_screens/wallet_screen_tests.dart';
import 'p2p_tests.dart';
import 'qr_transaction_tests.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  //UserModel userData = UserModel();
  setUpAll(() {
    app.main();
  });

  group('App OnBoarding', () {
    testWidgets(
        'Swipe and Next Button Test', OnBoardingTest().testSwipeAndNextButton);
  });
  group('Login Screen', () {
    //testWidgets('Language Change Test', LoginTest().testLanguageChange);
    testWidgets('Google Login Test', LoginTest().testGoogleSocialLogin);
  });
  /*group('Home Screen', () {
    testWidgets(
        'Home Screen Details Test', HomeScreenTest().testHomeScreenDetails);
    testWidgets(
        'Home Screen Scroll Test', HomeScreenTest().testHomeScreenScroll);
    testWidgets('Home Screen Bottom Navigation Test',
        HomeScreenTest().testHomeScreenBottomNavigation);
    testWidgets('Balance RPA Test', HomeScreenTest().testBalanceRPA);
  });*/
  /* group('Wallet Screen', () {

    testWidgets('Details Test', WalletScreenTest().testWalletScreenDetails);
  });*/
  /*group('History Screen', () {
    testWidgets('Data Test', HistoryScreenTest().testHistoryRecords);
    testWidgets('Scroll Test', HistoryScreenTest().testScrolling);
  });*/
  /*group('Create ID and Password Screen', () {
    testWidgets('Create User Test', CreateUserTest().testCreateUser);
  });*/
  /*  group('Settings Screen', () {
    testWidgets('Details Test', SettingScreenTest().testSettingScreenDetails);
    testWidgets('Username Copy Test', SettingScreenTest().testUserNameCopied);
    testWidgets(
        'My Wallet Screen Test', SettingScreenTest().testMyWalletScreen);
    testWidgets('Language Change Test', SettingScreenTest().testLanguageChange);
    testWidgets('Update Password Test', SettingScreenTest().testChangePassword);
    testWidgets('Enable Fingerprint Test',
        SettingScreenTest().testEnableFingerprintAuthentication);
    testWidgets('Disable Fingerprint Test',
        SettingScreenTest().testDisableFingerprintAuthentication);
    testWidgets(
        'Privacy Policy Test', SettingScreenTest().testPrivacyPolicyScreen);
    testWidgets('TnC Test', SettingScreenTest().testTNCScreen);
    testWidgets('Contact Us Test', SettingScreenTest().testContactScreen);

    testWidgets('Logout Test', SettingScreenTest().testLogout);
    testWidgets(
        'Wallet Termination Test', SettingScreenTest().testWalletTermination);
  });*/
  /*group('Billing Method Screen', () {
    testWidgets('Details Test', BillingMethodTest().testBillingScreenDetails);
    testWidgets('Add Card Test', BillingMethodTest().testAddCard);
  });*/
  group('P2P Trading Screens', () {
    //testWidgets('P2P Ad Listings Test', P2PTest().testAdsByUser);
    testWidgets('P2P AD Transaction Test', P2PTest().testP2POrderTransaction);
    // testWidgets('Create P2P Order Test', P2PTest().testCreateP2PAdAndConfirm);
    // testWidgets('Delete P2P Order Test', P2PTest().testDeleteP2PAd);
  });
  /* group('QR Code Transaction', () {
    testWidgets(
        'Camera Permission Test', QRTransactionTest().testCameraPermission);
    testWidgets('QR Transaction Test', QRTransactionTest().testQRTransaction);
  });*/
}
