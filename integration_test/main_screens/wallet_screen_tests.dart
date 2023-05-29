import 'package:flutter_test/flutter_test.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/widgets/home_screen_widgets/crypto_widget.dart';
import '../utils.dart';

class WalletScreenTest {
  Future<void> testWalletScreenDetails(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 1));
    // Check We Are on Home Screen
    expect(find.text('available_balances'.tr), findsOneWidget);
    print("✓ Arrived on Wallet Screen");

    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    var availableBalance = 0.0;
    locator<AuthServices>().myAppUser.wallet!.tokens!.forEach((element) {
      availableBalance += element.balance!;
    });
    expect(find.text(availableBalance.toStringAsFixed(2)), findsOneWidget);
    print("✓ Available Tokens Check Passed");

    expect(
        find.text("₩ " +
            locator<AuthServices>()
                .myAppUser
                .totalBalanceInKRW
                .toStringAsFixed(2)),
        findsOneWidget);
    print("✓ Available Balance Check Passed");
    expect(find.byWidgetPredicate((widget) {
      if (widget is CryptoWidget) {
        print("  ${widget.token} ${widget.tokenBalance}");
        return true;
      }
      return false;
    }),
        findsNWidgets(
            locator<AuthServices>().myAppUser.wallet!.tokens!.length));
    print("✓ All Tokens Details Check Passed");
  }
}
