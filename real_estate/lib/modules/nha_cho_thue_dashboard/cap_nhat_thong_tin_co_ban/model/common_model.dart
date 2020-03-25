import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CommonModel extends Equatable {
  final int index;
  final String value;

  /*static Map<String, String> type = {
    'CHUA_LIEN_HE' : 'Chưa liên hệ'
  };*/

  CommonModel({@required this.index, @required this.value});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      index: json['index'],
      value: json['value'].toString(),
//      value: json['value'] == null ? 'Không có dữ liệu' : type[json['value']],
    );
  }

  @override
  List<Object> get props => [index, value];
}
