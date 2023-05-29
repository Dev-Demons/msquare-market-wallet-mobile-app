import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/ui/screens/swap/swaping.dart';
import '../../../core/constants/style.dart';
import '../../../core/enums/token_type.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/swap_screen_widgets/topup_widget.dart';

/// A [View] that displays main swap screen which lets the [User]:
/// - Topup from Exchanges
/// - Swap with other Tokens
class MainSwapScreen extends StatefulWidget {
  /// Default [Constructor]
  const MainSwapScreen(
      {Key? key, required this.tokenName, required this.balance})
      : super(key: key);
  final String tokenName;
  final double balance;
  @override
  State<MainSwapScreen> createState() => _MainSwapScreenState();
}

class _MainSwapScreenState extends State<MainSwapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom App Bar
      appBar: customAppBar(widget.tokenName,
          center: true, isBottomBorder: true, backArrow: true),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            color: primaryColor60,
            dashPattern: [6, 3],
            radius: Radius.circular(8),
            strokeWidth: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                  color: primaryColor10,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Available Balance Label
                  Text(
                    "available_balances".tr,
                    style: poppinsTextStyle(14, FontWeight.w500, greyColor100),
                  ),
                  // Available Balance Value
                  Text(
                    "${widget.balance}",
                    style: poppinsTextStyle(16, FontWeight.w500, greyColor100),
                  )
                ],
              ),
            ),
          ),
          // Swap Token Expansion Tile
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: greyColor0),
              child: Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    "swap_token".tr,
                    style: poppinsTextStyle(
                      14,
                      FontWeight.w500,
                      greyColor100,
                    ),
                  ),
                  textColor: greyColor100,
                  iconColor: greyColor50,
                  collapsedIconColor: greyColor50,
                  childrenPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  children: ["MSQ", "MSQP", "MSQX", "MSQXP"]
                      .map((e) => InkWell(
                            onTap: () {
                              Get.to(() => SwappingScreen(
                                    from: 'MSQP',
                                    to: 'MSQ',
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                e,
                                textAlign: TextAlign.left,
                                style: poppinsTextStyle(
                                  16,
                                  FontWeight.w500,
                                  greyColor100,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          // Topup Credit Expansion Tile
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: greyColor0),
            child: Theme(
              data: ThemeData(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  "topup_credit".tr,
                  style: poppinsTextStyle(
                    14,
                    FontWeight.w500,
                    greyColor100,
                  ),
                ),
                textColor: greyColor100,
                iconColor: greyColor50,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TopUpWidget(title: "Flata Exchange", image: "flata"),
                        TopUpWidget(title: "Polygon Scan", image: "polygon"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
