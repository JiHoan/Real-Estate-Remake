import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/call_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';

class CapNhatTtcbState extends Equatable {
  @override
  List<Object> get props => null;
}

class NhaChoThueDetailInitial extends CapNhatTtcbState {}

// FETCH
class FetchLoading extends CapNhatTtcbState {}

class FetchLoaded extends CapNhatTtcbState {
  final NhaChoThueDetailModel model;

  FetchLoaded({@required this.model});

  @override
  List<Object> get props => [model];
}

class FetchEmpty extends CapNhatTtcbState {}

class FetchFailure extends CapNhatTtcbState {
  final String error;

  FetchFailure({this.error});

  @override
  List<Object> get props => [error];
}

// UPDATE
class UpdateLoading extends CapNhatTtcbState {}

class UpdateSuccess extends CapNhatTtcbState {}

class UpdateFailure extends CapNhatTtcbState {
  final String error;

  UpdateFailure({this.error});

  @override
  List<Object> get props => [error];
}