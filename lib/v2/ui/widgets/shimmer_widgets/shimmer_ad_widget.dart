import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

/// A [StatelessWidget] that displays [Container] widget when the [P2PUserScreen]
/// is being loaded instead of circular progress indicator
class ShimmerAdWidget extends StatelessWidget {
  const ShimmerAdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Transaction Type and Currency Part
              Container(width: 50, height: 24, color: greyColor20),
              // Delete Button Part
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.delete_solid,
                    color: greyColor50, size: 24),
              )
            ],
          ),
          // Amount Part
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Container(width: 150, height: 20, color: greyColor20),
          ),
          // Price Part
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Container(width: 150, height: 20, color: greyColor20),
          ),
          // Timestamp Part
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Container(width: 150, height: 20, color: greyColor20),
          ),
        ],
      ),
    );
  }
}
