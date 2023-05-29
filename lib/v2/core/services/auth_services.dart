import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:msquare_market/v2/core/services/local_auth.dart';
import 'package:msquare_market/v2/ui/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../locator.dart';
import '../models/user_model.dart';
import 'API/user_api_service.dart';
import 'api_services.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? firebaseUser;
  String? appleDisplayName;
  final _apiServices = ApiServices();
  //final _userAPIService = UserAPIServices();
  GoogleSignIn googleSignIn = GoogleSignIn();
  String? verificationId;
  int? resendToken;
  bool isLogin = false;
  bool isIdCreated = false;

  UserModel myAppUser = UserModel();
  String? userToken;

  getUserToken() async {
    //print(firebaseUser!.toString());
    userToken = await firebaseUser!.getIdToken();

    return userToken;
  }

  init() async {
    print("init called");
    firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      print(firebaseUser!.providerData[0].providerId);
      userToken = await firebaseUser!.getIdToken();
      print("Firebase User was logged in");
      await autoLogin();
    } else {
      print("Firebase User was not logged in ");
      isLogin = false;
    }
  }

  autoLogin() async {
    try {
      final result = await UserAPIServices().fetchCurrentUser();
      isIdCreated = true;
      isLogin = true;
      //print("Result = $result");
      myAppUser = UserModel.fromJson(result);
    } catch (error) {
      if (error.toString().contains("not found")) {
        isIdCreated = false;
        isLogin = true;
      }
    }

    // if (result == null || result == false) {
    //   isIdCreated = false;
    //   isLogin = true;
    // } else {
    //   isIdCreated = true;
    //   isLogin = true;
    //   print("Result = $result");
    //   myAppUser = UserModel.fromJson(result);
    // }
  }

  /// Sign in with Google

  Future signInWithGoogle(context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredentialData =
            await firebaseAuth.signInWithCredential(credential);

        firebaseUser = userCredentialData.user!;
        // firebaseUser!.getIdToken();
        userToken = await firebaseUser!.getIdToken();
        final result = await _apiServices.fetchUser();
        if (result == false) {
          isLogin = false;
          return false;
          // create user id
          // return false;
        } else {
          print("data saving in myAppUser");
          print(result);
          myAppUser = UserModel.fromJson(result);
          isLogin = true;

          return true;
        }
      }
    } catch (ex) {
      isLogin = false;
      print("Error: $ex");
      Get.back();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $ex",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  Future signInWithFacebook(BuildContext context) async {
    try {
      print("Facebook auth calling");
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      print("Facebook accesss calling");
      // Create a credential from the access token
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        print("Firebase auth login");
        print(facebookAuthCredential);
        final userCredentialData =
            await firebaseAuth.signInWithCredential(facebookAuthCredential);
        firebaseUser = userCredentialData.user!;
        print(firebaseUser);
        print(
          "After FirebaseUser assigned in locator: ${firebaseUser!}, ${firebaseUser!.displayName!}, ${firebaseUser!.email!}",
        );

        userToken = await firebaseUser!.getIdToken();
        final result = await _apiServices.fetchUser();
        if (result == false) {
          isLogin = false;
          return false;
        } else {
          myAppUser = UserModel.fromJson(result);

          isLogin = true;

          return true;
        }
      } else {
        print(loginResult.message);
        print(loginResult.status);
        if (loginResult.message!.contains("1675030")) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "It seems like your app is in developer mode, Please publish your app to start using Facebook login in release mode as well",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
            ),
          );
        } else if (loginResult.message!
            .contains("User has cancelled login with Facebook")) {
          print(loginResult.message!);
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loginResult.message!.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
            ),
          );
        }
        return null;
      }
    } catch (ex) {
      isLogin = false;
      print(ex);
      Get.back();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "UNEXPECTED ERROR $ex",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 6),
        ),
      );
    }
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future signInWithApple() async {
    print("object SIGN IN WITH APLE CALLED");
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      print("Given Name= ${appleCredential.givenName}");
      print("$appleCredential");
      appleDisplayName =
          "${appleCredential.givenName} ${appleCredential.familyName}";
      // appleCredential

      //  await prefs!.setString(asf:"asdf");
      print(appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        // signInMethod:
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final userCredentialData =
          await firebaseAuth.signInWithCredential(oauthCredential);
      firebaseUser = userCredentialData.user!;

      userToken = await firebaseUser!.getIdToken();
      final result = await _apiServices.fetchUser();
      if (result == false) {
        isLogin = false;
        return false;
      } else {
        print("data saving in myAppUser");
        myAppUser = UserModel.fromJson(result);
        isLogin = true;

        return true;
      }
    } catch (exception) {
      print(exception);
    }
  }

  resetAll() {
    isLogin = false;
    myAppUser = UserModel();
    firebaseUser = null;
  }

  logout() async {
    final bioM = locator<BioMetricAuthenticationServices>();
    try {
      await firebaseAuth.signOut();
      firebaseUser!.providerData[0].providerId != "facebook.com"
          ? await googleSignIn.disconnect()
          : await FacebookAuth.instance.logOut();
      // await firebaseAuth.
      //await init();
      // await GetIt.instance;
      await bioM.clearBioMetricStatus();
      //await bioM.init();
      resetAll();
      Get.offAll(SplashScreenV2());
    } catch (e) {
      print("Exception@logoutUser ==> $e");
    }
  }
}
