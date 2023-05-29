import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';

import '../../../../core/models/super_save/reserve_model.dart';

class ReserveHistoryProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  List<ReserveModel> reserves = [];
  ReserveHistoryProvider() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    await fetchReservesHistoryData();
    setState(ViewState.idle);
  }

  fetchReservesHistoryData() async {
    var response = await _superSaveAPIService.fetchReserveHistory();
    if (response['error']) {
      reserves = [];
    } else {
      for (var item in response['data']) {
        reserves.add(ReserveModel.fromJSON(item));
      }
    }
  }
}
