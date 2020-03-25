import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/thong_tin_co_ban/model/thong_tin_co_ban_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/repository/thong_tin_co_ban_api_provider.dart';

class ThongTinCoBanRepository {
  ThongTinCoBanApiProvider _thongTinCoBanApiProvider = ThongTinCoBanApiProvider();

  Future<bool> saveAdd({@required ThongTinCoBanModel model}) async {
    return await _thongTinCoBanApiProvider.saveAdd(model: model);
  }
}
