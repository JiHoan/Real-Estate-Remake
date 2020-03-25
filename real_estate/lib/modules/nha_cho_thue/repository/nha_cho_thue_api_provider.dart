import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

class NhaChoThueApiProvider extends ApiProvider{
  Future<NhaChoThueListModel> getNhaKhongXacDinh({@required String type, @required int page}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    Response _resp = await httpClient.get('info?hien_trang=$type&page=$page');

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return NhaChoThueListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }
}