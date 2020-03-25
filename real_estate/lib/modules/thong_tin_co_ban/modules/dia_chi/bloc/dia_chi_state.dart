import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/quan_huyen_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';

class TinhThanhPhoState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TinhThanhPhoInitial extends TinhThanhPhoState {}

class TinhThanhPhoLoading extends TinhThanhPhoState {}

class TinhThanhPhoSuccess extends TinhThanhPhoState {
  final TinhThanhPhoListModel tinhThanhPhoListModel;

  TinhThanhPhoSuccess({@required this.tinhThanhPhoListModel});
}

class TinhThanhPhoAutocomplete extends TinhThanhPhoState {
  final TinhThanhPhoListModel tinhThanhPhoListModel;

  TinhThanhPhoAutocomplete({@required this.tinhThanhPhoListModel});

  @override
  List<Object> get props => [tinhThanhPhoListModel];
}

// -------------------------------------------------
class QuanHuyenSuccess extends TinhThanhPhoState {
  final QuanHuyenListModel quanHuyenListModel;

  QuanHuyenSuccess({@required this.quanHuyenListModel});

  @override
  List<Object> get props => [quanHuyenListModel];
}

