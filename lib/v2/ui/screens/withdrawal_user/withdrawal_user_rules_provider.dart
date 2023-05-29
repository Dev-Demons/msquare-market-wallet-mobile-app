import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/models/super_save/withdrawal_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';

import '../../../core/models/super_save/bank_model.dart';

/// A [ViewModel]/[ScreenProvider] that fetches data from [API]s and [Model]
/// and transmits data to [View]  which here is [WithdrawalUserRules]

class WithdrawalUserRulesProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  BankModel userMainBank = BankModel();
  int cumulativeAmount = 0;
  bool isLoading = false;
  WithdrawalUserRulesProvider() {
    init();
  }

  changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  init() async {
    setState(ViewState.busy);
    await fetchUserMainBank();
    await fetchCumulativeAmount();
    setState(ViewState.idle);
  }

  fetchUserMainBank() async {
    var response = await _superSaveAPIService.fetchUserMainBankAccDetails();
    if (response['error']) {
      userMainBank = BankModel();
    } else {
      userMainBank = BankModel.fromJSON(response['data']);
    }
  }

  fetchCumulativeAmount() async {
    var response = await _superSaveAPIService.fetchCumulativePayment();
    if (response['error']) {
      cumulativeAmount = 0;
    } else {
      cumulativeAmount = response['data'];
    }
  }

  userWithdrawal({required String reason, required String desc}) async {
    changeLoading();
    WithdrawalModel user = WithdrawalModel(reason, desc, userMainBank.bankName!,
        userMainBank.bankAccount!, cumulativeAmount);

    var response = await _superSaveAPIService.withdrawalUser(model: user);
    changeLoading();
    return response;
  }
}
