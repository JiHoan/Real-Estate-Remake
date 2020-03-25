import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/phuong_xa_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/quan_huyen_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';

import 'dia_chi_api_provider.dart';

class TinhThanhPhoRepository {
  final TinhThanhPhoApiProvider _tinhThanhPhoApiProvider = TinhThanhPhoApiProvider();

  Future<TinhThanhPhoListModel> getTinhThanhPho({@required String type, @required String id}) async {
    return await _tinhThanhPhoApiProvider.getTinhThanhPho(type: type, id: id);
  }

  Future<QuanHuyenListModel> getQuanHuyen({@required String type, @required String id}) async {
    return await _tinhThanhPhoApiProvider.getQuanHuyen(type: type, id: id);
  }

  Future<PhuongXaListModel> getPhuongXa({@required String type, @required String id}) async {
    return await _tinhThanhPhoApiProvider.getPhuongXa(type: type, id: id);
  }
}