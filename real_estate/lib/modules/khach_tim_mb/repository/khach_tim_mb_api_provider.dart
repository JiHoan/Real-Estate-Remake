import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/khach_tim_mb/model/detail_ktmb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';

class KhachTimMbApiProvider extends ApiProvider {
  Future<bool> themKhachTimMb({@required KhachTimMbModel khachTimMbModel}) async {
    FormData _formData = FormData.fromMap({
      'tinh_trang': khachTimMbModel.moTa,
      'khach_hang_sdt': khachTimMbModel.sdt,
      'khach_hang_ten': khachTimMbModel.nguoiNhan,
      'muc_dich_thue': khachTimMbModel.mucDich,
      'tinh_thanh_pho': khachTimMbModel.thanhPho,
      'quan_huyen': khachTimMbModel.quan,
      'xa_phuong_thi_tran': khachTimMbModel.phuong,
      'ten_duong': khachTimMbModel.tenDuong,
      'dien_tich': khachTimMbModel.dienTich,
      'co_ham_khong': khachTimMbModel.ham,
      'co_san_thuong_khong': khachTimMbModel.sanThuong,
      'san_thuong_cai_tao_duoc_khong': khachTimMbModel.sanThuongCaiTao,
      'co_bao_nhieu_lung': khachTimMbModel.lung,
      'bao_nhieu_phong': khachTimMbModel.soPhong,
      'bao_nhieu_wc_rieng': khachTimMbModel.soWCR,
      'bao_nhieu_wc_chung': khachTimMbModel.soWCC,
      'phong_co_ban_cong_khong': khachTimMbModel.banCong,
      'phong_co_cua_so_khong': khachTimMbModel.cuaSo,
      'gia': khachTimMbModel.giaCanThue,
      'co_bao_nhieu_lau': khachTimMbModel.soLau,
      'vi_tri_thang_bo': khachTimMbModel.thangBo,
      'bao_nhieu_thang_thoat_hiem': khachTimMbModel.soThangThoatHiem,
      'bao_nhieu_thang_may': khachTimMbModel.soThangMay,
      'nha_huong_gi': khachTimMbModel.huongNha,
      'thoi_gian_thue': khachTimMbModel.thoiGianThue,
      'khach_lau_nam': khachTimMbModel.khachLauNam,
      'loai_hinh': khachTimMbModel.loaiHinh,
      'loai_khach': khachTimMbModel.loaiKhach,
      'ten_thuong_hieu': khachTimMbModel.tenThuongHieu,
      'mo_ta_khac': khachTimMbModel.moTaKhac,
    });

    Response _resp = await httpClient.post('request/create', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<KhachTimMbListModel> getDsKhachTimMb({@required String tinhTrang, @required int page}) async {
    Response _resp = await httpClient.get('request/index?tinh_trang=$tinhTrang&page=$page');

    if (_resp.statusCode == 200) {
      return KhachTimMbListModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }

  Future<DetailKtmbModel> getDetailKhachTimMb({@required int id}) async {
    Response _resp = await httpClient.get('request/view?id=$id');

    if (_resp.statusCode == 200) {
      return DetailKtmbModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateTinhTrang({@required int id, @required String tinhTrang}) async {
    FormData _formData = FormData.fromMap({'request_id': id, 'tinh_trang': tinhTrang});

    Response _resp = await httpClient.post(
      'request/tinh-trang',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateThongTinLienHe({@required int id, @required String sdt, @required String ten}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'khach_hang_sdt': sdt,
      'khach_hang_ten': ten,
    });

    Response _resp = await httpClient.post(
      'request/thong-tin-lien-he',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateMucDichThue({@required int id, @required String mucDich}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'muc_dich_thue': mucDich,
    });

    Response _resp = await httpClient.post(
      'request/muc-dich-thue',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateKetCauNhaCanThue({@required int id, @required KhachTimMbModel model}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'dien_tich': model.dienTich,
      'co_ham_khong': model.ham,
      'co_san_thuong_khong': model.sanThuong,
      'san_thuong_cai_tao_duoc_khong': model.sanThuongCaiTao,
      'co_bao_nhieu_lung': model.lung,
      'bao_nhieu_phong': model.soPhong,
      'bao_nhieu_wc_rieng': model.soWCR,
      'bao_nhieu_wc_chung': model.soWCC,
      'phong_co_ban_cong_khong': model.banCong,
      'phong_co_cua_so_khong': model.cuaSo,
      'co_bao_nhieu_lau': model.soLau,
      'vi_tri_thang_bo': model.thangBo,
      'bao_nhieu_thang_thoat_hiem': model.soThangThoatHiem,
      'bao_nhieu_thang_may': model.soThangMay,
      'nha_huong_gi': model.huongNha,
    });

    Response _resp = await httpClient.post(
      'request/ket-cau-nha-can-thue',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateGiaCanThue({@required int id, @required int giaMin, @required int giaMax}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'gia_can_thue_min': giaMin,
      'gia_can_thue_max': giaMax,
    });

    Response _resp = await httpClient.post(
      'request/gia-can-thue',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }
}
