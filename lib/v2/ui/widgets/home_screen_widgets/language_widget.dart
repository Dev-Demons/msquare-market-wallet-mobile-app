import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/static_values.dart';
import '../../../core/constants/style.dart';

/// A [StatelessWidget] that displays the language in tile
/// format.
class LanguageWidget extends StatelessWidget {
  /// Default [Constructor] that accepts [dropDownValue],[isSelected]
  /// and [onTap] function and returns [LanguageWidget]
  const LanguageWidget(
      {Key? key,
      required this.dropDownValue,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  /// [String] value that stores the language that is to be displayed
  final String dropDownValue;

  /// [Boolean] flag that shows if the language is selected or not.
  final bool isSelected;

  /// [Function] that handles what to do when language is pressed
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        dense: true,
        selectedTileColor: greyColor20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        selected: isSelected,
        // language flag
        leading: SvgPicture.asset(
            'assets/flags/${secondaryLanguageMapping[dropDownValue]}.svg'),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(dropDownValue,
              style: poppinsTextStyle(14, FontWeight.w500, greyColor100)),
        ),
      ),
    );
  }
}
