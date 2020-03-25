import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

import 'nha_cho_thue_api_provider.dart';

class NhaChoThueRepository{
  NhaChoThueApiProvider _khongXacDinhApiProvider = NhaChoThueApiProvider();

  Future<NhaChoThueListModel> getNhaKhongXacDinh({@required String type, @required int page}) async {
    return await _khongXacDinhApiProvider.getNhaKhongXacDinh(type: type, page: page);
  }
}