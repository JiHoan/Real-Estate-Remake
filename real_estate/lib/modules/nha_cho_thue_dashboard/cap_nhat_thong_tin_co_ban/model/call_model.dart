import 'dart:collection';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CallModel extends Equatable {
  final int id;
  final String status;
  final String note;
  final DateTime createdAt;

  CallModel({@required this.id, @required this.status, @required this.note, @required this.createdAt});

  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
      id: json['user_id'],
      status: json['status'] == 'KHONG_LIEN_LAC_DUOC' ? 'Không liên lạc được' : 'Liên hệ thành công',
      note: json['note'] == '' ? 'Chưa có ghi chú' : json['note'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
    );
  }

  @override
  List<Object> get props => [id, status, note, createdAt];
}


class CallLogsListModel extends ListMixin<CallModel> {
  final List _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int size) => _list.length = size;

  @override
  CallModel operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, CallModel value) {
    if (index == length) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }

  CallLogsListModel.fromJson(List<Object> json) : assert(json != null) {
    List.from(json).forEach((element) {
      _list.add(CallModel.fromJson(element));
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