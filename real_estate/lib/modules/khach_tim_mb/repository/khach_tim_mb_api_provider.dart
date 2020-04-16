import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
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
      'gia_can_thue_min': khachTimMbModel.giaMin,
      'gia_can_thue_max': khachTimMbModel.giaMax,
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

    print(_resp.statusCode);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<KhachCommenModel> getDsKhachTimMb({@required String tinhTrang, @required int page}) async {
    Response _resp = await httpClient.get('request/index?tinh_trang=$tinhTrang&page=$page');

    print('a');
    print(_resp.data['count']);

    if (_resp.statusCode == 200) {
      return KhachCommenModel(khachTimMbListModel: KhachTimMbListModel.fromJson(_resp.data['data']), count: _resp.data['count']);
//      return KhachTimMbListModel.fromJson(_resp.data['data']);
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

  Future<bool> updateThoiGianThue({@required int id, @required int thoiGianThue}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'thoi_gian_thue': thoiGianThue,
    });

    Response _resp = await httpClient.post(
      'request/thoi-gian-thue',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateKhachLauNam({@required int id, @required String khachLauNam, @required String loaiHinh}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'khach_lau_nam': khachLauNam,
      'loai_hinh': loaiHinh,
    });

    Response _resp = await httpClient.post(
      'request/khach-lau-khach-moi',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateLoaiKhachHang({@required int id, @required String loaiKhachHang, @required String tenThuongHieu}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'loai_khach': loaiKhachHang,
      'ten_thuong_hieu': tenThuongHieu,
    });

    Response _resp = await httpClient.post(
      'request/loai-khach',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateMoTaKhac({@required int id, @required String moTaKhac}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'mo_ta_khac': moTaKhac,
    });

    Response _resp = await httpClient.post(
      'request/mo-ta-khac',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateKhuVucCanThue({@required int id, @required String thanhPho, @required String quan, @required String phuong, @required String tenDuong}) async {
    FormData _formData = FormData.fromMap({
      'request_id': id,
      'tinh_thanh_pho': thanhPho,
      'quan_huyen': quan,
      'xa_phuong_thi_tran': phuong,
      'ten_duong': tenDuong,
    });

    Response _resp = await httpClient.post(
      'request/khu-vuc-can-thue',
      data: _formData,
    );

    if (_resp.statusCode == 200) {
      print(_resp.data['data']);
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> uploadHinhAnh({@required int id, @required List<File> hinhAnh}) async {
    print('run 1');
    FormData _formData = new FormData.fromMap(
      {
        'request_id': id,
        'hinh_anh': hinhAnh == null
            ? null
            : hinhAnh.map(
              (item) {
            return MultipartFile.fromFileSync(
              item?.path,
              filename: basename(item?.path),
            );
          },
        ).toList(),
      },
    );

    print('run 2');
    Response _resp = await httpClient.post('request/upload-hinh', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }


  Future<bool> removeHinhAnh({@required int id, @required List<int> idHinhAnh}) async {
    FormData _formData = new FormData.fromMap(
      {
        'request_id': id,
        'image_id': idHinhAnh,
      },
    );

    Response _resp = await httpClient.post('request/delete-hinh', data: _formData);

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }
}
