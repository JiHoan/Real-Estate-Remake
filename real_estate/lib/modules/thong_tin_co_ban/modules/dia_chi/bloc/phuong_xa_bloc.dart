import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/repository/dia_chi_repository.dart';

import 'dia_chi.dart';

class PhuongXaBloc extends Bloc<PhuongXaEvent, PhuongXaState> {
  TinhThanhPhoRepository _tinhThanhPhoRepository = TinhThanhPhoRepository();

  @override
  // TODO: implement initialState
  PhuongXaState get initialState => PhuongXaInitial();

  @override
  Stream<PhuongXaState> mapEventToState(PhuongXaEvent event) async* {
    if (event is PhuongXaFetch) {
      try {
        final _listPhuongXa = await _tinhThanhPhoRepository.getPhuongXa(type: 'QUAN_HUYEN', id: event.id);

        if (_listPhuongXa != null) {
          yield PhuongXaSuccess(phuongXaListModel: _listPhuongXa);
        } else {
          yield PhuongXaFailure();
        }
      } catch (error) {
        print(error);
      }
    }
  }
}
