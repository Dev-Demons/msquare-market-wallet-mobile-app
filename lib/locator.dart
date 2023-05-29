import 'package:msquare_market/v2/core/device_type.dart';
import 'package:msquare_market/v2/core/services/deep_link_payment.dart';
import 'package:msquare_market/v2/core/services/locator_services/internet_connectivity_service.dart';
import 'package:msquare_market/v2/core/services/locator_services/password_attempt.dart';
import './v2/core/services/local_auth.dart';
import './v2/core/services/auth_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  print("locator services calling");
  locator.registerSingleton(InternetConnectivityService());
  locator.registerLazySingleton(() => PasswordAttempt());
  locator.registerSingleton(BioMetricAuthenticationServices());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerSingleton(DeviceType());
  locator.registerSingleton(DeepLinkPayment());
//TODO: Service for update balance
  // locator.registerLazySingleton(() => BalanceTracer());
}
