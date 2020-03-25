import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:real_estate/modules/nha_cho_thue/model/hien_trang_model.dart';

class NhaChoThueModel extends Equatable {
  final int id;
  final double gia;
  final String ghiChu;
  final HienTrangModel hienTrang;
  final String ketCau;
  final String diaChi;
  final DateTime createdAt;

  NhaChoThueModel({this.id, this.gia, this.ghiChu, this.hienTrang, this.ketCau, this.diaChi, this.createdAt});

  factory NhaChoThueModel.fromJson(Map<dynamic, dynamic> json) {
    return NhaChoThueModel(
      id: json['id'],
      gia: double.tryParse(json['gia'].toString()) ?? 0.0,
      ghiChu: json['ghi_chu'] != null ? json['ghi_chu'] : 'chưa có ghi chú',
      hienTrang: HienTrangModel.fromJson(json['hien_trang']),
      ketCau: json['ket_cau'],
      diaChi: json['dia_chi'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, Object>{
      'id': id,
      'gia': double.tryParse(gia.toString()) ?? 0.0,
      'ghi_chu': ghiChu != null ? ghiChu : null,
      'hien_trang': hienTrang.toJson(),
      'ket_cau': ketCau != null ? ketCau : null,
      'dia_chi': diaChi != null ? diaChi : null,
      'created_at': createdAt != null ? createdAt.millisecondsSinceEpoch ~/ 1000 : null,
    };
  }

  @override
  List<Object> get props => [id, gia, ghiChu, hienTrang, ketCau, diaChi, createdAt];
}

class NhaChoThueListModel extends ListMixin<NhaChoThueModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  NhaChoThueModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, NhaChoThueModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  NhaChoThueListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(NhaChoThueModel.fromJson(element));
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
