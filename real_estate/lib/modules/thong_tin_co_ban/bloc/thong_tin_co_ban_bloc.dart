import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/thong_tin_co_ban/repository/thong_tin_co_ban_repository.dart';
import 'thong_tin_co_ban.dart';

class ThongTinCoBanBloc extends Bloc<ThongTinCoBanEvent, ThongTinCoBanState> {
  ThongTinCoBanRepository _thongTinCoBanRepository = ThongTinCoBanRepository();

  @override
  ThongTinCoBanState get initialState => ThongTinCoBanInitial();

  @override
  Stream<ThongTinCoBanState> mapEventToState(ThongTinCoBanEvent event) async* {
    if (event is ThongTinCoBanSave) {
      yield ThongTinCoBanSaveLoading();

      try {
        bool isSuccess = await _thongTinCoBanRepository.saveAdd(model: event.thongTinCoBanModel);

        if (isSuccess == true) {
          yield ThongTinCoBanSaveSuccess();
        }
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}
