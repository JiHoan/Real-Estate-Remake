import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/repository/khach_tim_mb_repository.dart';
import 'khach_tim_mb.dart';
import 'package:rxdart/rxdart.dart';

class KhachTimMbBloc extends Bloc<KhachTimMbEvent, KhachTimMbState> {
  KhachTimMbRepository _repository = KhachTimMbRepository();
  int temp = 1;

  @override
  Stream<KhachTimMbState> transformEvents(
    Stream<KhachTimMbEvent> events,
    Stream<KhachTimMbState> Function(KhachTimMbEvent event) next,
  ) {
    if (state is LoadMoreDsKhachTimMb) {
      return super.transformEvents(
        events.debounceTime(
          Duration(milliseconds: 500),
        ),
        next,
      );
    }
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 0),
      ),
      next,
    );
  }

  @override
  KhachTimMbState get initialState => KhachTimMbInitial();

  @override
  Stream<KhachTimMbState> mapEventToState(KhachTimMbEvent event) async* {
    final currentState = state;

    if (event is ThemKhachTimMb) {
      yield KhachTimMbLoading();

      try {
        var isSuccess = await _repository.themKhachTimMb(khachTimMbModel: event.model);

        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is FetchDetail) {
      yield KhachTimMbLoading();

      try {
        final detail = await _repository.getDetailKhachTimMb(id: event.id);

        if (detail != null) {
          yield DetailKhachTimMbLoaded(model: detail);
        } else {
          yield KhachTimMbEmpty();
        }
      } catch (e, s) {
        print(e);
        print(s);

        yield KhachTimMbFailure(error: e.toString());
      }
    }

    if (event is FetchDsKhachTimMb) {
      yield KhachTimMbLoading();
      temp = 1;

      try {
        final _danhSach = await _repository.getDsKhachTimMb(tinhTrang: event.type, page: 1);

        if (_danhSach.khachTimMbListModel.isNotEmpty) {
          yield KhachTimMbLoaded(khachTimMbListModel: _danhSach.khachTimMbListModel, hasReachedMax: _reachedMax(_danhSach.khachTimMbListModel.length), page: 1, count: _danhSach.count);
        } else {
          yield KhachTimMbEmpty();
        }
      } catch (e, s) {
        print(e);
        print(s);

        yield KhachTimMbFailure(error: e.toString());
      }
    }

    bool _hasReachedMax(KhachTimMbState state) => state is KhachTimMbLoaded && state.hasReachedMax;

    if (event is LoadMoreDsKhachTimMb && _hasReachedMax(state)) {
      try {
        if (currentState is KhachTimMbInitial) {
          final _danhSach = await _repository.getDsKhachTimMb(tinhTrang: event.type, page: 1);

          yield KhachTimMbLoaded(khachTimMbListModel: _danhSach.khachTimMbListModel, hasReachedMax: false, count: _danhSach.count);
          return;
        }

        if (currentState is KhachTimMbLoaded) {
          temp++;
          final _danhSach = await _repository.getDsKhachTimMb(tinhTrang: event.type, page: temp);

          final copyListNhaKhongXacDinh = KhachTimMbListModel.fromJson(currentState.khachTimMbListModel.toJson());

          yield _danhSach.khachTimMbListModel.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : KhachTimMbLoaded(
                  khachTimMbListModel: copyListNhaKhongXacDinh..addAll(_danhSach.khachTimMbListModel),
                  hasReachedMax: true,
                  page: temp,
                  count: _danhSach.count,
                );
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure(error: e.toString());
      }
    }

    if (event is UpdateTinhTrang) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateTinhTrang(id: event.id, tinhTrang: event.tinhTrang);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateThongTinLienHe) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateThongTinLienHe(id: event.id, sdt: event.sdt, ten: event.ten);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateMucDichThue) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateMucDichThue(id: event.id, mucDich: event.mucDich);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateKetCauNhaCanThue) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateKetCauNhaCanThue(id: event.id, model: event.model);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateGiaCanThue) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateGiaCanThue(id: event.id, giaMin: event.giaMin, giaMax: event.giaMax);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateThoiGianThue) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateThoiGianThue(id: event.id, thoiGianThue: event.thoiGianThue);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateKhachLauNam) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess =
            await _repository.updateKhachLauNam(id: event.id, khachLauNam: event.khachLauNam, loaiHinh: event.loaiHinh);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateLoaiKhachHang) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateLoaiKhachHang(
            id: event.id, loaiKhachHang: event.loaiKhach, tenThuongHieu: event.tenThuongHieu);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateMoTaKhac) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateMoTaKhac(id: event.id, moTaKhac: event.moTaKhac);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UpdateKhuVucCanThue) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.updateKhuVucCanThue(
            id: event.id, thanhPho: event.thanhPho, quan: event.quan, phuong: event.phuong, tenDuong: event.tenDuong);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is UploadHinhAnh) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.uploadHinhAnh(id: event.id, hinhAnh: event.hinhAnh);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }

    if (event is RemoveHinhAnh) {
      yield KhachTimMbLoading();
      try {
        bool isSuccess = await _repository.removeHinhAnh(id: event.id, idHinhAnh: event.hinhAnhId);
        if (isSuccess == true) {
          yield KhachTimMbSuccess();
        } else {
          yield KhachTimMbFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield KhachTimMbFailure();
      }
    }
  }

  bool _reachedMax(int length) {
    print('length: $length');
    return length < 10 ? true : false;
  }
}
