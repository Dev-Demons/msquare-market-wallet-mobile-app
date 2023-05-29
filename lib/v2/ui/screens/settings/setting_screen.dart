import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/ui/screens/settings/setting_provider.dart';
import 'package:msquare_market/v2/ui/screens/settings/update_password_screen.dart';
import 'package:msquare_market/v2/ui/screens/settings/user_detail_screen.dart';
import 'package:msquare_market/v2/ui/screens/wallet/my_wallet.dart';
import 'package:msquare_market/v2/ui/screens/wallet_termination/wallet_termination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/screens/withdrawal_user/withdrawal_user.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/AppColor.dart';
import '../../../core/constants/style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/dialogues/password_validation_dialogue.dart';
import '../../widgets/password_snackbar.dart';
import '../../widgets/setting_screen_widgets/setting_screen_widget.dart';
import '../billing/billing_screen.dart';
import '../contact_us/contact_us_screen.dart';
import '../super_save/settings_participation_history/settings_participation_history_screen.dart';
import '../super_save/user_bank/user_bank_screen.dart';
import '../web_view_screen.dart';

/// A [View] that displays the Setting Screen with all its components:
/// - Username
/// - Wallet Addresses
/// - Language Change
/// - Fingerprint Authentication Selection
/// - Privacy Policy
/// - Terms & Conditions
/// - Wallet Termination
/// - Contact Us
/// - Logout
class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => SettingProvider()),
      child: Consumer<SettingProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customAppBar("settings"),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          contentPadding: EdgeInsets.zero,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          dense: true,
                          leading: Text(
                            "user_name".tr,
                            style: poppinsTextStyle(
                                16, FontWeight.w500, greyColor100),
                          ),
                          title: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                      text: model.locateUser.myAppUser.name
                                          .toString()))
                                  .then(
                                (_) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "username_copied".tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "${model.locateUser.myAppUser.name.toString()}",
                              textAlign: TextAlign.right,
                              style: poppinsTextStyle(
                                  16, FontWeight.w500, greyColor50),
                            ),
                          ),
                          trailing: IconButton(
                            iconSize: 16,
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerRight,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            onPressed: () {
                              Get.to(() => UserDetailScreen());
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColor.greyColor100,
                              size: 16,
                            ),
                          ),
                        ),
                        // UserName

                        // My Wallet
                        SettingScreenWidget(
                            onTap: () {
                              Get.to(() => MyWallet());
                            },
                            title: "my_wallet".tr),

                        ///Padding of 4
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),

                        // Language Selection Widget
                        SettingScreenWidget(
                            onTap: () {
                              Get.to(() => BillingScreen());
                            },
                            title: "billing".tr),

                        ///Padding of 4
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),

                        // Language Selection Widget
                        SettingScreenWidget(
                            onTap: () {
                              Get.to(() => UserBankScreen());
                            },
                            title: "내 계좌".tr),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),

                        // Language Selection Widget
                        SettingScreenWidget(
                            onTap: () {
                              Get.to(
                                  () => SettingsParticipationHistoryScreen());
                            },
                            title: "SUPER SAVE 지급내역".tr),

                        ///Padding of 4
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),

                        // Language Selection Widget
                        SettingScreenWidget(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8))),
                                context: (context),
                                builder: (context) => StatefulBuilder(
                                  builder: (context, setState) =>
                                      model.languageSelectionModalSheet(),
                                ),
                              );
                            },
                            title: "app_language".tr),

                        ///Padding of 4
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),

                        // Language Selection Widget
                        SettingScreenWidget(
                            onTap: () {
                              Get.to(() => UpdatePasswordScreen());
                            },
                            title: "change_password".tr),

                        ///Padding of 4
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        Divider(
                          color: greyColor20,
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),

                    ///Padding of 22
                    Padding(padding: EdgeInsets.symmetric(vertical: 11)),

                    // Privacy settings

                    Text(
                      "privacy_settings".tr,
                      style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
                    ),

                    // Padding of 22
                    Padding(padding: EdgeInsets.symmetric(vertical: 11)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.fingerprint, size: 32, color: greyColor100),

                        ///Padding of 8
                        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),

                        // Finger Print Authentication
                        Expanded(
                          child: Text(
                            "fingerprint_authentication".tr,
                            style: poppinsTextStyle(
                                16, FontWeight.w500, greyColor100),
                          ),
                        ),
                        CupertinoSwitch(
                          value: model.isBioMetricEnabled,
                          activeColor: primaryColor70,
                          thumbColor: model.isBioMetricEnabled
                              ? Colors.white
                              : greyColor30,
                          onChanged: (value) async {
                            if (model.isBioMetricEnabled) {
                              var response = await model
                                  .performTransactionWithFingerprint();
                              showCustomSnackBar(
                                "Fingerprint Authentication",
                                response["msg"],
                                response["color"],
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    PasswordValidationDialogue(model: model),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        "fingerprint_text".tr,
                        style:
                            poppinsTextStyle(16, FontWeight.w500, greyColor50),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                    Container(
                      child: Divider(
                        color: greyColor20,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 6)),

                    Text(
                      "other".tr,
                      style: poppinsTextStyle(14, FontWeight.w500, greyColor50),
                    ),

                    // Privacy Policy
                    SettingScreenWidget(
                        onTap: () {
                          Get.to(
                            () => WebViewScreen(
                              url: "https://msq.market/privacy-policy.html",
                              screenTitle: "privacy_policy",
                            ),
                          );
                        },
                        title: "privacy_policy".tr),
                    // Wallet Termination
                    SettingScreenWidget(
                        onTap: () {
                          Get.to(() => WalletTermination());
                        },
                        title: "wallet_termination".tr),
                    // Terms & Conditions
                    SettingScreenWidget(
                        onTap: () {
                          Get.to(
                            () => WebViewScreen(
                              url:
                                  "https://api.dev.msq.market/terms-and-conditions",
                              screenTitle: "terms_and_conditions",
                            ),
                          );
                        },
                        title: "terms_and_conditions".tr),
                    // Contact us Screen
                    SettingScreenWidget(
                        onTap: () {
                          Get.to(() => ContactUsScreen());
                        },
                        title: "contact_us".tr),
                    // Logging Out
                    SettingScreenWidget(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Center(
                                      child: Text("Logging Out",
                                          style: poppinsTextStyle(24,
                                              FontWeight.w500, greyColor100)),
                                    ),
                                    content: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: primaryColor70),
                                      ),
                                    ),
                                  ));
                          model.logOut(context);
                        },
                        title: "logout".tr,
                        isLogout: true),
                    Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 12),
                      child: Text(
                        "version: 1.0.3 (6)",
                        style: poppinsTextStyle(
                            10, FontWeight.normal, greyColor50),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
