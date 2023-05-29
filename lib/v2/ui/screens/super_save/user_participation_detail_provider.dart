import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';

import '../../../core/models/super_save/participation_detail_model.dart';

class UserParticipationDetailProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  List<SuperSaveModel> history = [];
  int selectedIndex = 0;

  UserParticipationDetailProvider() {
    init();
  }
  init() async {
    setState(ViewState.busy);
    await fetchSuperSaveHistory();
    setState(ViewState.idle);
  }

  fetchSuperSaveHistory() async {
    setState(ViewState.busy);
    var response = await _superSaveAPIService.requestHistory();
    if (response['error']) {
      history = [];
    } else {
      for (var item in response['data']) {
        history.add(SuperSaveModel.fromJSON(item));
      }
    }
    setState(ViewState.idle);
    // return response['data']['superSaveReq'];
  }
}
