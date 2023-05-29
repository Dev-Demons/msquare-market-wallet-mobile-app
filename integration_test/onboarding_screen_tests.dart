import 'dart:math';
import 'utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class OnBoardingTest {
  Offset right = const Offset(200, 0);
  Offset left = const Offset(-200, 0);
  Future<void> testSwipeAndNextButton(WidgetTester tester) async {
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 1));

    expect(find.text('buy_products'.tr), findsOneWidget);
    await swipeFromRightToLeft(tester);
    expect(find.text('token_transfer'.tr), findsOneWidget);
    await swipeFromRightToLeft(tester);
    expect(find.text('secure_layer'.tr), findsOneWidget);
    await swipeFromRightToLeft(tester);
    expect(find.text('discounted_products'.tr), findsOneWidget);

    await genericOnTap(tester, find.text('next'.tr), 'Next Button Pressed');

    expect(
        find.byWidgetPredicate(
            (widget) => extractFromRichText(widget) == 'Sign in with Google'),
        findsOneWidget);
    print("✓ All Checks Passed");
  }

  Future<void> swipeFromRightToLeft(WidgetTester tester) async {
    await tester.dragFrom(right, left);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }
}
