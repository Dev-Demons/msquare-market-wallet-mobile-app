import 'dart:io';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/ui/screens/authentications/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/static_values.dart';
import '../../../../core/constants/style.dart';
import '../../../../core/enums/view_state.dart';
import '../../../widgets/custom_login_button.dart';
import '../../../widgets/home_screen_widgets/language_widget.dart';

/// [LoginScreen] - A screen made with [StatefulWidget] that acts the first screen
/// for [Application] on startup.
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// [Stores] the value of [LanguageSelection]
  String dropDownValue = 'ENG';

  /// [SharedPreferences] object to retrieve stored data.
  final Future<SharedPreferences> myprefs = SharedPreferences.getInstance();

  /// [Function] accepts a value of [string] and in turn updates
  /// currently used [Language] and stores in local storage
  /// using [SharedPreferences].
  void onLanguageChanged(v) async {
    SharedPreferences prefs = await myprefs;
    //Local Preferences are changed on the bases of language selection
    prefs.setString('lang', languageDropDownMapping[v]);
    //Current DropDown value and App language is changed on the basis of switch-case
    setState(() {
      dropDownValue = v!;
      Get.updateLocale(localeMapping[languageDropDownMapping[v]]);
    });
  }

  /// [Function] that retrieves the [Language] stored in the local storage
  /// and on its basis assigns the drop down value to it.
  void languageSelection() async {
    SharedPreferences prefs = await myprefs;
    //retrieves stored language if there is any
    String deviceLocale = Get.deviceLocale!.languageCode;
    String tempLang = prefs.containsKey('lang') ? prefs.getString('lang')! : "";
    if (tempLang == "") {
      tempLang = secondaryLanguageMapping[languageMapping[deviceLocale]];
    } else {
      tempLang = secondaryLanguageMapping[tempLang];
    }
    setState(() {
      dropDownValue = tempLang;
    });
  }

  @override
  void initState() {
    super.initState();
    // language Selection Function
    languageSelection();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => LoginProvider()),
      child: Consumer<LoginProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: primaryColor70,
              ),
              inAsyncCall: model.state == ViewState.busy,
              child: Stack(children: [
                // Language Selection Drop Down
                Positioned(
                  right: 10.h,
                  top: 10.h,
                  child: SafeArea(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: greyColor30)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                              ),
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "app_language".tr,
                                          style: poppinsTextStyle(20,
                                              FontWeight.w500, greyColor100),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: appLanguages.length,
                                      itemBuilder: (context, index) {
                                        return LanguageWidget(
                                          dropDownValue: appLanguages[index],
                                          isSelected: dropDownValue ==
                                              secondaryLanguageMapping[
                                                  appLanguages[index]],
                                          onTap: () {
                                            onLanguageChanged(
                                                secondaryLanguageMapping[
                                                    appLanguages[index]]);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                  'assets/flags/$dropDownValue.svg'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(dropDownValue,
                                    style: poppinsTextStyle(
                                        14, FontWeight.w500, greyColor100)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Login options Google, Facebook and Apple (in case of iOS)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: SizedBox()),
                      Image.asset("assets/v2/splashlogo.png", scale: 1.2),
                      Expanded(child: SizedBox()),

                      // Login with google button
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: LoginButton(
                          asset: "gsvg",
                          option: "Google",
                          onTap: () {
                            model.signInWithGoogle(context);
                          },
                        ),
                      ),

                      // Login with facebook button
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: LoginButton(
                          asset: "fbsvg",
                          option: "Facebook",
                          onTap: () {
                            model.signInWithFacebook(context);
                          },
                        ),
                      ),

                      // Login with apple button
                      Platform.isAndroid
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: LoginButton(
                                  asset: "applesvg",
                                  option: "Apple",
                                  onTap: () {
                                    model.signInWithApple(context);
                                  }),
                            ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
