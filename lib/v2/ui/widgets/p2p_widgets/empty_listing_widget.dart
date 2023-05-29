import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// A [StatelessWidget] that is displayed if there is no record found for
/// any P2P Ad or P2P Order.

class EmptyListingWidget extends StatelessWidget {
  /// [Constructor]
  const EmptyListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Svg Picture to for Empty Records
            SvgPicture.asset("assets/v2/empty.svg"),
            SizedBox(
              height: 5,
            ),
            // Empty Records Label
            Text("p2p_listings_empty".tr),
          ],
        ),
      ),
    );
  }
}
