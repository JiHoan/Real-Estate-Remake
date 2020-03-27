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


class FetchDsLichSuLoTrinh extends LoTrinhEvent {
  final DateTime date;

  FetchDsLichSuLoTrinh({@required this.date});

  @override
  List<Object> get props => [date];
}

class CheckInLoTrinh extends LoTrinhEvent {
  final String id;
  final String type;

  CheckInLoTrinh({@required this.id, @required this.type});

  @override
  List<Object> get props => [id, type];
}