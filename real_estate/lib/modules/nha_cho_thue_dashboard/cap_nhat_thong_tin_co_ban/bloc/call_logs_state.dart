import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/call_model.dart';

class CallLogsState extends Equatable {
  @override
  List<Object> get props => null;
}

class CallLogsInitial extends CallLogsState {}

class CallLogsLoading extends CallLogsState {}

class CallLogsLoaded extends CallLogsState {
  final CallLogsListModel callLogsListModel;

  CallLogsLoaded({@required this.callLogsListModel});

  @override
  List<Object> get props => [callLogsListModel];
}

class CallLogsEmpty extends CallLogsState {}

class CallLogsFailure extends CallLogsState {
  final String error;

  CallLogsFailure({this.error});

  @override
  List<Object> get props => [error];
}