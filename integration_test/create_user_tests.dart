import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/authentications/login/login_screen.dart';
import 'package:msquare_market/v2/ui/widgets/create_screen_widget/circular_check_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_login_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'utils.dart';
import 'package:get/get.dart';

class CreateUserTest {
  Future<void> testCreateUser(WidgetTester tester) async {
    await loadWidget(tester, LoginScreen());

    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "Sign in with Google"),
        findsOneWidget);
    print("✓ Google Sign in Button Found");
    await genericOnTap(
        tester, find.byType(LoginButton).first, 'Google Login Pressed');

    expect(locator<AuthServices>().firebaseUser, isNotNull);
    print(
        '✓ User Logged in. Username : ${locator<AuthServices>().firebaseUser!.displayName}');
    await checkCreateIDScreen(tester);
    print("✓ User ID Created Check Passed");
    await checkCreatePasswordScreen(tester);
    print("✓ User Password Created Check Passed");

    expect(find.text(locator<AuthServices>().myAppUser.wallet!.onChainAddress!),
        findsOneWidget);
    expect(
        find.text(locator<AuthServices>().myAppUser.wallet!.offChainAddress!),
        findsOneWidget);
    print("✓ Wallet Address Check Passed");
    await genericOnTap(
        tester, find.text('ok'.tr), "User Registration Check Passed");

    expect(find.text('Tokens'), findsOneWidget);

    print("✓ Registration Complete, Landed on Main HomeScreen");
  }

  Future<void> checkCreateIDScreen(WidgetTester tester) async {
    expect(find.text("create_id".tr), findsOneWidget);
    print("✓ Arrived on Create ID Screen");

    await genericEnterText(
        tester, find.byType(CustomTextInputField), "testUser345");

    /*if (Platform.isIOS) {
      await tester.enterText(
          find.byType(CustomTextInputField).last, "Test User 345");
    }*/

    expect(find.byWidgetPredicate((widget) {
      if (widget is CircularCheckButton) {
        return widget.iconColor == Colors.white;
      }
      return false;
    }), findsNWidgets(2));
    print("✓ Text Input Check Passed");
    await genericOnTap(
        tester, find.byType(CustomMaterialButton), "Next Button Pressed");
  }

  Future<void> checkCreatePasswordScreen(WidgetTester tester) async {
    expect(find.text('create_pass'.tr), findsOneWidget);
    print("✓ Arrived on Create Password Screen");

    await genericEnterText(
        tester, find.byType(CustomTextInputField).first, "asdf1234#S");
    await genericEnterText(
        tester, find.byType(CustomTextInputField).last, "asdf1234#S");

    expect(find.byWidgetPredicate((widget) {
      if (widget is CircularCheckButton) {
        return widget.iconColor == Colors.white;
      }
      return false;
    }), findsNWidgets(3));
    print("✓ Text Input Check Passed");

    await genericOnTap(
        tester, find.text('accept_pass_agreement'.tr), "Agreement Popup");
    await genericOnTap(tester, find.text('ok'.tr), "Agreement Accepted");

    await genericOnTap(
        tester, find.byType(CustomMaterialButton), "Password Sent");
    expect(find.text('request_confirmation'.tr), findsOneWidget);
    print("✓ Arrived on Registration Complete Screen");
  }
}
