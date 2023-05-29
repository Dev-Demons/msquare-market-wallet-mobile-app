import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../login_screen_tests.dart';
import '../utils.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:get/get.dart';

class SettingScreenTest {
  bool isPolygon = true;
  Future<void> testSettingScreenDetails(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");
    expect(find.text(locator<AuthServices>().myAppUser.name!), findsOneWidget);
    print("✓ Username is there");
    await genericScroll(tester, find.text('logout'.tr));
    print("✓ Details Test Passed");
  }

  Future<void> testUserNameCopied(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");
    await genericOnTap(tester,
        find.text(locator<AuthServices>().myAppUser.name!), "Username Copy");
    expect(find.text('username_copied'.tr), findsOneWidget);
    print("✓ Username Copy Test Passed");
  }

  Future<void> testMyWalletScreen(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");
    await genericOnTap(
        tester, find.text('my_wallet'.tr), "My Wallet Screen Pressed");
    expect(find.text('my_wallet'.tr), findsOneWidget);
    expect(find.text("Polygon Chain"), findsOneWidget);
    await checkChainWalletInformation(tester);
    print("✓ Polygon Chain Copy Address Check Passed");
    expect(find.text("Beacon Chain"), findsOneWidget);
    isPolygon = false;
    await checkChainWalletInformation(tester);
    print("✓ Beacon Chain Copy Address Check Passed");
    await genericOnTap(
        tester, find.byIcon(Icons.arrow_back), "Back Arrow Pressed");
  }

  Future<void> testLanguageChange(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");
    await checkLanguageChange(tester, "Chinese", "应用语言");
    await checkLanguageChange(tester, "Japanese", "アプリの言語");
    await checkLanguageChange(tester, "Korean", "앱 언어");
    await checkLanguageChange(tester, "English", "My Language");
    print("✓ Language Change Test Passed");
  }

  Future<void> testPrivacyPolicyScreen(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await tester.scrollUntilVisible(find.text("privacy_policy".tr), 10);
    await genericOnTap(tester, find.text("privacy_policy".tr),
        "Privacy Policy Button Pressed");
    expect(find.text("privacy_policy".tr), findsOneWidget);
    expectLater(
        find.text("https://msq.market/privacy-policy.html"), findsOneWidget);
    print("✓ Arrived on Privacy Policy WebView Check Passed");
    expectLater(find.byType(WebView), findsOneWidget);
    print("✓ Content Loaded in WebView Check Passed");

    await genericOnTap(
        tester, find.byIcon(Icons.arrow_back), "Back Arrow Pressed");
  }

  Future<void> testTNCScreen(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await tester.scrollUntilVisible(find.text("terms_and_conditions".tr), 10);
    await genericOnTap(
        tester, find.text("terms_and_conditions".tr), "T&C Button Pressed");

    expect(find.text("terms_and_conditions".tr), findsOneWidget);
    expectLater(find.text("https://api.dev.msq.market/terms-and-conditions"),
        findsOneWidget);
    print("✓ Arrived on T&C WebView Check Passed");
    expectLater(find.byType(WebView), findsOneWidget);
    print("✓ Content Loaded in WebView Check Passed");

    await genericOnTap(
        tester, find.byIcon(Icons.arrow_back), "Back Arrow Pressed");
  }

  Future<void> testContactScreen(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await tester.scrollUntilVisible(find.text("contact_us".tr), 5);
    await genericOnTap(
        tester, find.text('contact_us'.tr), "Contact Us Button Pressed");
    expect(find.text("contact_us_title".tr), findsOneWidget);
    print("✓ Arrived on Contact Us Screen Check Passed");
    expect(find.byType(CustomTextInputField), findsNWidgets(3));
    print("✓ Text Input Fields Check Passed");
    await genericEnterText(tester, find.byType(CustomTextInputField).at(0),
        "Error in Settings Screen");
    await genericEnterText(
        tester, find.byType(CustomTextInputField).at(1), "test@gmail.com");
    await genericEnterText(tester, find.byType(CustomTextInputField).at(2),
        "Simple Test to check whether the contact screen is working or not");
    await genericOnTap(
        tester, find.text("Send"), "Contact Screen Response Sent Check Passed");

    expect(find.text("contact_us_error_1".tr), findsOneWidget);
    print("✓ Contact Screen Response Success Check Passed");

    await genericOnTap(
        tester, find.byIcon(Icons.arrow_back), "Back Arrow Pressed");
    await genericOnTap(
        tester, find.byIcon(Icons.arrow_back), "Back Arrow Pressed");
    expect(find.text('settings'.tr), findsNWidgets(2));
  }

