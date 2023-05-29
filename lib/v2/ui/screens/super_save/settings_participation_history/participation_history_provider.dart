import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/core/models/base_view_model.dart';
import 'package:msquare_market/v2/core/models/super_save/participation_detail_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';

class ParticipationHistoryProvider extends BaseViewModal {
  SuperSaveAPIService _superSaveAPIService = SuperSaveAPIService();
  SuperSaveModel? superSaveModel;
  ParticipationHistoryModel? participationHistoryModel;
  int selectedIndex = 0;

  ParticipationHistoryProvider() {
    init();
  }
  init() async {
    setState(ViewState.busy);
    await fetchSuperSaveParticipationHistory();
    setState(ViewState.idle);
  }

  fetchSuperSaveParticipationHistory() async {
    var response = await _superSaveAPIService.requestParticipationHistory();

    if (!response['error']) {
      participationHistoryModel =
          ParticipationHistoryModel.fromJSON(response['data']);
    }
  }
}
