import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/phuong_xa_model.dart';

class PhuongXaState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PhuongXaInitial extends PhuongXaState{}

class PhuongXaFailure extends PhuongXaState{}

class PhuongXaSuccess extends PhuongXaState {
  final PhuongXaListModel phuongXaListModel;

  PhuongXaSuccess({@required this.phuongXaListModel});

  @override
  List<Object> get props => [phuongXaListModel];
}