import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TinhThanhPhoModel extends Equatable {
  final String id;
  final String name;

  TinhThanhPhoModel({this.id, this.name});

  factory TinhThanhPhoModel.fromJson(Map<String, dynamic> json) {
    return TinhThanhPhoModel(
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


class TinhThanhPhoListModel extends ListMixin<TinhThanhPhoModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  TinhThanhPhoModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, TinhThanhPhoModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  TinhThanhPhoListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(TinhThanhPhoModel.fromJson(element));
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
