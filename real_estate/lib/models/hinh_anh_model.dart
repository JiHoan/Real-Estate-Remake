import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HinhAnhModel extends Equatable {
  final int id;
  final String url;
  final DateTime createdAt;

  HinhAnhModel({this.id, this.url, this.createdAt});

  factory HinhAnhModel.fromJson(Map<String, dynamic> json) {
    return HinhAnhModel(
      id: json['id'],
      url: json['image_url'].toString(),
    );
  }

  toJson() {
    return <String, dynamic>{
      'id': id,
      'url': url,
    };
  }

  @override
  List<Object> get props => [id, url, createdAt];
}

class HinhAnhListModel extends ListMixin<HinhAnhModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  HinhAnhModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, HinhAnhModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  HinhAnhListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(HinhAnhModel.fromJson(element));
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
