import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

class TimNhaChoThueApiProvider extends ApiProvider {
  Future<NhaChoThueListModel> timNhaChoThue({
    String quan,
    String phuong,
    String duong,
    double dienTich,
    int min,
    int max,
    String thanhPho,
    String soLau,
    String lung,
    String ham,
    String sanThuong,
    String soPhong,
    String soWCR,
    String soWCC,
    String thangMay,
    String thoatHiem,
    String huongNha,
  }) async {

    FormData _formData = FormData.fromMap({
      'type': 'NHA_CHO_THUE',
      'quan_huyen': quan,
      'xa_phuong': phuong,
      'ten_duong': duong,
      'dien_tich': dienTich,
      'gia_min': min,
      'gia_max': max,
      'so_lau': soLau,
      'lung': lung,
      'ham': ham,
      'san_thuong': sanThuong,
      'so_phong': soPhong,
      'wcr': soWCR,
      'wcc': soWCC,
      'thang_may': thangMay,
      'thoat_hiem': thoatHiem,
      'huong_nha': huongNha,
    });

    Response _resp = await httpClient.post('info/search', data: _formData);

    if (_resp.statusCode == 200) {
      return NhaChoThueListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }
}
