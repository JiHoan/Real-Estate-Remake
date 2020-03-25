import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/repository/dia_chi_repository.dart';

import 'dia_chi.dart';
import 'package:bloc/bloc.dart';

class TinhThanhPhoBloc extends Bloc<TinhThanhPhoEvent, TinhThanhPhoState> {
  TinhThanhPhoRepository _tinhThanhPhoRepository = TinhThanhPhoRepository();
  TinhThanhPhoListModel _tinhThanhPhoListModel;

  @override
  // TODO: implement initialState
  TinhThanhPhoState get initialState => TinhThanhPhoInitial();

  @override
  Stream<TinhThanhPhoState> mapEventToState(TinhThanhPhoEvent event) async* {
    if (event is TinhThanhPhoFetch) {
      yield TinhThanhPhoLoading();

      try {
        final _listTinhTp = await _tinhThanhPhoRepository.getTinhThanhPho(type: 'NONE', id: '0');

        if (_listTinhTp != null) {
          _tinhThanhPhoListModel = _listTinhTp;

          yield TinhThanhPhoSuccess(tinhThanhPhoListModel: _listTinhTp);
        } else {
          //todo
        }
      } catch (e) {}
    }

    if (event is TinhThanhPhoSearch) {
      try {
        final listModel = _tinhThanhPhoListModel
            .where((data) {
              RegExp exp = new RegExp(r"" + event.value + "", caseSensitive: false);
              String str = data.name;
              return exp.hasMatch(str);
            })
            .toList()
            .map((item) => item.toJson());

        yield TinhThanhPhoAutocomplete(tinhThanhPhoListModel: TinhThanhPhoListModel.fromJson(listModel.toList()));
      } catch (e) {
        print(e);
      }
    }

    if(event is QuanHuyenFetch){
      try{
        final _listQuanHuyen = await _tinhThanhPhoRepository.getQuanHuyen(type: 'TINH_THANH_PHO', id: event.id);

        if (_listQuanHuyen != null) {
          yield QuanHuyenSuccess(quanHuyenListModel: _listQuanHuyen);
        } else {
          //todo
        }
      }catch(error){
        print(error);
      }
    }
  }
}
