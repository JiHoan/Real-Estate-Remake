import 'package:flutter/material.dart';
import 'package:real_estate/modules/khach_tim_mb/model/detail_ktmb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/repository/khach_tim_mb_api_provider.dart';

class KhachTimMbRepository {
  KhachTimMbApiProvider _apiProvider = KhachTimMbApiProvider();

  Future<bool> themKhachTimMb({@required KhachTimMbModel khachTimMbModel}) async {
    return await _apiProvider.themKhachTimMb(khachTimMbModel: khachTimMbModel);
  }

  Future<KhachTimMbListModel> getDsKhachTimMb({@required String tinhTrang, @required int page}) async {
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
}