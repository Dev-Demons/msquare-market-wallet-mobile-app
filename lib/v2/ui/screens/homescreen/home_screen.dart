import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/screens/homescreen/homescreen_provider.dart';
import 'package:msquare_market/v2/ui/screens/notifications/notifications.dart';
import 'package:msquare_market/v2/ui/screens/p2p/p2p_provider.dart';
import 'package:msquare_market/v2/ui/screens/p2p/p2p_screen.dart';
import 'package:msquare_market/v2/ui/screens/scanning/barcode_screen.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../core/enums/view_state.dart';
import '../../widgets/home_screen_widgets/crypto_widget.dart';
import '../../widgets/home_screen_widgets/slide_show_banner.dart';
import '../../widgets/shimmer_widgets/shimmer_token_widget.dart';
import '../swap/main_swap_screen.dart';

/// A [Screen]/[View] made up of [StatefulWidget] that acts as the main
/// screen for the application.
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey scanQRButton = GlobalKey();
  GlobalKey bellButton = GlobalKey();
  List<TargetFocus> targets = [];
  TutorialCoachMark? tutorialCoachMark;

  @override
  void initState() {
    //Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double turns = 0.0;
  Duration duration = Duration(milliseconds: 2000);
  void playSyncBalanceAnimation() {
    setState(() => turns += 1.0);
    // Future.delayed(duration)
    //     .then((value) => showToast(message: "Balance Sync"));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, model, child) {
        return Scaffold(
          // main app bar
          appBar: AppBar(
            centerTitle: false,
            //Application main logo
            title: Image.asset("assets/v2/home-logo.png", scale: 2.9),
            automaticallyImplyLeading: false,
            actions: [
              // Barcode icon
              IconButton(
                key: ValueKey("scanQRCode"),
                onPressed: () {
                  Get.to(() => BarCodeScreen());
                },
                icon: Image.asset("assets/v2/scan.png",
                    scale: 2.9, color: greyColor50),
              ),

              // Notification Icon
              IconButton(
                key: bellButton,
                onPressed: () {
                  Get.to(() => NotificationScreen());
                },
                icon: Image.asset(
                  "assets/v2/bell.png",
                  scale: 2.9,
                  color: greyColor50,
                ),
              ),
            ],
            // Bottom Border
            bottom: PreferredSize(
              child: DividerWidget(),
              preferredSize: Size.fromHeight(1.0),
            ),
          ),
          body: StreamBuilder(
            initialData: {"trend": "0.0", "balance": "0.0"},
            stream: model.fetchLiveBalanceAndTrend(),
            builder: (context, snapshot) {
              var trendData =
                  double.parse(model.myAppUser.totalBalanceTrend.toString());
              var balanceData =
                  double.parse(model.myAppUser.totalBalanceInKRW.toString())
                      .toStringAsFixed(3);
              if (balanceData == "0.000") {
                trendData = 0.0;
              }
              if (trendData == 0.0) {
                model.trendIcon = Icons.trending_neutral;
                model.trendColor = greyColor50;
              } else if (trendData < 0.0) {
                model.trendIcon = Icons.trending_down;
                model.trendColor = dangerColor10;
              } else {
                model.trendIcon = Icons.trending_up;
                model.trendColor = successColor30;
              }
              // }
              // else if()
              return RefreshIndicator(
                // triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  await model.fetchNewBalances();
                  return;
                },
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    // Banner Slideshow
                    Container(
                      padding: EdgeInsets.symmetric(
                        // horizontal: 20,
                        vertical: 16,
                      ),
                      child: ImageSlideshow(
                        height: 150,
                        isLoop: true,
                        autoPlayInterval: 10000,
                        indicatorColor: primaryColor70,
                        indicatorBackgroundColor:
                            primaryColor70.withOpacity(0.25),
                        indicatorRadius: 3,
                        children: [
                          SlideShowBanner(
                            asset: "banner",
                            url: "https://businesshub.co.kr/",
                          ),
                          SlideShowBanner(
                            asset: "banner1",
                            url: "https://kfriends.live/",
                          ),
                          SlideShowBanner(
                            asset: "banner2",
                            url: "https://www.flabook.club/",
                          ),
                          SlideShowBanner(
                            asset: "banner3",
                            url: "https://metastarglobal.io/",
                          ),
                          SlideShowBanner(
                            asset: "banner4",
                            url: "https://p2u.kr/",
                          ),
                        ],
                      ),
                    ),
                    // Rounded Card to show balance and trend
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(color: greyColor20)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  // Total Balance in KRW text
                                  child: Row(
                                    children: [
                                      Text(
                                        "Total_balance_in ".tr,
                                        style: poppinsTextStyle(
                                            14, FontWeight.w500, greyColor50),
                                      ),
                                      Text(
                                        " KRW".tr,
                                        style: poppinsTextStyle(
                                            14, FontWeight.w500, greyColor100),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Text(
                                    "₩ $balanceData",
                                    style: poppinsTextStyle(
                                        20, FontWeight.w500, Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        model.trendIcon,
                                        color: model.trendColor,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2)),
                                      Text(
                                        trendData.toStringAsFixed(2),
                                        style: poppinsTextStyle(
                                          14,
                                          FontWeight.w500,
                                          model.trendColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            AnimatedRotation(
                              turns: turns,
                              duration: duration,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: greyColor100.withOpacity(0.08),
                                child: IconButton(
                                  onPressed: () async {
                                    playSyncBalanceAnimation();
                                    await model.syncBalanceCallRPA(context);
                                  },
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.sync,
                                    color: greyColor100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ListTile to show P2P trading button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: greyColor20)),
                        title: Text(
                          "p2p_trading".tr,
                          style: poppinsTextStyle(
                              14, FontWeight.w500, greyColor100),
                        ),
                        subtitle: Text(
                          "p2p_trading_msg".tr,
                          style: poppinsTextStyle(
                              14, FontWeight.w500, greyColor50),
                        ),
                        trailing: CircleAvatar(
                          radius: 22,
                          backgroundColor: greyColor100.withOpacity(0.08),
                          child: IconButton(
                            iconSize: 20,
                            icon:
                                Icon(Icons.arrow_forward, color: greyColor100),
                            onPressed: () {
                              //initialize P2PProvider
                              Provider.of<P2PProvider>(
                                context,
                                listen: false,
                              ).init();
                              // fetch data for P2PProvider
                              Provider.of<P2PProvider>(
                                context,
                                listen: false,
                              ).fetchAllOrdersData();
                              // Navigate to P2P Screen
                              Get.to(() => P2pScreen());
                            },
                          ),
                        ),
                      ),
                    ),
                    // Container to hold Tokens
                    Container(
                      color: greyColor0,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tokens text
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Tokens".tr,
                              style: model.locateSize.largeTextStyle,
                            ),
                          ),
                          model.state == ViewState.busy
                              ? Shimmer.fromColors(
                                  baseColor: greyColor20,
                                  highlightColor: greyColor0,
                                  child: Column(
                                    children: [
                                      ShimmerTokenWidget(),
                                      ShimmerTokenWidget(),
                                      ShimmerTokenWidget()
                                    ],
                                  ),
                                )
                              : model.myAppUser.wallet!.tokens!.isEmpty
                                  ? Text("No Tokens")
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: model
                                          .myAppUser.wallet!.tokens!.length,
                                      itemBuilder: (context, index) {
                                        var token = model
                                            .myAppUser.wallet!.tokens![index];
                                        return CryptoWidget(
                                          token: token.name!,
                                          tokenBalance:
                                              model.state == ViewState.busy
                                                  ? "..."
                                                  : token.balance,
                                          valueOfToken: model.state ==
                                                  ViewState.busy
                                              ? "..."
                                              : '₩ ${token.price!.toStringAsFixed(2)}',
                                          valueOfBalance: model.state ==
                                                  ViewState.busy
                                              ? "..."
                                              : '₩ ${token.price! * token.balance!}',
                                          onTap: () {
                                            print(token.name);
                                            if (token.name!.contains("MATIC") ||
                                                token.name!.contains("P2UP")) {
                                              //show response we don't support swapping these tokens
                                            } else {
                                              Get.to(
                                                () => MainSwapScreen(
                                                    tokenName: token.name!,
                                                    balance: token.balance!),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          backgroundColor: greyColor0,
        );
      },
    );
  }

  void showTutorial() {
    targets = [];
    createTutorial();
    tutorialCoachMark!.show(context: context);
  }

  void createTutorial() {
    targets.add(
      TargetFocus(
        keyTarget: scanQRButton,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            builder: (context, controller) {
              return Center(
                child: Container(
                  child: Text(
                    "Scan QR Code",
                    style: poppinsTextStyle(16, FontWeight.w500, greyColor0),
                  ),
                ),
              );
            },
          )
        ],
        shape: ShapeLightFocus.Circle,
        radius: 2,
      ),
    );
    targets.add(
      TargetFocus(
        keyTarget: bellButton,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            builder: (context, controller) {
              return Center(
                child: Container(
                  child: Text("Notifications",
                      style: poppinsTextStyle(16, FontWeight.w500, greyColor0)),
                ),
              );
            },
          )
        ],
        shape: ShapeLightFocus.Circle,
        radius: 2,
      ),
    );
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: primaryColor70,
      textSkip: "Skip",
      paddingFocus: 0,
      opacityShadow: 0.8,
    );
  }
}
