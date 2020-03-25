import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ThongTinLienHeModel extends Equatable {
  final String name;
  final String phone;

  ThongTinLienHeModel({@required this.name, @required this.phone});

  factory ThongTinLienHeModel.fromJson(Map<String, dynamic> json) {
    return ThongTinLienHeModel(
      name: json['ten'] == null ? '' : json['ten'],
      phone: json['sdt'] == null ? '' : json['sdt'],
    );
  }

  @override
  List<Object> get props => [name, phone];
}
