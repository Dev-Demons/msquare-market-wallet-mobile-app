import 'dart:developer';
import 'package:msquare_market/v2/core/services/API/user_api_service.dart';
import '../../../../locator.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/base_view_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/auth_services.dart';

/// [ViewModel] that communicates between [Models], [Utilities] and [API]s and send the
/// required [data] to our [View] which here is [WalletScreen]
class WalletScreenProvider extends BaseViewModal {
  /// [AuthServices] locator that handles [User]'s data and authentications
  final locateUser = locator<AuthServices>();

  /// [ApiServices] that handles main [API] Services
  final _apiServices = ApiServices();

  final _userAPI = UserAPIServices();

  /// [Variable] that stores total number of tokens a [User] has.
  var availableBalance = 0.00;

  /// [Variable] that stores total value of all tokens.
  var availableBalanceInKRW = 0.00;

  /// [Constructor] that initializes some of the main components.
  WalletScreenProvider() {
    // calls init function
    init();
  }

  /// [Function] that fetches:
  /// - [Token] Balances
  /// - [Token] Prices
  ///
  /// and than calculates:
  /// - Total Number of tokens
  /// - Total value of all tokens
  init() async {
    setState(ViewState.busy);
    // fetch token balances
    await fetchNewBalances();
    await generateTotalBalance();
    setState(ViewState.idle);
  }

  fetchNewBalances() async {
    try {
      final userTokens = await _userAPI.fetchCurrentUserTokens();
      final pricesData = await _apiServices.getPricesAPi();
      if (userTokens != false && pricesData != false) {
        await locateUser.myAppUser
            .updateTokenInfo(userTokens, pricesData["tokens"]);
      }
      notifyListeners();
    } catch (e) {
      log("catch ${e.toString()}");
    }
  }

  generateTotalBalance() async {
    locateUser.myAppUser.wallet!.tokens!.forEach((element) {
      availableBalance += element.balance!;
    });
  }
}
