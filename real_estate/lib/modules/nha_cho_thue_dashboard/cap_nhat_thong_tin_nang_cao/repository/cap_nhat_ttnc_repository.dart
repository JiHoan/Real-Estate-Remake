import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/repository/cap_nhat_ttnc_api_provider.dart';

class CapNhatTtncRepository {
  CapNhatTtncApiProvider _capNhatTtncApiProvider = CapNhatTtncApiProvider();

  Future<bool> updatePhapLyChuNha({@required int id, @required String phapLy}) async {
    return await _capNhatTtncApiProvider.updatePhapLyChuNha(id: id, phapLy: phapLy);
  }

  Future<bool> updateMatTien({@required int id,@required String duongMotChieu,@required double leDuong }) async {
    return await _capNhatTtncApiProvider.updateMatTien(id: id, leDuong: leDuong, duongMotChieu: duongMotChieu);
  }

  Future<bool> updateHem({@required int id,@required int soXet ,@required String kichThuocHem, @required String loaiHem, @required double baoNhieuMet}) async {
    return await _capNhatTtncApiProvider.updateHem(id: id, soXet: soXet, kichThuocHem: kichThuocHem, loaiHem: loaiHem, baoNhieuMet: baoNhieuMet);
  }

  Future<bool> updateThoiGianThueToiDa({@required int id, @required String soNamChoThueToiDa}) async {
    return await _capNhatTtncApiProvider.updateThoiGianThueToiDa(id: id, soNamChoThueToiDa: soNamChoThueToiDa);
  }

  Future<bool> updateCocBaoNhieuThang({@required int id, @required String soThangCoc}) async {
    return await _capNhatTtncApiProvider.updateCocBaoNhieuThang(id: id, soThangCoc: soThangCoc);
  }

  Future<bool> updateGiaChaoGiaChot({@required int id, @required int giaChao, @required int giaChot, @required int bnndktg, @required double bnnctbnpt}) async {
    return await _capNhatTtncApiProvider.updateGiaChaoGiaChot(id: id, giaChao: giaChao, giaChot: giaChot, bnndktg: bnndktg, bnnctbnpt: bnnctbnpt);
  }

  Future<bool> updateViTriThangBo({@required int id, @required String viTriThangBo, @required int bnThangThoatHiem, @required int bnThangMay, @required String nhaHuongGi}) async {
    return await _capNhatTtncApiProvider.updateViTriThangBo(id: id, viTriThangBo: viTriThangBo, bnThangThoatHiem: bnThangThoatHiem, bnThangMay: bnThangMay, nhaHuongGi: nhaHuongGi);
  }

  Future<bool> updateThongTinNguoiChoThue({@required int id, @required String nguoiChoThue, @required int phiMoiGioi, @required String nhaTheChap}) async {
    return await _capNhatTtncApiProvider.updateThongTinNguoiChoThue(id: id, nguoiChoThue: nguoiChoThue, phiMoiGioi: phiMoiGioi, nhaTheChap: nhaTheChap);
  }

  Future<bool> uploadHinhAnhNha({@required int id, @required List<File> hinhAnh}) async {
    return await _capNhatTtncApiProvider.uploadHinhAnhNha(id: id, hinhAnh: hinhAnh);
  }

  Future<bool> updateChuongNgaiVat({@required int id, @required List<String> chuongNgaiVat, @required String chuongNgaiVatKhac}) async {
    return await _capNhatTtncApiProvider.updateChuongNgaiVat(id: id, chuongNgaiVat: chuongNgaiVat, chuongNgaiVatKhac: chuongNgaiVatKhac);
  }

  Future<bool> removeHinhAnh({@required int id, @required List<int> idHinhAnh}) async {
    return await _capNhatTtncApiProvider.removeHinhAnh(id: id, idHinhAnh: idHinhAnh);
  }

  Future<String> exportExcel({@required int id}) async {
    return await _capNhatTtncApiProvider.exportExcel(id: id);
  }
}