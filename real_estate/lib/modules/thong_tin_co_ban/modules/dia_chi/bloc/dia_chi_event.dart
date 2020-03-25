import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';

class TinhThanhPhoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TinhThanhPhoFetch extends TinhThanhPhoEvent {}

class TinhThanhPhoSearch extends TinhThanhPhoEvent {
  final TinhThanhPhoListModel tinhThanhPhoListModel;
  final String value;

  TinhThanhPhoSearch({@required this.tinhThanhPhoListModel, this.value});

  @override
  List<Object> get props => [tinhThanhPhoListModel, value];
}

// ----------------------------------------
class QuanHuyenFetch extends TinhThanhPhoEvent {
  final String id;

  QuanHuyenFetch({@required this.id});

  @override
  List<Object> get props => [id];
}
