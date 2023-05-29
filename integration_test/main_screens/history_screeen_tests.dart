import 'package:flutter_test/flutter_test.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/base_screen.dart';
import 'package:msquare_market/v2/ui/widgets/history_widgets/history_list_card.dart';
import 'package:flutter/material.dart';
import '../utils.dart';
import 'package:get/get.dart';

class HistoryScreenTest {
  bool isData = true;
  Future<void> testScrolling(WidgetTester tester) async {
    if (isData) {
      await loadWidget(tester, BottomNavigation(indexValue: 2));

      expect(find.text('transaction_history'.tr), findsOneWidget);
      print("✓ Arrived on History Screen");
      await genericFling(tester);
      await genericFling(tester);
      await genericFling(tester);
      print("✓ Scroll Test Passed");
    } else {
      print("✓ There is no data to scroll");
    }
  }

  Future<void> testHistoryRecords(WidgetTester tester) async {
    await loadWidget(tester, BottomNavigation(indexValue: 2));

    expect(find.text('transaction_history'.tr), findsOneWidget);
    print("✓ Arrived on History Screen");
    if (find.text('history_list_empty'.tr).evaluate().isNotEmpty) {
      print("✓ History is empty");
      isData = false;
    } else {
      expect(find.byType(HistoryListCard), findsWidgets);
      print("✓ History has Data");
    }
    print("✓ History Screen Test Passed");
  }
}
