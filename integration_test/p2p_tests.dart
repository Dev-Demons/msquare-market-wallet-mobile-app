import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:msquare_market/v2/core/constants/static_values.dart';
import 'package:msquare_market/v2/core/enums/token_type.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:msquare_market/v2/ui/widgets/custom_text_input_field.dart';
import 'package:msquare_market/v2/ui/widgets/p2p_widgets/order_widget.dart';
import 'package:msquare_market/v2/ui/widgets/p2p_widgets/p2p_listing_card.dart';
import 'utils.dart';
import 'package:get/get.dart';

class P2PTest {
  Future<void> testP2POrderTransaction(WidgetTester tester) async {
    await baseLoading(tester);
    await genericOnTap(
        tester, find.text("Buy".tr).at(1), "First MSQP Order Bought");
    await genericOnTap(tester, find.text("i_sure".tr), "MSPQ Buy : I am sure");

    await genericOnTap(tester, find.text("Sell".tr), "Switch to Sell Tab");
    await genericOnTap(
        tester, find.text("Sell".tr).at(1), "First MSQP Order Sold");
    await genericOnTap(tester, find.text("i_sure".tr), "MSQP Sell : I am sure");

    await genericOnTap(
        tester, find.text("P2UP".tr).first, "Switch to P2UP Tab");
    await genericOnTap(
        tester, find.text("Sell".tr).at(1), "First P2UP Order Sold");
    await genericOnTap(tester, find.text("i_sure".tr), "P2UP Sell : I am sure");

    await genericOnTap(tester, find.text("Buy".tr), "Switch to Buy Tab");
    await genericOnTap(
        tester, find.text("Buy".tr).at(1), "First P2UP Order Bought");
    await genericOnTap(tester, find.text("i_sure".tr), "P2UP Buy : I am sure");
    print("✓ Ads by User Check Passed");
  }

  Future<void> testAdsByUser(WidgetTester tester) async {
    await baseLoading(tester);

    await genericOnTap(
        tester, find.byIcon(Icons.menu), "P2P User Listing Icon Tap");
    expect(find.text("p2p_listings".tr), findsOneWidget);
    print("✓ Arrived On P2P Ad Listing Screen");
    if (find.byType(P2PListingCard).evaluate().isEmpty) {
      print("✓ There are no ads");
    } else {
      print("✓ There are ${find.byType(P2PListingCard).evaluate().length} ads");
    }
    print("✓ Ads by User Check Passed");
  }

  Future<void> testCreateP2PAdAndConfirm(WidgetTester tester) async {
    await baseLoading(tester);

    await genericOnTap(
        tester, find.byIcon(Icons.menu), "P2P User Listing Icon Tap");
    expect(find.text("p2p_listings".tr), findsOneWidget);
    print("✓ Arrived On P2P Ad Listing Screen");

    // MSQ BUY
    await placeTokenOrder(tester, 0, 0);
    // MSQ SELL
    await placeTokenOrder(tester, 0, 1);
    // P2UP BUY
    await placeTokenOrder(tester, 1, 0);
    // P2UP SELL
    await placeTokenOrder(tester, 1, 1);
    expect(find.byType(P2PListingCard, skipOffstage: false), findsNWidgets(4));
    print("✓ P2P Ads found in Listings");
    print("✓ Create P2P Order Test Passed");
  }

  Future<void> testDeleteP2PAd(WidgetTester tester) async {
    await baseLoading(tester);

    await genericOnTap(
        tester, find.byIcon(Icons.menu), "P2P User Listing Icon Tap");
    expect(find.text("p2p_listings".tr), findsOneWidget);
    print("✓ Arrived On P2P Ad Listing Screen");
    await deleteAD(tester);
    await deleteAD(tester);
    await deleteAD(tester);
    await deleteAD(tester);
    expect(find.byType(P2PListingCard), findsNothing);
    print("✓ P2P Ad Delete Test Passed");
  }

  Future<void> deleteAD(WidgetTester tester) async {
    await genericOnTap(tester, find.byIcon(CupertinoIcons.delete_solid).first,
        "Delete Ad Button Pressed");
    await genericOnTap(
        tester, find.text("i_sure".tr), "I am sure Button Pressed");
  }

  Future<void> placeTokenOrder(WidgetTester tester, int token, int type) async {
    await genericOnTap(
        tester, find.byIcon(Icons.add), "Create Ad Button Pressed");
    expect(find.text("create_p2p_ad".tr), findsOneWidget);

    await genericOnTap(tester, find.bySubtype<Radio>().at(token),
        "${tokens[token]} Selected As Currency");
    await genericOnTap(tester, find.bySubtype<Radio>().at(type + 2),
        "${transactionType[type].toUpperCase()} Selected As Listing Type");

    await genericEnterText(
        tester, find.byType(CustomTextInputField).first, "123");
    await genericEnterText(
        tester, find.byType(CustomTextInputField).last, "246");

    expect(find.text("not_enough_balance".tr), findsNothing);
    expect(find.text("null_value".tr), findsNothing);
    print("✓ P2P Trade Amount is sufficient");

    await genericOnTap(
        tester, find.text('create'.tr), "Create Ad Button Pressed");

    await genericOnTap(tester, find.text('take_me_to_listings'.tr),
        "Go back to P2P Ad Listing");
  }

  Future<void> baseLoading(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 0));

    expect(find.text('Tokens'), findsOneWidget);
    print("✓ Arrived On Home Screen");

    await genericOnTap(
        tester, find.byIcon(Icons.arrow_forward), "P2P Trading Arrow Pressed");
    expect(find.text('P2P'), findsOneWidget);
    print("✓ Arrived On P2P Order Screen");
  }
}
