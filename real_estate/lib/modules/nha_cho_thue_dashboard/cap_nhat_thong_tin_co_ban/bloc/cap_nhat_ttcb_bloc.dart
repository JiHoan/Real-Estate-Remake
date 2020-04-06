import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/repository/nha_cho_thue_detail_repository.dart';
import 'cap_nhat_ttcb.dart';

class CapNhatTtcbBloc extends Bloc<CapNhatTtcbEvent, CapNhatTtcbState> {
  NhaChoThueDetailRepository _nhaChoThueDetailRepository = NhaChoThueDetailRepository();

  @override
  CapNhatTtcbState get initialState => NhaChoThueDetailInitial();

  @override
  Stream<CapNhatTtcbState> mapEventToState(CapNhatTtcbEvent event) async* {
    if (event is FetchDetail) {
      yield FetchLoading();

      try {
        final _model = await _nhaChoThueDetailRepository.getNhaChoThueDetail(id: event.id);

        if (_model != null) {
          yield FetchLoaded(model: _model);
        } else {
          yield FetchEmpty();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield FetchFailure(error: e);
      }
    }

    if (event is UpdateHienTrang) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateHienTrang(
          id: event.id,
          hienTrang: event.hienTrang,
          sdt: event.sdt,
          ten: event.ten,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is UpdateRow) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateRow(
          type: event.type,
          obType: event.obType,
          id: event.id,
          text: event.text,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is UpdateThongTinLienHe) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateThongTinLienHe(
          model: event.model,
          id: event.id,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is UpdateDienTichKetCauNoiThat) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateDienTichKetCauNoiThat(
          model: event.model,
          id: event.id,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is UpdateVAT) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateVAT(
          model: event.model,
          id: event.id,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is RemoveHinhAnh) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.removeHinhAnh(
          banVeId: event.banVeId,
          id: event.id,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is UpdateDiaChi) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateDiaChi(
          id: event.id,
          thanhPho: event.thanhPho,
          quanHuyen: event.quanHuyen,
          phuongXa: event.phuongXa,
          soNha: event.soNha,
          tenDuong: event.tenDuong,
        );

        if (_isUpdated == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if (event is UpdateAndRemove) {
      yield UpdateLoading();

      try {
        final _isUpdated = await _nhaChoThueDetailRepository.updateDienTichKetCauNoiThat(
          model: event.model,
          id: event.id,
        );

        final _isRemove = await _nhaChoThueDetailRepository.removeHinhAnh(
          banVeId: event.banVeId,
          id: event.id,
        );

        if (_isUpdated == true && _isRemove == true) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }
  }
}
