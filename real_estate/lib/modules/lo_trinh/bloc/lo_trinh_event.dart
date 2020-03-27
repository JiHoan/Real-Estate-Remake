import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoTrinhEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class ThemLoTrinh extends LoTrinhEvent {
  final int id;

  ThemLoTrinh({@required this.id});

  @override
  List<Object> get props => [id];
}

class FetchDsLoTrinhHomNay extends LoTrinhEvent {}

class XoaLoTrinh extends LoTrinhEvent {
  final String id;

  XoaLoTrinh({@required this.id});

  @override
  List<Object> get props => [id];
}