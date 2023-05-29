import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/style.dart';

/// A [StatelessWidget] that displays the ListTile for
/// particular set of arguments.

class SettingScreenWidget extends StatelessWidget {
  /// [Constructor] that accepts:
  /// - [onTap] function
  /// - [title] of type [String]
  /// - [isLogout] of type [bool]
  ///
  /// and returns [widget] of type [ListTile].
  const SettingScreenWidget(
      {Key? key,
      required this.onTap,
      required this.title,
      this.isLogout = false})
      : super(key: key);

  /// onTap Function
  final void Function() onTap;

  /// [String] variable to store title
  final String title;

  /// A [boolean] flag to check if Logout Widget is needed or not.
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      visualDensity: VisualDensity(vertical: -4),
      // OnTap Function
      onTap: onTap,
      title: Text(
        // Setting Tile Title
        title,
        // isLogout Check
        style: isLogout
            ? poppinsTextStyle(16, FontWeight.w500, dangerColor10)
            : poppinsTextStyle(16, FontWeight.w500, greyColor100),
      ),
    );
  }
}
