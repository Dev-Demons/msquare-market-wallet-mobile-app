import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/locator.dart';
import 'package:msquare_market/v2/core/services/auth_services.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/setting_screen_widgets/credit_card_widget.dart';
import 'utils.dart';

class BillingMethodTest {
  Future<void> testBillingScreenDetails(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));

    expect(find.text('user_name'.tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await genericOnTap(
        tester, find.text('billing'.tr), 'Billing Button Pressed');
    expect(find.text('payment_method'.tr), findsOneWidget);
    expect(
        find.text(locator<AuthServices>().myAppUser.email!), findsNWidgets(2));
    if (find.byType(CreditCardWidget).evaluate().isNotEmpty) {
      print("✓ There are cards for this User");
    } else {
      print("✓ There are no cards for this User");
    }
    print("✓ Billing Receiving Email Check Passed");
  }

  Future<void> testAddCard(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 3));

    expect(find.text('user_name'.tr), findsOneWidget);
    print("✓ Arrived on Settings Screen");

    await genericOnTap(
        tester, find.text('billing'.tr), 'Billing Button Pressed');
    expect(find.text('payment_method'.tr), findsOneWidget);
    print("✓ Arrived on Billing Screen");
    await genericOnTap(
        tester, find.text('add_payment_method'.tr), "Add Payment Method");

    await genericOnTap(tester, find.byIcon(Icons.keyboard_arrow_down),
        "Dropdown Field Pressed");

    await genericOnTap(
        tester, find.text("shinhancard").last, "Drop Down Value Selected");
    await genericEnterText(
        tester, find.byType(CustomTextInputField).at(1), "asdf1234");
    await tester.pumpAndSettle();
    await genericEnterText(
        tester, find.byType(CustomTextInputField).at(2), "1234567890");
    await tester.pumpAndSettle();
    await genericOnTap(
        tester, find.text("add_card".tr), "Add Card Button Pressed");
    expect(find.text('card_added'.tr), findsOneWidget);
    await tester.pumpAndSettle();

    Get.closeAllSnackbars();
    print("✓ Added Card Test Passed");
  }
}
