import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/style.dart';
import '../../../core/models/order_model.dart';

/// A [StatelessWidget] that displays P2P Order details in
/// a [Card] widget

class P2PScreenOrderWidget extends StatelessWidget {
  /// A [Constructor] that accepts:
  /// - [order] of type [OrdersData]
  /// - [onPressed] of type Function()
  ///
  /// and returns a [StatelessWidget] of type [Card] with
  /// following details of order:
  /// - Created By which [User]
  /// - Transaction type
  /// - Creation Date
  /// - Currency
  /// - Ask Price
  /// - Amount
  /// - Buy or Sell
  /// - Ask Currency
  const P2PScreenOrderWidget({Key? key, this.onPressed, required this.order})
      : super(key: key);

  /// [OrdersData] variable to store the current order's data
  final OrdersData order;

  /// Variable that store the function to execute on button press.
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: greyColor20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: primaryColor70,
                      child: Text(order.createdBy![0],
                          style: interTextStyle(
                              12, FontWeight.w700, Colors.white)),
                    ),
                  ),
                  // Order Created By
                  Expanded(
                    child: Text(
                      order.createdBy!,
                      style:
                          poppinsTextStyle(14, FontWeight.w500, greyColor100),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                // Order Amount Label
                Text(
                  "Amount".tr,
                  style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                // Order Amount
                Text("${order.amount} ${order.currency}",
                    style: poppinsTextStyle(14, FontWeight.w500, greyColor100)),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Row(
              children: [
                // Order Price Label
                Text(
                  "Price".tr,
                  style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                // Order Ask Price and Order Ask Currency
                Text("${order.askPrice} ${order.askCurrency}",
                    style: poppinsTextStyle(14, FontWeight.w500, greyColor100)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("|",
                          style: poppinsTextStyle(
                              16, FontWeight.w500, primaryColor70)),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      // Trade Type Label
                      Text(
                        "p2p_trade".tr,
                        style:
                            poppinsTextStyle(14, FontWeight.w500, greyColor50),
                      ),
                    ],
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                    // Button Color Based onw whether Buy or Sell
                    color: !order.isBuy! ? successColor30 : Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    // Order onPressed Function
                    onPressed: onPressed,
                    // Order Type Buy or Sell
                    child: Text(!order.isBuy! ? "Buy".tr : "Sell".tr,
                        style:
                            interTextStyle(14, FontWeight.w600, Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
