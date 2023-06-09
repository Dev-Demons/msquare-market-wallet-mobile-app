import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/style.dart';

class CustomTextInputField extends StatelessWidget {
  ///
  /// CustomTextInputField - generic [TextInputField] that is made to be used in all of our input fields
  ///

  CustomTextInputField({
    Key? key,
    this.keyboard = const TextInputType.numberWithOptions(decimal: true),
    this.controller,
    this.onChanged,
    this.hintText = "0.00",
    this.suffix,
    this.suffixIcon,
    this.suffixOnTap,
    this.inputFormatters,
    this.isObscure = false,
    this.validator,
    this.maxLines = 1,
    this.readOnly = false,
    this.mode = AutovalidateMode.disabled,
    this.borderColor = greyColor30,
    this.prefixIcon,
  }) : super(key: key);

  /// A [TextEditingController] to control input of [TextInputField]
  final controller;

  /// A [TextInputType] to decide which keyboard layout is to be used;
  /// - [Default] is set to [TextInputType.phone]
  /// Other know types are :
  /// - [TextInputType.email] designed for email
  /// - [TextInputType.text] designed for text
  final TextInputType keyboard;

  /// Input value change function which handles the [TextInput] values
  final onChanged;

  /// [hintText] - [Text] in the form of [String] that suggest which format or type of input is accepted.
  final hintText;

  /// Text Suffix - [Text] in the form of [String]  that is to be displayed on the [Right] side of [TextInput].
  final suffix;

  /// Icon Suffix - [Icon] in the form of [IconData] that is to be displayed on the [Right] side of [TextInput]
  /// ```dart
  /// Icons.menu, Icons.delete, Icons.arrow
  /// ```
  final suffixIcon;

  /// Prefix Icon that is to be displayed in case any provided in the constructor
  final prefixIcon;

  /// Icon Pressed - [Function] which tells the [Icon] to do what when pressed.
  final suffixOnTap;

  /// Input formatting - [InputFormatting] which decides which type input should be allowed in [TextInput]
  List<TextInputFormatter>? inputFormatters;

  /// Determines whether to show the [TextInput] or not.
  /// - accepts [boolean] value
  bool isObscure;

  /// A [Function] that determines whether the current [TextInput] is according to the conditions set in the
  /// function or not.
  var validator;

  /// Represents [Maximum] number of lines that are allowed in [TextInput]
  /// - default value is 1.
  /// - in case of [TextArea] or [DialogBox] value can be set to 5 ot 7.
  int maxLines;

  /// The value is [boolean] and set to [True] only if data is [ReadOnly]
  final readOnly;

  /// [AutovalidateMode] checks for any validations which are passed to [validator]
  final AutovalidateMode mode;

  /// Color of the border for the [TextInput], mostly used in password matching and
  /// invalid amount; on which it turns to red.
  Color borderColor;

  /// [Border] of type [OutlineInputBorder] that sets the outline border of the [TextInput]
  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: greyColor30));
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      cursorColor: primaryColor70,
      obscureText: isObscure,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: mode,
      obscuringCharacter: "*",
      readOnly: readOnly,
      decoration: InputDecoration(
        // content Padding from left, right and top
        contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        hintText: hintText,
        hintStyle: poppinsTextStyle(14, FontWeight.w500, greyColor40),
        fillColor: Colors.white,
        filled: true,
        border: border.copyWith(borderSide: BorderSide(color: borderColor)),
        enabledBorder:
            border.copyWith(borderSide: BorderSide(color: borderColor)),
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: borderColor)),
        disabledBorder:
            border.copyWith(borderSide: BorderSide(color: borderColor)),
        // if there is no prefix show nothing,
        // otherwise show the icon with proper styling
        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon, color: greyColor50, size: 24),
        // if no suffix icon is provided than show suffix text
        suffixIcon: suffixIcon != null
            ? IconButton(
                iconSize: 24,
                color: greyColor50,
                onPressed: suffixOnTap,
                icon: Icon(suffixIcon),
              )
            :
            // if no suffix is provided than show nothing.
            suffix == null
                ? null
                : Column(
                    // center alignment
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          suffix,
                          style: TextStyle(color: greyColor50),
                        ),
                      ),
                    ],
                  ),
        errorStyle: poppinsTextStyle(12, FontWeight.w500, dangerColor10),
      ),
    );
  }
}

class SuperSaveCustomTextInputField extends StatelessWidget {
  SuperSaveCustomTextInputField(
      {Key? key,
      required this.hintText,
      required this.suffix,
      required this.controller,
      this.validator,
      this.readOnly = false,
      this.onChanged,
      this.type = TextInputType.phone,
      this.formatter,
      this.error = false,
      this.align = TextAlign.end})
      : super(key: key);

  final String hintText;
  final String suffix;
  final TextEditingController controller;
  final bool readOnly;
  final validator;
  final onChanged;
  final TextInputType type;
  final bool error;
  final TextAlign align;
  List<TextInputFormatter>? formatter;

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: greyColor20));
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      keyboardType: type,
      controller: controller,
      validator: validator,
      inputFormatters: formatter,
      textAlign: align,
      readOnly: readOnly,
      onChanged: onChanged,
      style: TextStyle(color: error ? AppColor.dangerColor10 : Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16, 16, 0, 16),
        hintText: hintText,
        filled: true,
        fillColor: readOnly ? AppColor.greyColor10 : Colors.white,
        hintStyle: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
        errorStyle:
            poppinsTextStyle(12, FontWeight.w500, AppColor.dangerColor10),
        suffixIcon: suffix == "1"
            ? Icon(Icons.expand_more, size: 24, color: AppColor.greyColor100)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    suffix,
                    style: poppinsTextStyle(
                        14,
                        FontWeight.w500,
                        readOnly
                            ? AppColor.greyColor40
                            : AppColor.greyColor100),
                  )
                ],
              ),
        isDense: true,
        border: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
        focusedBorder: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
        disabledBorder: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
        enabledBorder: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
      ),
    );
  }
}

class SuperSaveWithoutSuffixTextInputField extends StatelessWidget {
  SuperSaveWithoutSuffixTextInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.onChanged,
      this.error = false,
      this.align = TextAlign.end,
      this.readOnly = false,
      this.isObscure = false,
      this.type = TextInputType.text,
      this.validator})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final onChanged;
  final bool error;
  final TextAlign align;
  final bool readOnly;
  final bool isObscure;
  final TextInputType type;
  final validator;

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: greyColor30));
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      keyboardType: type,
      controller: controller,
      textAlign: align,
      onChanged: onChanged,
      obscureText: isObscure,
      readOnly: readOnly,
      validator: validator,
      style: TextStyle(
          color: error
              ? AppColor.dangerColor10
              : readOnly
                  ? AppColor.greyColor70
                  : Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: readOnly ? AppColor.greyColor20 : Colors.white,
        hintStyle: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
        errorStyle:
            poppinsTextStyle(12, FontWeight.w500, AppColor.dangerColor10),
        isDense: true,
        border: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
        focusedBorder: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
        disabledBorder: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
        enabledBorder: border.copyWith(
            borderSide: BorderSide(
                color: error ? AppColor.dangerColor10 : AppColor.greyColor30)),
      ),
    );
  }
}
