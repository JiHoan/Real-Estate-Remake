import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue/model/hien_trang_model.dart';

class KhachTimMbModel extends Equatable {
  final int id;
  final HienTrangModel tinhTrang;
  final String moTa;
  final String sdt;
  final String nguoiNhan;
  final String mucDich;
  final String thanhPho;
  final String quan;
  final String phuong;
  final String tenDuong;
  final String dienTich;
  final int soLau;
  final String lung;
  final String ham;
  final String sanThuong;
  final String sanThuongCaiTao;
  final int soPhong;
  final int soWCR;
  final int soWCC;
  final String banCong;
  final String cuaSo;
  final String thangBo;
  final int soThangThoatHiem;
  final int soThangMay;
  final String huongNha;
  final int giaMin;
  final int giaMax;
  final int thoiGianThue;
  final String khachLauNam;
  final String loaiHinh;
  final String loaiKhach;
  final String tenThuongHieu;
  final String moTaKhac;
  final DateTime createdAt;
  final String diaChi;

  KhachTimMbModel({
    this.diaChi,
    this.id,
    this.tinhTrang,
    this.moTa,
    this.sdt,
    this.nguoiNhan,
    this.mucDich,
    this.thanhPho,
    this.quan,
    this.phuong,
    this.tenDuong,
    this.dienTich,
    this.soLau,
    this.lung,
    this.ham,
    this.sanThuong,
    this.sanThuongCaiTao,
    this.soPhong,
    this.soWCR,
    this.soWCC,
    this.banCong,
    this.cuaSo,
    this.thangBo,
    this.soThangThoatHiem,
    this.soThangMay,
    this.huongNha,
    this.giaMin,
    this.giaMax,
    this.thoiGianThue,
    this.khachLauNam,
    this.loaiHinh,
    this.loaiKhach,
    this.tenThuongHieu,
    this.moTaKhac,
    this.createdAt,
  });

  factory KhachTimMbModel.fromJson(Map<dynamic, dynamic> json) {
    return KhachTimMbModel(
      id: json['id'],
      nguoiNhan: json['ten_khach_hang'],
      tinhTrang: HienTrangModel.fromJson(json['tinh_trang']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
      giaMin: json['gia_can_thue_min'],
      giaMax: json['gia_can_thue_max'],
      diaChi: json['dia_chi'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, Object>{
      'id': id,
      'ten_khach_hang': nguoiNhan,
      'tinh_trang': tinhTrang.toJson(),
      'created_at': createdAt != null ? createdAt.millisecondsSinceEpoch ~/ 1000 : null,
    };
  }

  @override
  List<Object> get props => [
        diaChi,
        id,
        tinhTrang,
        moTa,
        sdt,
        nguoiNhan,
        mucDich,
        thanhPho,
        quan,
        phuong,
        tenDuong,
        dienTich,
        soLau,
        lung,
        ham,
        sanThuong,
        sanThuongCaiTao,
        soPhong,
        soWCR,
        soWCC,
        banCong,
        cuaSo,
        thangBo,
        soThangThoatHiem,
        soThangMay,
        huongNha,
        giaMin,
        thoiGianThue,
        khachLauNam,
        loaiHinh,
        loaiKhach,
        tenThuongHieu,
        moTaKhac,
        giaMax,
      ];
}

class KhachTimMbListModel extends ListMixin<KhachTimMbModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  KhachTimMbModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, KhachTimMbModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  KhachTimMbListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(KhachTimMbModel.fromJson(element));
    });
  }

  List<dynamic> toJson() {
    return _list.map((element) => element.toJson()).toList();
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

class KhachCommenModel extends Equatable{
  final KhachTimMbListModel khachTimMbListModel;
  final int count;

  KhachCommenModel({@required this.khachTimMbListModel,@required this.count});

  @override
  List<Object> get props => null;
}