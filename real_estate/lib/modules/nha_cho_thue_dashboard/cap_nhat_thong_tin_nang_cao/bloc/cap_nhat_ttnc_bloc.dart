import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/repository/cap_nhat_ttnc_repository.dart';
import 'cap_nhat_ttnc.dart';

class CapNhatTtncBloc extends Bloc<CapNhatTtncEvent, CapNhatTtncState>{
  CapNhatTtncRepository _repository = CapNhatTtncRepository();

  @override
  CapNhatTtncState get initialState => CapNhatTtncInitial();

  @override
  Stream<CapNhatTtncState> mapEventToState(CapNhatTtncEvent event) async* {
    if(event is UpdatePhapLy){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updatePhapLyChuNha(id: event.id, phapLy: event.phapLy);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateMatTien){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateMatTien(id: event.id, leDuong: event.leDuong, duongMotChieu: event.duongMotChieu);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateHem){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateHem(id: event.id, soXet: event.soXet, kichThuocHem: event.kichThuocHem, loaiHem: event.loaiHem, baoNhieuMet: event.baoNhieuMet);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateThoiGianChoThueToiDa){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateThoiGianThueToiDa(id: event.id, soNamChoThueToiDa: event.soNamThueToiDa);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateCocBaoNhieuThang){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateCocBaoNhieuThang(id: event.id, soThangCoc:  event.soThangCoc);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateGiaChaoGiaChot){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateGiaChaoGiaChot(id: event.id, giaChao: event.giaChao, giaChot: event.giaChot, bnndktg: event.nam, bnnctbnpt: event.phanTram);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateViTriThangBo){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateViTriThangBo(id: event.id, viTriThangBo: event.viTriThangBo, bnThangThoatHiem: event.bnThangThoatHiem, bnThangMay: event.bnThangMay, nhaHuongGi: event.nhaHuongGi,);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateThongTinNguoiChoThue){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateThongTinNguoiChoThue(id: event.id, nguoiChoThue: event.nguoiChoThue, phiMoiGioi: event.phiMoiGioi, nhaTheChap: event.nhaTheChap);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UpdateChuongNgaiVat){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.updateChuongNgaiVat(id: event.id, chuongNgaiVat: event.chuongNgaiVat, chuongNgaiVatKhac: event.chuongNgaiVatKhac);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is UploadHinhAnhNha){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.uploadHinhAnhNha(id: event.id, hinhAnh: event.hinhAnh);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }

    if(event is RemoveHinhAnhNha){
      yield UpdateLoading();

      try{
        final _isUpdated = await _repository.removeHinhAnh(id: event.id, idHinhAnh: event.hinhAnhId);

        if (_isUpdated) {
          yield UpdateSuccess();
        } else {
          yield UpdateFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield UpdateFailure(error: e);
      }
    }
  }
}