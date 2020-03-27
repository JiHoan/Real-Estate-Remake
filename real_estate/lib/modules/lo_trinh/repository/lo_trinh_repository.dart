import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/lo_trinh/model/lo_trinh_model.dart';
import 'package:real_estate/modules/lo_trinh/repository/lo_trinh_api_provider.dart';

class LoTrinhRepository {
  LoTrinhApiProvider _provider = LoTrinhApiProvider();

  Future<bool> themVaoLoTrinh ({@required int id}) async {
    return await _provider.themVaoLoTrinh(id: id);
  }

  Future<LoTrinhListModel> getDsLoTrinhHomNay () async {
    return await _provider.getDsLoTrinhHomNay();
  }

  Future<bool> xoaLoTrinh ({@required String id}) async {
    return await _provider.xoaLoTrinh(id: id);
  }
}