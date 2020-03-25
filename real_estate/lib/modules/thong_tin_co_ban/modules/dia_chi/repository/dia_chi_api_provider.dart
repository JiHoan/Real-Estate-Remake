import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/phuong_xa_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/quan_huyen_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';

class TinhThanhPhoApiProvider extends ApiProvider {
  Future<TinhThanhPhoListModel> getTinhThanhPho({@required String type, @required String id}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    Map<String, String> _requestBody = {'type': type, 'id': id};
    Response _resp = await httpClient.post('dia-chi/search', data: _requestBody);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return TinhThanhPhoListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }

  Future<QuanHuyenListModel> getQuanHuyen({@required String type, @required String id}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    Map<String, String> _requestBody = {'type': type, 'id': id};
    Response _resp = await httpClient.post('dia-chi/search', data: _requestBody);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return QuanHuyenListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }

  Future<PhuongXaListModel> getPhuongXa({@required String type, @required String id}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    Map<String, String> _requestBody = {'type': type, 'id': id};
    Response _resp = await httpClient.post('dia-chi/search', data: _requestBody);

    httpClient.options.headers.clear();

    print(PhuongXaListModel.fromJson(_resp.data['data']));

    if (_resp.statusCode == 200) {
      return PhuongXaListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }
}
