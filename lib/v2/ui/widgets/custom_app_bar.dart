import 'package:flutter_svg/svg.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/AppColor.dart';
import '../../core/constants/colors.dart';
import 'divider_widget.dart';

/// Custom Made Generic AppBar
/// Only required value is [title]
///
/// * [Title] - a value of type [String]
/// * [backArrow] - a value of type [boolean]
/// * [isBottomBorder] - a value of type [boolean]
/// * [center] - a value of type [boolean]
/// * [elevation] - a value of type [double]
/// * [backArrowFunction] - a value of type [Function]

AppBar customAppBar(

    /// String value
    String title,
    {
    /// show a back arrow
    bool backArrow = false,

    /// show a border.
    bool isBottomBorder = true,

    /// Place title in center
    bool center = false,

    /// Appbar Elevation
    double? elevation,

    ///Function for back arrow
    void Function()? backArrowFunction}) {
  return AppBar(
    ///show back arrow if backArrow true
    automaticallyImplyLeading: backArrow,

    ///title
    title: Text(
      title.tr,

      ///generic TextStyle
      style: poppinsTextStyle(20, FontWeight.w600, greyColor100),
    ),

    ///show center title if center true
    centerTitle: center,

    ///elevation of the appbar
    elevation: elevation ?? 0,

    ///Size of left side icon
    leadingWidth: backArrow ? 56 : 0,

    ///show BackArrow if backArrow true
    leading: backArrow
        ? IconButton(
            onPressed: backArrowFunction ??
                () {
                  /// [OnTap] get Back to previous screen
                  Get.back();
                },
            icon: Icon(Icons.arrow_back),
          )
        : Container(child: null),

    ///show a bottom border if isBottomBorder true
    bottom: isBottomBorder
        ? PreferredSize(
            child: DividerWidget(),
            preferredSize: Size.fromHeight(1.0),
          )
        : null,
  );
}

class SuperSaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SuperSaveAppBar({Key? key, required this.title, this.backArrow = true})
      : super(key: key);

  final Widget title;
  final bool backArrow;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
      automaticallyImplyLeading: backArrow,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            stops: [0.1, 0.7],
            end: Alignment.topRight,
            colors: [
              AppColor.primaryColor100,
              AppColor.superSaveGradientSecondColor,
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: AppColor.primaryColor40,
            height: 1,
            thickness: 1,
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class CustomAppBarWithClose extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithClose({Key? key, required this.title})
      : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: poppinsTextStyle(20, FontWeight.w600, AppColor.greyColor100),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              size: 24,
              color: AppColor.greyColor100,
            ))
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: DividerWidget(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
