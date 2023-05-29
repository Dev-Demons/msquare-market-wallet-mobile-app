import 'package:msquare_market/v2/ui/components/custom_snackbars.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BioMetricAuthenticationServices {
  late LocalAuthentication _localAuthentication;
  late bool isBiometricSupported;
  late bool canCheckBiometrics;
  late bool isDeviceSupported;
  bool canAuthenticateWithBiometrics = false;
  late SharedPreferences prefs;
  bool isBioMetricEnabled = false;
  List<BiometricType> enrolledBiometrics = [];
  BioMetricAuthenticationServices() {
    init();
  }

  init() async {
    print("BioMetricAuthInitialized");

    _localAuthentication = LocalAuthentication();
    isBiometricSupported = await _localAuthentication.isDeviceSupported();

    isDeviceSupported = await _localAuthentication.isDeviceSupported();
    canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    canAuthenticateWithBiometrics = canCheckBiometrics || isDeviceSupported;

    enrolledBiometrics = await _localAuthentication.getAvailableBiometrics();

    prefs = await SharedPreferences.getInstance();
    final x = prefs.getBool('isBiometricEnabled');
    if (x == null || !x) {
      print("Biometric has not been enabled");
    } else {
      isBioMetricEnabled = true;
      print("Biometric is already enabled");
    }
  }

  Future<bool> authenticateUser() async {
    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.

    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: enrolledBiometrics.contains(BiometricType.face)
              ? "Scan your face to authenticate"
              : 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(biometricOnly: true),
        );
      } on PlatformException catch (e) {
        print(e);
        SnackBars.errorSnackBar("Error", "$e");
      }
    }
    return isAuthenticated;
  }

  Future<bool> setBiometricAuthPref(bool value) async {
    final result = await prefs.setBool("isBiometricEnabled", value);
    if (result) {
      isBioMetricEnabled = value;
      return true;
    } else {
      return false;
    }
  }

  clearBioMetricStatus() async {
    print("Disabling biometric auth");
    return await setBiometricAuthPref(false);
  }
}
