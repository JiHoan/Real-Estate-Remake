import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PhuongXaModel extends Equatable {
  final String id;
  final String name;

  PhuongXaModel({this.id, this.name});

  factory PhuongXaModel.fromJson(Map<String, dynamic> json) {
    return PhuongXaModel(
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


class PhuongXaListModel extends ListMixin<PhuongXaModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  PhuongXaModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, PhuongXaModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  PhuongXaListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(PhuongXaModel.fromJson(element));
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
