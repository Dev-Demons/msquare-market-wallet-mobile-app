import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/authentications/login/login_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_login_button.dart';
import 'package:msquare_market/v2/ui/widgets/home_screen_widgets/crypto_widget.dart';

import 'utils.dart';

class LoginTest {
  Future<void> testLanguageChange(WidgetTester tester) async {
    await loadWidget(tester, LoginScreen());
    // Check we are on landing screen
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == 'Sign in with Google'),
        findsOneWidget);
    print("✓ Landed on Login Screen");
    // Change Language to Chinese
    await genericOnTap(tester, find.text('ENG'), 'Change Language Pressed');
    await genericOnTap(
        tester, find.text('Chinese'), "Language Changed to Chinese");
    await genericRandomOnTap(tester);
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "登陆使用 Google"),
        findsOneWidget);

    // Change Language to Japanese
    await genericOnTap(tester, find.text('CHN'), 'Change Language Pressed');
    await genericOnTap(
        tester, find.text('Japanese'), "Language Changed to Japanese");
    await genericRandomOnTap(tester);
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "でサインイン Google"),
        findsOneWidget);

    // Change Language to Korean
    await genericOnTap(tester, find.text('JPN'), 'Change Language Pressed');
    await genericOnTap(
        tester, find.text('Korean'), "Language Changed to Korean");
    await genericRandomOnTap(tester);
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "로 로그인하다 Google"),
        findsOneWidget);

    // Change Language to English
    await genericOnTap(tester, find.text('KOR'), 'Change Language Pressed');
    await genericOnTap(
        tester, find.text('English'), "Language Changed to English");
    await genericRandomOnTap(tester);
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == "Sign in with Google"),
        findsOneWidget);

    print("✓ All Checks Passed");
  }

  Future<void> testGoogleSocialLogin(WidgetTester tester) async {
    await loadWidget(tester, LoginScreen());
    // Check we are on landing screen
    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == 'Sign in with Google'),
        findsOneWidget);
    print("✓ Landed on Login Screen");

    await genericOnTap(
        tester, find.byType(LoginButton).first, 'Google Login Pressed');
    expect(locator<AuthServices>().firebaseUser, isNotNull);
    print(
        '✓ User Logged in. Username : ${locator<AuthServices>().firebaseUser!.displayName}');
    expect(find.text('Tokens'), findsOneWidget);
    print("✓ All Checks Passed");
  }
}
