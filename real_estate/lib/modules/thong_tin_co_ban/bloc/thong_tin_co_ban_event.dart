import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/thong_tin_co_ban/model/thong_tin_co_ban_model.dart';

class ThongTinCoBanEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ThongTinCoBanSave extends ThongTinCoBanEvent{
  final ThongTinCoBanModel thongTinCoBanModel;

  ThongTinCoBanSave({@required this.thongTinCoBanModel});
}