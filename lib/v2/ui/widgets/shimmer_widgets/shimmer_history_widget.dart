import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../divider_widget.dart';

/// A [StatelessWidget] that displays [Container] widget when the HistoryScreen
/// is being loaded instead of circular progress indicator
class ShimmerHistoryWidget extends StatelessWidget {
  const ShimmerHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Container
    return Container(
      // Decoration of Container Widget
      decoration: BoxDecoration(
        // Border Radius Set to 8
        borderRadius: BorderRadius.circular(8),
        // Border Color Set to greyColor20
        border: Border.all(color: greyColor20),
      ),
      // margins to display the Container nicely
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          // Use minimum vertical space as possible
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ListTile to show HistoryListWidget Prototype while loading
            // by prototype, we mean instead of showing some default values
            // or spinner we simply grey mark the areas which contain
            // data or dynamic values, static values are as it is.
            // Example can be when you open up youtube, it takes to
            // refresh your feed and as a result some greyColorWidget
            // are show instead of actual data.
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 32,
              visualDensity: VisualDensity(horizontal: -4),
              dense: true,
              // Token Image Part
              leading: CircleAvatar(
                radius: 15,
                backgroundColor: greyColor20,
              ),
              // Token name Part
              title: Container(
                width: 40,
                height: 20,
                color: greyColor20,
              ),
              // Transaction timestamp Part
              trailing: Container(
                width: 80,
                height: 20,
                color: greyColor20,
              ),
            ),
            // Divider Widget
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DividerWidget(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Amount Part
                Container(
                  width: 40,
                  height: 20,
                  color: greyColor20,
                ),
                // Transaction type part
                Container(
                  height: 24,
                  width: 60,
                  color: greyColor20,
                ),
              ],
            ),
            // Tx Hash Part
            Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Container(
              height: 20,
              color: greyColor20,
            ),
            // Sender and Receiver Part
            Padding(padding: EdgeInsets.symmetric(vertical: 6)),
            Container(
              height: 20,
              color: greyColor20,
            ),
            // In and Out Part
            Padding(padding: EdgeInsets.symmetric(vertical: 6)),
            Container(
              width: 40,
              height: 20,
              color: greyColor20,
            ),
          ],
        ),
      ),
    );
  }
}
