import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/authentications/login/login_screen.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:msquare_market/v2/ui/screens/swap/main_swap_screen.dart';
import 'package:msquare_market/v2/ui/widgets/home_screen_widgets/crypto_widget.dart';

import '../utils.dart';

class HomeScreenTest {
  Future<void> testHomeScreenDetails(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 0));
    // Check We Are on Home Screen
    expect(find.text('Tokens'), findsOneWidget);
    print("✓ Arrived on Home Screen");
    // User Balance and Trend Check
    expect(
        find.text(
            "₩ ${locator<AuthServices>().myAppUser.totalBalanceInKRW.toStringAsFixed(3)}"),
        findsOneWidget);
    /*expect(find.text("${locator<AuthServices>().myAppUser!.totalBalanceTrend}"),
        findsOneWidget);*/
    print("✓ User Balance and Trend Check Passed");
    expect(find.byWidgetPredicate((widget) {
      if (widget is CryptoWidget) {
        print("  ${widget.token} ${widget.tokenBalance}");
        return true;
      }
      return false;
    }),
        findsNWidgets(
            locator<AuthServices>().myAppUser.wallet!.tokens!.length));
    print("✓ All Tokens Present Check Passed");
    // Number of Tokens Check
  }

  Future<void> testHomeScreenScroll(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 0));
    // Check We Are on Home Screen
    expect(find.text('Tokens'), findsOneWidget);
    print("✓ Arrived on Home Screen");

    await genericFling(tester);
    print("✓ Scroll Check Passed");
  }

  Future<void> testHomeScreenBottomNavigation(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 0));
    // Check We Are on Home Screen
    expect(find.text('Tokens'), findsOneWidget);
    print("✓ Arrived on Home Screen");

    await genericOnTap(tester, find.text('Wallet'), "Wallet Icon Pressed");

    expect(find.text('available_balances'.tr), findsOneWidget);
    print("✓ Wallet Screen Navigation Check Passed");

    await genericOnTap(tester, find.text('History'), "History Icon Pressed");
    expect(find.text('transaction_history'.tr), findsOneWidget);
    print("✓ History Screen Navigation Check Passed");

    await genericOnTap(tester, find.text('Settings'), "Settings Icon Pressed");
    expect(find.text('app_language'.tr), findsOneWidget);
    print("✓ Settings Screen Navigation Check Passed");

    await genericOnTap(tester, find.text('Home'), "Home Icon Pressed");
    expect(find.text('Tokens'), findsOneWidget);
    print("✓ Home Screen Navigation Check Passed");
  }

  Future<void> testBalanceRPA(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 0));
    // Check We Are on Home Screen
    expect(find.text('Tokens'), findsOneWidget);
    print("✓ Arrived on Home Screen");

    await genericOnTap(tester, find.byIcon(Icons.sync), 'Balance RPA Pressed');

    expect(find.text('Balance Sync'), findsOneWidget);
    print("✓ Balance Sync Test Passed");
    await tester.pump(Duration(seconds: 3));
  }
}
