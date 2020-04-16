import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CapNhatTtncEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class UpdatePhapLy extends CapNhatTtncEvent {
  final int id;
  final String phapLy;

  UpdatePhapLy({@required this.id, @required this.phapLy});

  @override
  List<Object> get props => [id, phapLy];
}

class UpdateMatTien extends CapNhatTtncEvent {
  final int id;
  final double leDuong;
  final String duongMotChieu;

  UpdateMatTien({@required this.id, @required this.leDuong, @required this.duongMotChieu});

  @override
  List<Object> get props => [id, leDuong, duongMotChieu];
}

class UpdateHem extends CapNhatTtncEvent {
  final int id;
  final String kichThuocHem;
  final String loaiHem;
  final int soXet;
  final double baoNhieuMet;

  UpdateHem({@required this.id, @required this.kichThuocHem, @required this.loaiHem, @required this.soXet, @required this.baoNhieuMet});

  @override
  List<Object> get props => [id, kichThuocHem, loaiHem, soXet, baoNhieuMet];
}

class UpdateThoiGianChoThueToiDa extends CapNhatTtncEvent {
  final int id;
  final String soNamThueToiDa;

  UpdateThoiGianChoThueToiDa({@required this.id, @required this.soNamThueToiDa});

  @override
  List<Object> get props => [id, soNamThueToiDa];
}

class UpdateCocBaoNhieuThang extends CapNhatTtncEvent {
  final int id;
  final String soThangCoc;

  UpdateCocBaoNhieuThang({@required this.id, @required this.soThangCoc});

  @override
  List<Object> get props => [id, soThangCoc];
}

class UpdateGiaChaoGiaChot extends CapNhatTtncEvent {
  final int id;
  final int giaChao;
  final int giaChot;
  final int nam;
  final double phanTram;

  UpdateGiaChaoGiaChot({@required this.id, @required this.giaChao, @required this.giaChot, @required this.nam, @required this.phanTram});

  @override
  List<Object> get props => [id, giaChao, giaChot, nam, phanTram];
}

class UpdateViTriThangBo extends CapNhatTtncEvent {
  final int id;
  final String viTriThangBo;
  final int bnThangThoatHiem;
  final int bnThangMay;
  final String nhaHuongGi;

  UpdateViTriThangBo({@required this.id, @required this.viTriThangBo, @required this.bnThangThoatHiem, @required this.bnThangMay, @required this.nhaHuongGi});

  @override
  List<Object> get props => [id, viTriThangBo, bnThangThoatHiem, bnThangMay, nhaHuongGi];
}

class UpdateThongTinNguoiChoThue extends CapNhatTtncEvent {
  final int id;
  final String nguoiChoThue;
  final int phiMoiGioi;
  final String nhaTheChap;

  UpdateThongTinNguoiChoThue({@required this.id, @required this.nguoiChoThue, @required this.phiMoiGioi, @required this.nhaTheChap});

  @override
  List<Object> get props => [id, nguoiChoThue, phiMoiGioi, nhaTheChap];
}

class UpdateChuongNgaiVat extends CapNhatTtncEvent {
  final int id;
  final List<String> chuongNgaiVat;
  final String chuongNgaiVatKhac;

  UpdateChuongNgaiVat({@required this.id, @required this.chuongNgaiVat, @required this.chuongNgaiVatKhac});

  @override
  List<Object> get props => [id, chuongNgaiVat, chuongNgaiVatKhac];
}

class UploadHinhAnhNha extends CapNhatTtncEvent {
  final int id;
  final List<File> hinhAnh;

  UploadHinhAnhNha({@required this.id, @required this.hinhAnh});

  @override
  List<Object> get props => [id, hinhAnh];
}

class RemoveHinhAnhNha extends CapNhatTtncEvent {
  final int id;
  final List<int> hinhAnhId;

  RemoveHinhAnhNha({@required this.id, @required this.hinhAnhId});

  @override
  List<Object> get props => [id, hinhAnhId];
}

class ExportExcel extends CapNhatTtncEvent {
  final int id;

  ExportExcel({@required this.id});

  @override
  List<Object> get props => [id];
}