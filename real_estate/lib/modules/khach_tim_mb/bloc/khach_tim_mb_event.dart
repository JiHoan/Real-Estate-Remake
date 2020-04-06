import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';

class KhachTimMbEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class ThemKhachTimMb extends KhachTimMbEvent {
  final KhachTimMbModel model;

  ThemKhachTimMb({@required this.model});

  @override
  List<Object> get props => [model];
}

class FetchDsKhachTimMb extends KhachTimMbEvent {
  final String type;

  FetchDsKhachTimMb({@required this.type});

  @override
  List<Object> get props => [type];
}

class LoadMoreDsKhachTimMb extends KhachTimMbEvent {
  final String type;
  final int page;

  LoadMoreDsKhachTimMb({this.type, this.page});

  @override
  List<Object> get props => [type, page];
}

class FetchDetail extends KhachTimMbEvent {
  final int id;

  FetchDetail({@required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateTinhTrang extends KhachTimMbEvent {
  final int id;
  final String tinhTrang;

  UpdateTinhTrang({@required this.id, @required this.tinhTrang});

  @override
  List<Object> get props => [id, tinhTrang];
}

class UpdateThongTinLienHe extends KhachTimMbEvent {
  final int id;
  final String sdt;
  final String ten;

  UpdateThongTinLienHe({@required this.id, @required this.sdt, @required this.ten});

  @override
  List<Object> get props => [id, sdt, ten];
}

class UpdateMucDichThue extends KhachTimMbEvent {
  final int id;
  final String mucDich;

  UpdateMucDichThue({@required this.id, @required this.mucDich});

  @override
  List<Object> get props => [id, mucDich];
}

class UpdateKetCauNhaCanThue extends KhachTimMbEvent {
  final int id;
  final KhachTimMbModel model;

  UpdateKetCauNhaCanThue({@required this.id, @required this.model});

  @override
  List<Object> get props => [id, model];
}

class UpdateGiaCanThue extends KhachTimMbEvent {
  final int id;
  final int giaMin;
  final int giaMax;

  UpdateGiaCanThue({@required this.id, @required this.giaMin, @required this.giaMax});

  @override
  List<Object> get props => [id, giaMin, giaMax];
}
