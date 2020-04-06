import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/thong_tin_co_ban/model/thong_tin_co_ban_model.dart';

class ThongTinCoBanApiProvider extends ApiProvider {
  Future<bool> saveAdd({@required ThongTinCoBanModel model}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    print(model.roomNumber);

    Map<String, dynamic> _requestBody = {
      'chu_nha_sdt': model.sdtNguoiNhan,
      'chu_nha_ten': model.tenNguoiNhan,
      'tinh_thanh_pho': model.tinhTpId,
      'quan_huyen': model.quanHuyenId,
      'xa_phuong_thi_tran': model.phuongXaId,
      'so_nha': model.soNha,
      'ten_duong': model.tenDuong,
      'chieu_ngang_bao_nhieu': model.ngang,
      'chieu_dai_bao_nhieu': model.dai,
      'co_ham_khong': model.basement,
      'co_san_thuong_khong': model.terrace,
      'san_thuong_cai_tao_duoc_khong': model.terraceUpgrated,
      'co_bao_nhieu_lung': model.mezzanine,
      'co_bao_nhieu_phong': model.roomNumber,
      'bao_nhieu_wc_rieng': model.wcrNumber,
      'bao_nhieu_wc_chung': model.wccNumber,
      'phong_co_ban_cong_khong': model.balcony,
      'phong_co_cua_so_khong': model.window,
      'gia': model.gia,
      'co_bao_nhieu_lau': model.floorNumber,
      'hoa_hong': model.hoaHong,
      'vat': model.vat,
    };

    Response _resp = await httpClient.post('info/create', data: _requestBody);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }
}
