import 'package:equatable/equatable.dart';

class HienTrangModel extends Equatable {
  final int index;
  final String value;

  HienTrangModel({this.index, this.value});

  factory HienTrangModel.fromJson(Map<String, dynamic> json) {
    return HienTrangModel(
      index: json['index'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, Object>{
      'index': index,
      'value': value != null ? value : null,
    };
  }

  @override
  List<Object> get props => [index, value];
}
