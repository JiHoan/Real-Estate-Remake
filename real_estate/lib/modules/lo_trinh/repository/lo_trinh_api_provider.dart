import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/lo_trinh/model/lo_trinh_model.dart';

class LoTrinhApiProvider extends ApiProvider{
  Future<bool> themVaoLoTrinh ({@required int id}) async {
    Response _resp = await httpClient.post('info/lo-trinh?id=$id');

    if(_resp.statusCode == 200){
      return true;
    } else{
      throw _resp.data['message'];
    }
  }

  Future<LoTrinhListModel> getDsLoTrinhHomNay () async {
    Response _resp = await httpClient.get('info/lo-trinh-index');

    if(_resp.statusCode == 200){
      return LoTrinhListModel.fromJson(_resp.data['data']);
    } else{
      throw _resp.data['message'];
    }
  }

  Future<bool> xoaLoTrinh ({@required String id}) async {
    Response _resp = await httpClient.get('info/delete-lo-trinh?id=$id');

    if(_resp.statusCode == 200){
      return true;
    } else{
      throw _resp.data['message'];
    }
  }

  Future<LoTrinhListModel> getDsLichSuLoTrinh ({@required DateTime date}) async {
    final timestamp = date.millisecondsSinceEpoch~/1000;

    Response _resp = await httpClient.get('info/lich-su-lo-trinh?date=$timestamp');

    if(_resp.statusCode == 200){
      return LoTrinhListModel.fromJson(_resp.data['data']);
    } else{
      throw _resp.data['message'];
    }
  }

  Future<bool> checkInLoTrinh ({@required String id, @required String type}) async {
    FormData _formData = new FormData.fromMap(
      {
        'type': type,
        'id': id,
      },
    );

    Response _resp = await httpClient.post('info/check-in', data: _formData);

    if(_resp.statusCode == 200){
      return true;
    } else{
      throw _resp.data['message'];
    }
  }
}