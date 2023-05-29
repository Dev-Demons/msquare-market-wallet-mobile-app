import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';

import '../../../../core/models/super_save/bank_model.dart';

class UserBankProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  List<BankModel> banks = [];
  UserBankProvider() {
    init();
  }
  init() async {
    setState(ViewState.busy);
    await fetchUserBanks();
    setState(ViewState.idle);
  }

  fetchUserBanks() async {
    var result = await _superSaveAPIService.fetchUserBanks();
    if (result['error']) {
      banks = [];
    } else {
      for (var item in result['data']) {
        banks.add(BankModel.fromJSON(item));
      }
    }
  }

  addBankAccount({required String name, required String account}) async {
    setState(ViewState.busy);
    var result =
        await _superSaveAPIService.addBank(name: name, account: account);
    setState(ViewState.idle);
    return result;
  }

  changeMainAccount({required String bankID}) async {
    setState(ViewState.busy);
    var result = await _superSaveAPIService.setMainBank(id: bankID);
    setState(ViewState.idle);
    return result;
  }

  deleteBankAccount({required String bankID}) async {
    setState(ViewState.busy);
    var result = await _superSaveAPIService.deleteBankAccount(id: bankID);
    setState(ViewState.idle);
    return result;
  }
}
