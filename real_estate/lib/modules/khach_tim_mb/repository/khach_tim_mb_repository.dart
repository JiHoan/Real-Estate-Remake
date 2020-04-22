import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_estate/modules/khach_tim_mb/model/detail_ktmb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/repository/khach_tim_mb_api_provider.dart';

class KhachTimMbRepository {
  KhachTimMbApiProvider _apiProvider = KhachTimMbApiProvider();

  Future<bool> themKhachTimMb({@required KhachTimMbModel khachTimMbModel}) async {
    return await _apiProvider.themKhachTimMb(khachTimMbModel: khachTimMbModel);
  }

  Future<KhachCommonModel> getDsKhachTimMb({@required String tinhTrang, @required int page}) async {
    return await _apiProvider.getDsKhachTimMb(tinhTrang: tinhTrang, page: page);
  }

  Future<DetailKtmbModel> getDetailKhachTimMb({@required int id}) async {
    return await _apiProvider.getDetailKhachTimMb(id: id);
  }

  Future<bool> updateTinhTrang({@required int id,@required String tinhTrang}) async {
    return await _apiProvider.updateTinhTrang(id: id, tinhTrang: tinhTrang);
  }

  Future<bool> updateThongTinLienHe({@required int id, @required String sdt, @required String ten}) async {
    return await _apiProvider.updateThongTinLienHe(id: id, sdt: sdt, ten: ten);
  }

  Future<bool> updateMucDichThue({@required int id, @required String mucDich}) async {
    return await _apiProvider.updateMucDichThue(id: id, mucDich: mucDich);
  }

  Future<bool> updateKetCauNhaCanThue({@required int id, @required KhachTimMbModel model}) async {
    return await _apiProvider.updateKetCauNhaCanThue(id: id, model: model);
  }

  Future<bool> updateGiaCanThue({@required int id, @required int giaMin, @required int giaMax}) async {
    return await _apiProvider.updateGiaCanThue(id: id, giaMin: giaMin, giaMax: giaMax);
  }

  Future<bool> updateThoiGianThue({@required int id, @required int thoiGianThue}) async {
    return await _apiProvider.updateThoiGianThue(id: id, thoiGianThue: thoiGianThue);
  }

  Future<bool> updateKhachLauNam({@required int id, @required String khachLauNam, @required String loaiHinh}) async {
    return await _apiProvider.updateKhachLauNam(id: id, khachLauNam: khachLauNam, loaiHinh: loaiHinh);
  }

  Future<bool> updateLoaiKhachHang({@required int id, @required String loaiKhachHang, @required String tenThuongHieu}) async {
    return await _apiProvider.updateLoaiKhachHang(id: id, loaiKhachHang: loaiKhachHang, tenThuongHieu: tenThuongHieu);
  }

  Future<bool> updateMoTaKhac({@required int id, @required String moTaKhac}) async {
    return await _apiProvider.updateMoTaKhac(id: id, moTaKhac: moTaKhac);
  }

  Future<bool> updateKhuVucCanThue({@required int id, @required String thanhPho, @required String quan, @required String phuong, @required String tenDuong}) async {
    return await _apiProvider.updateKhuVucCanThue(id: id, thanhPho: thanhPho, quan: quan, phuong: phuong, tenDuong: tenDuong);
  }

  Future<bool> uploadHinhAnh({@required int id, @required List<File> hinhAnh}) async {
    return await _apiProvider.uploadHinhAnh(id: id, hinhAnh: hinhAnh);
  }

  Future<bool> removeHinhAnh({@required int id, @required List<int> idHinhAnh}) async {
    return await _apiProvider.removeHinhAnh(id: id, idHinhAnh: idHinhAnh);
  }
}