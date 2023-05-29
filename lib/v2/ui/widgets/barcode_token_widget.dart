import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

/// [StatelessWidget] that displays the token that are included in the QR Transaction
/// and mobile payment.
class BarcodeTokenAmountWidget extends StatelessWidget {
  /// Default [Constructor] that accepts [amount] and [token] and returns
  /// [BarcodeTokenAmountWidget] widget
  const BarcodeTokenAmountWidget({
    Key? key,
    required this.amount,
    required this.token,
  }) : super(key: key);

  /// [String] variable that stores token amount

  final String amount;

  /// [String] variable that stores token name
  final String token;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Token Amount
        Text(
          amount,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5,
        ),
        // Token Name
        Text(
          token,
          style: TextStyle(
              fontSize: 12, color: greyColor50, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
