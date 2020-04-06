import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

class TimNhaChoThueState extends Equatable {
  @override
  List<Object> get props => null;
}

class TimNhaChoThueInitial extends TimNhaChoThueState {}

class TimNhaChoThueLoading extends TimNhaChoThueState {}

class TimNhaChoThueLoaded extends TimNhaChoThueState {
  final NhaChoThueListModel list;

  TimNhaChoThueLoaded({@required this.list});

  @override
  List<Object> get props => [list];
}

class TimNhaChoThueEmpty extends TimNhaChoThueState {}

class TimNhaChoThueFailure extends TimNhaChoThueState {}
