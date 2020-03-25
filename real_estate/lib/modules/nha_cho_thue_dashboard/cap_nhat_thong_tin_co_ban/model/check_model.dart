import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CheckModel extends Equatable {
  final bool isChecked;
  final String value;
  final String title;

  CheckModel({@required this.isChecked, @required this.value, @required this.title});

  factory CheckModel.fromJson(Map<String, dynamic> json) {
    return CheckModel(
      isChecked: json['isChecked'],
      value: json['value'].toString(),
      title: json['title'].toString(),
    );
  }

  toJson() {
    return <String, dynamic>{
      'isChecked': isChecked,
      'value': value,
      'title': title,
    };
  }

  CheckModel copyWith({
     bool isChecked,
     String value,
     String title,
  }) {
    return CheckModel(
      isChecked: isChecked ?? this.isChecked,
      value: value ?? this.value,
      title: title ?? this.title,
    );
  }

  @override
  List<Object> get props => [isChecked, value, title];
}

class CheckListModel extends ListMixin<CheckModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  CheckModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, CheckModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  CheckListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(CheckModel.fromJson(element));
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
