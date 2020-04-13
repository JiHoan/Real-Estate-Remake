import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/call_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/repository/nha_cho_thue_detail_repository.dart';
import 'call_logs.dart';

class CallLogsBloc extends Bloc<CallLogsEvent, CallLogsState>{
  NhaChoThueDetailRepository _nhaChoThueDetailRepository = NhaChoThueDetailRepository();

  @override
  CallLogsState get initialState => CallLogsInitial();

  @override
  Stream<CallLogsState> mapEventToState(CallLogsEvent event) async* {
    if (event is GetCallLogs){
      yield CallLogsLoading();

      try {
        CallLogsListModel listModel = await _nhaChoThueDetailRepository.getCallLogs(id: event.id);

        if (listModel.isNotEmpty) {
          yield CallLogsLoaded(callLogsListModel: listModel);
        } else {
          yield CallLogsEmpty();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield CallLogsFailure(error: e);
      }
    }
  }
}