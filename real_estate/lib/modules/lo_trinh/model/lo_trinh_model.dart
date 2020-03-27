import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

class LoTrinhModel extends Equatable{
  final int id;
  final NhaChoThueModel info;

  LoTrinhModel({this.id, this.info});

  factory LoTrinhModel.fromJson(Map<dynamic, dynamic> json) {
    return LoTrinhModel(
      id: json['id'],
      info: NhaChoThueModel.fromJson(json['info']),
    );
  }

  @override
  List<Object> get props => [id, info];
}

class LoTrinhListModel extends ListMixin<LoTrinhModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  LoTrinhModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, LoTrinhModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  LoTrinhListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(LoTrinhModel.fromJson(element));
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