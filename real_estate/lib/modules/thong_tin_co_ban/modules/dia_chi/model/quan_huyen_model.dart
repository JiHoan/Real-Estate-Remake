import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuanHuyenModel extends Equatable {
  final String id;
  final String name;

  QuanHuyenModel({this.id, this.name});

  factory QuanHuyenModel.fromJson(Map<String, dynamic> json) {
    return QuanHuyenModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  @override
  // TODO: implement props
  List<Object> get props => [id, name];
}


class QuanHuyenListModel extends ListMixin<QuanHuyenModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  QuanHuyenModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, QuanHuyenModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  QuanHuyenListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(QuanHuyenModel.fromJson(element));
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