  Future<void> testLogout(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await tester.scrollUntilVisible(find.text("logout".tr), 5);
    await genericOnTap(tester, find.text('logout'.tr), "Logout Button Pressed");
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "Sign in with Google"),
        findsOneWidget);
    print("✓ After Logout Landed on Login Screen Check Passed");
  }

  Future<void> testEnableFingerprintAuthentication(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await genericOnTap(
        tester, find.byType(CupertinoSwitch), "FingerPrint Button Pressed");
    await genericEnterText(
        tester, find.byType(CustomTextInputField), "asdf1234#S");
    await genericOnTap(tester, find.text('ok'.tr), "OK Button Pressed");

    expect(find.text("Password Authenticated and Fingerprint Enabled"),
        findsOneWidget);
    await tester.pumpAndSettle();
    Get.closeAllSnackbars();
    print("✓ Fingerprint Enable Test Passed");
  }

  Future<void> testDisableFingerprintAuthentication(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await genericOnTap(
        tester, find.byType(CupertinoSwitch), "FingerPrint Button Pressed");
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));

    expect(find.text("Fingerprint Disable Successful"), findsOneWidget);

    await tester.pumpAndSettle();
    Get.closeAllSnackbars();
    print("✓ Fingerprint Disable Test Passed");
  }

  Future<void> testWalletTermination(WidgetTester tester) async {
    await LoginTest().testGoogleSocialLogin(tester);
    await genericOnTap(tester, find.text('Settings'), "Settings Tab Pressed");
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await tester.scrollUntilVisible(find.text("wallet_termination".tr), 5);
    await genericOnTap(tester, find.text("wallet_termination".tr),
        "Wallet Termination Button Pressed");

    expect(find.text("wallet_termination_screen".tr), findsOneWidget);
    print("✓ Arrived on Wallet Termination Screen");

    await genericEnterText(
        tester, find.byType(CustomTextInputField), "asdf1234#S");
    await genericOnTap(tester, find.text('ok'.tr), "OK Button Pressed");

    expect(find.text('wallet_successfully_terminated'.tr), findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "Sign in with Google"),
        findsOneWidget);
    print("✓ After Wallet Termination Landed on Login Screen");
    print("✓ Wallet Termination Test Passed");
  }

  Future<void> testChangePassword(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));
    expect(find.text("user_name".tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await genericOnTap(tester, find.text("change_password".tr),
        "Change Password Button Pressed");

    expect(find.text("change_password".tr), findsOneWidget);
    print("✓ Arrived on Change Password Screen");

    await genericEnterText(
        tester, find.byType(CustomTextInputField).at(0), "asdf1234#S");
    await genericEnterText(
        tester, find.byType(CustomTextInputField).at(1), "asdf1234#S");
    await genericEnterText(
        tester, find.byType(CustomTextInputField).at(2), "asdf1234#S");
    await genericOnTap(tester, find.text('update_password'.tr),
        "Update Password Button Pressed");

    expect(find.text('pass_change_fail'.tr), findsNothing);
    expect(find.text('invalid_password'.tr), findsNothing);
    expect(find.text('Password Changed!'), findsOneWidget);

    print("✓ After Update Password Landed on Success Screen");
    print("✓ Update Password Test Passed");
  }

  Future<void> checkLanguageChange(
      WidgetTester tester, String language, String compare) async {
    await genericOnTap(
        tester, find.text('app_language'.tr), "My Language Button Pressed");
    await genericOnTap(
        tester, find.text(language), "Language Changed to $language");
    expect(find.text(compare), findsOneWidget);
    print("✓ $language Language Change Check Passed");
  }

  Future<void> checkChainWalletInformation(WidgetTester tester) async {
    await genericOnTap(
        tester,
        isPolygon ? find.text('Scan QR').first : find.text('Scan QR').last,
        'Scan QR Button Pressed');

    expect(find.byIcon(Icons.close), findsOneWidget);
    print(
        " ✓ Arrived on Copy Address Screen for ${isPolygon ? 'Polygon Chain' : 'Beacon Chain'}");
    expect(find.byType(QrImage), findsOneWidget);
    print(" ✓ QR Image Check Passed");

    expect(
        find.text(locator<AuthServices>().myAppUser.name! +
            (isPolygon ? "'s Polygon " : "'s Beacon ") +
            "wallet_address".tr),
        findsOneWidget);
    print(" ✓ Wallet Address Check Passed");

    expect(
        find.text(isPolygon
            ? locator<AuthServices>().myAppUser.wallet!.onChainAddress!
            : locator<AuthServices>().myAppUser.wallet!.offChainAddress!),
        findsOneWidget);
    print(" ✓ Wallet Address Check Passed");
    expect(find.text("copy_address".tr), findsOneWidget);
    print(" ✓ Copy Address Label Check Passed");

    await genericOnTap(
        tester, find.text("copy_address".tr), "Copy Button Pressed");

    expect(find.text("wallet_id_copied".tr), findsOneWidget);
    print(" ✓ Chain Wallet Address Copy Check Passed");

    await genericOnTap(tester, find.byIcon(Icons.close), "Screen Close");
    await genericOnTap(
        tester,
        isPolygon
            ? find.byIcon(Icons.copy).first
            : find.byIcon(Icons.copy).last,
        "Copy Icon Pressed");

    expect(find.text("wallet_id_copied".tr), findsOneWidget);
    print(" ✓ My Wallet Screen : Wallet Address Copy Check Passed");
  }
}
