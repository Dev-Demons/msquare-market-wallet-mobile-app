import 'package:msquare_market/v2/ui/screens/splash_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// [Class] that handles Mobile Payments when [User] logons to the
/// website on [MobileDevice]
class DeepLinkPayment {
  /// [String] variable that holds the payment request key
  String? requestKey;

  /// [String]? variable that holds the route to go to.
  String? route;

  /// [Boolean] flag that handles if we have a deeplink
  bool hasDeepLink = false;

  /// Main [Constructor] that initializes the Object.
  DeepLinkPayment() {
    init();
  }

  /// [Function] that initializes the Dynamic Link Payment Object with necessary
  /// data
  init() async {
    // initialize initial data
    await initDynamicLinks();
  }

  /// [Function] that resets resources after refusal to a transaction
  reset() {
    hasDeepLink = false;
    route = null;
    requestKey = null;
  }

  /// [Function] that initializes relevant data, prepares and proceeds for
  /// the Mobile Payment.
  Future<void> initDynamicLinks() async {
    // get Initial Firebase Dynamic link
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    // Check if Initial Link is not null
    if (initialLink != null) {
      // Check if link has Query Parameters
      if (initialLink.link.hasQuery) {
        // extract query parameters
        var data = initialLink.link.queryParameters;
        // extract request key
        requestKey = data["request_key"];
        route = "MobilePaymentScreen";
        // set hasDeepLink flag
        hasDeepLink = true;
        // Route to SplashScreen
        Get.to(() => SplashScreenV2());
      }
    } else {
      debugPrint("No Initial Deep Link");
    }
    // Event Listener if we have got any payment link during Application
    // LifeCycle
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      // Store dynamicLinkData
      final Uri? deeplink = dynamicLinkData.link;
      //Check if there is dynamic link
      if (deeplink != null) {
        // check if link has query parameters
        if (deeplink.hasQuery) {
          debugPrint("Deep Link Data : " + deeplink.queryParameters.toString());
          // extract Query Parameters
          var data = deeplink.queryParameters;
          // extract request key
          requestKey = data["request_key"];
          route = "MobilePaymentScreen";
          // set hasDeepLink Flag
          hasDeepLink = true;
          // Route to SplashScreen
          Get.to(() => SplashScreenV2());
        }
      }
    }).onError((error) {
      // Handle errors
      debugPrint(error);
    });
  }
}
