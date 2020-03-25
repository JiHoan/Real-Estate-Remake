import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:path/path.dart';

class CapNhatTtncApiProvider extends ApiProvider {
  Future<bool> updatePhapLyChuNha({@required int id, @required String phapLy}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'phap_ly_chu_nha': phapLy,
      },
    );

    Response _resp = await httpClient.post('info/phap-ly-chu-nha', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateMatTien({@required int id, @required String duongMotChieu,@required double leDuong }) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'le_duong_bao_nhieu': leDuong,
        'duong_1_chieu': duongMotChieu,
        'nha_mat_tien': 'NHA_MAT_TIEN',
      },
    );

    Response _resp = await httpClient.post('info/nha-hem-mat-tien', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateHem({@required int id,@required int soXet ,@required String kichThuocHem, @required String loaiHem, @required double baoNhieuMet}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'nha_hem': kichThuocHem,
        'hem_thong': loaiHem,
        'so_xet_hem': soXet,
        'hem_dai_bao_nhieu': baoNhieuMet,
        'nha_mat_tien': 'NHA_HEM',
      },
    );

    Response _resp = await httpClient.post('info/nha-hem-mat-tien', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateThoiGianThueToiDa({@required int id, @required String soNamChoThueToiDa}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'thoi_gian_cho_thue_toi_da': soNamChoThueToiDa,
      },
    );

    Response _resp = await httpClient.post('info/thoi-gian-cho-thue', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateCocBaoNhieuThang({@required int id, @required String soThangCoc}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'coc_bao_nhieu_thang': soThangCoc,
      },
    );

    Response _resp = await httpClient.post('info/coc-bao-nhieu-thang', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateGiaChaoGiaChot({@required int id, @required int giaChao, @required int giaChot, @required int bnndktg, @required double bnnctbnpt}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'gia_chao_bao_nhieu': giaChao,
        'gia_chot_bao_nhieu': giaChot,
        'bao_nhieu_nam_dau_khong_tang_gia': bnndktg,
        'nam_cuoi_tang_bao_nhieu': bnnctbnpt,
      },
    );

    Response _resp = await httpClient.post('info/gia-chao-gia-chot', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateViTriThangBo({@required int id, @required String viTriThangBo, @required int bnThangThoatHiem, @required int bnThangMay, @required String nhaHuongGi}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'vi_tri_thang_bo': viTriThangBo,
        'bao_nhieu_thang_thoat_hiem': bnThangThoatHiem,
        'bao_nhieu_thang_may': bnThangMay,
        'nha_huong_gi': nhaHuongGi,
      },
    );

    Response _resp = await httpClient.post('info/vi-tri-cau-thang', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateThongTinNguoiChoThue({@required int id, @required String nguoiChoThue, @required int phiMoiGioi, @required String nhaTheChap}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'chu_nha_cho_thue': nguoiChoThue,
        'phi_muoi_gioi': phiMoiGioi,
        'nha_dang_the_chap': nhaTheChap,
      },
    );

    Response _resp = await httpClient.post('info/thong-tin-nguoi-cho-thue', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> updateChuongNgaiVat({@required int id, @required List<String> chuongNgaiVat, @required String chuongNgaiVatKhac}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'chuong_ngai_vat': chuongNgaiVat,
        'chuong_ngai_vat_khac': chuongNgaiVatKhac,
      },
    );

    Response _resp = await httpClient.post('info/chuong-ngai-vat-truoc-nha', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> uploadHinhAnhNha({@required int id, @required List<File> hinhAnh}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
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

    Response _resp = await httpClient.post('info/upload-hinh', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }

  Future<bool> removeHinhAnh({@required int id, @required List<int> idHinhAnh}) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    httpClient.options.headers.addAll({
      'accept': 'application/json',
      'authorization': 'Bearer ' + token,
    });

    FormData _formData = new FormData.fromMap(
      {
        'info_id': id,
        'image_id': idHinhAnh,
      },
    );

    Response _resp = await httpClient.post('info/delete-hinh', data: _formData);

    httpClient.options.headers.clear();

    if (_resp.statusCode == 200) {
      return true;
    } else {
      throw _resp.data['message'];
    }
  }
}