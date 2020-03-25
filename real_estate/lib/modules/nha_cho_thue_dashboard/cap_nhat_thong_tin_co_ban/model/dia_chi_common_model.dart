import 'package:equatable/equatable.dart';

class DiaChiCommonModel extends Equatable {
  final String id;
  final String name;

  DiaChiCommonModel({this.id, this.name});

  factory DiaChiCommonModel.fromJson(Map<String, dynamic> json) {
    return DiaChiCommonModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object> get props => [id, name];
}
