import 'package:flutter/cupertino.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

class NhaChoThueApiProvider extends ApiProvider{
  Future<NhaChoThueListModel> getNhaChoThue({@required String type, @required int page}) async {
    Response _resp = await httpClient.get('info?hien_trang=$type&page=$page');

    if (_resp.statusCode == 200) {
      return NhaChoThueListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }
}