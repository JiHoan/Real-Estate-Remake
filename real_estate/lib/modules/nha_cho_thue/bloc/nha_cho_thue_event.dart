import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NhaChoThueEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class FetchDanhSachNhaChoThue extends NhaChoThueEvent {
  final String type;
  final int page;

  FetchDanhSachNhaChoThue({this.type, this.page});

  @override
  List<Object> get props => [type, page];
}

class LoadMoreDanhSachNhaChoThue extends NhaChoThueEvent {
  final String type;
  final int page;

  LoadMoreDanhSachNhaChoThue({this.type, this.page});

  @override
  List<Object> get props => [type, page];
}

