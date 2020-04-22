import 'package:flutter/cupertino.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/call_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';
import 'package:path/path.dart';

class NhaChoThueDetailApiProvider extends ApiProvider {
  Future<NhaChoThueDetailModel> getNhaChoThueDetail({@required int id}) async {
    Response _resp = await httpClient.get('info/view?id=$id');

    if (_resp.statusCode == 200) {
      return NhaChoThueDetailModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateHienTrang({@required int id, @required String hienTrang, @required String sdt, @required String ten}) async {
    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'hien_trang': hienTrang,
        'nguoi_thue_sdt': sdt,
        'nguoi_thue_ten': ten,
      },
    );

    Response _resp = await httpClient.post('info/hien-trang', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateRow({@required String type, @required String obType, @required int id, @required String text}) async {
    Map<String, dynamic> _requestBody = {'info_id': id, '$obType': text};
    Response _resp = await httpClient.post('info/$type', data: _requestBody);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateThongTinLienHe({@required ThongTinLienHeModel model, @required int id}) async {
    Map<String, dynamic> _requestBody = {
      'info_id': id,
      'chu_nha_sdt': model.phone,
      'chu_nha_ten': model.name,
    };
    Response _resp = await httpClient.post('info/thong-tin-lien-he', data: _requestBody);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateDienTichKetCauNoiThat({@required NhaChoThueDetailModel model, @required int id}) async {
    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'chieu_ngang_bao_nhieu': model.ngang,
        'chieu_dai_bao_nhieu': model.dai,
        'co_ham_khong': model.ham.value,
        'co_san_thuong_khong': model.sanThuong.value,
        'san_thuong_cai_tao_duoc_khong': model.sanThuongCaiTao.value,
        'co_bao_nhieu_lung': model.lung.value,
        'bao_nhieu_phong': model.soPhong,
        'bao_nhieu_wc_rieng': model.soWcr,
        'bao_nhieu_wc_chung': model.soWcc,
        'phong_co_ban_cong_khong': model.banCong.value,
        'phong_co_cua_so_khong': model.cuaSo.value,
        'co_bao_nhieu_lau': model.soLau,
        'ban_ve': model.hinhAnhBanVeUpdate == null
            ? null
            : model.hinhAnhBanVeUpdate.map(
                (item) {
                  return MultipartFile.fromFileSync(
                    item?.path,
                    filename: basename(item?.path),
                  );
                },
              ).toList(),
      },
    );

    Response _resp = await httpClient.post('info/ket-cau-noi-that', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateVAT({@required NhaChoThueDetailModel model, @required int id}) async {
    print('a');
    print(model.gia);
    Map<String, dynamic> _requestBody = {
      'info_id': id,
      'gia': model.gia,
      'hoa_hong': model.hoaHong,
      'vat': model.vat,
    };
    Response _resp = await httpClient.post('info/hoa-hong', data: _requestBody);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> removeHinhAnh({@required int id, @required List<int> banVeId}) async {
    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'ban_ve_id': banVeId,
      },
    );

    Response _resp = await httpClient.post('info/delete-ban-ve', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateDiaChi({@required int id, @required String thanhPho, @required String quanHuyen, @required String phuongXa, @required String soNha, @required String tenDuong}) async {
    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'tinh_thanh_pho': thanhPho,
        'quan_huyen': quanHuyen,
        'xa_phuong_thi_tran': phuongXa,
        'so_nha': soNha,
        'ten_duong': tenDuong,
      },
    );

    Response _resp = await httpClient.post('info/dia-chi', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> capNhatCall({@required int id, @required String status, @required String note}) async {
    FormData _formData = FormData.fromMap(
        {
          'info_id' : id,
          'status' : status,
          'note' : note,
        }
    );

    Response _resp = await httpClient.post('info/call', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<CallLogsListModel> getCallLogs({@required int id}) async {
    Response _resp = await httpClient.get('info/call-logs?id=$id');

    if (_resp.statusCode == 200) {
      return CallLogsListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }
}
