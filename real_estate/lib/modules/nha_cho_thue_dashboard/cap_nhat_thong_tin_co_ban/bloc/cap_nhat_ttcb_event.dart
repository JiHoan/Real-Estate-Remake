import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';

class CapNhatTtcbEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class FetchDetail extends CapNhatTtcbEvent {
  final int id;

  FetchDetail({@required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateRow extends CapNhatTtcbEvent {
  final String type;
  final String obType;
  final int id;
  final String text;

  UpdateRow({@required this.type, @required this.obType, @required this.id, @required this.text});

  @override
  List<Object> get props => [type, obType, id, text];
}

class UpdateThongTinLienHe extends CapNhatTtcbEvent {
  final ThongTinLienHeModel model;
  final int id;

  UpdateThongTinLienHe({@required this.model, @required this.id});

  @override
  List<Object> get props => [model, id];
}

class UpdateDienTichKetCauNoiThat extends CapNhatTtcbEvent {
  final NhaChoThueDetailModel model;
  final int id;

  UpdateDienTichKetCauNoiThat({@required this.model, @required this.id});

  @override
  List<Object> get props => [model, id];
}

class UpdateVAT extends CapNhatTtcbEvent {
  final NhaChoThueDetailModel model;
  final int id;

  UpdateVAT({@required this.model, @required this.id});

  @override
  List<Object> get props => [model, id];
}

class RemoveHinhAnh extends CapNhatTtcbEvent {
  final List<int> banVeId;
  final int id;

  RemoveHinhAnh({@required this.banVeId, @required this.id});

  @override
  List<Object> get props => [banVeId, id];
}

class UpdateHienTrang extends CapNhatTtcbEvent {
  final int id;
  final String hienTrang;
  final String sdt;
  final String ten;

  UpdateHienTrang({@required this.id, @required this.hienTrang, @required this.sdt, @required this.ten});

  @override
  List<Object> get props => [id, hienTrang, sdt, ten];
}

class UpdateDiaChi extends CapNhatTtcbEvent {
  final int id;
  final String thanhPho;
  final String quanHuyen;
  final String phuongXa;
  final String soNha;
  final String tenDuong;

  UpdateDiaChi({
    @required this.id,
    @required this.thanhPho,
    @required this.quanHuyen,
    @required this.phuongXa,
    @required this.soNha,
    @required this.tenDuong
  });

  @override
  List<Object> get props => [id, thanhPho, quanHuyen, phuongXa, soNha, tenDuong];
}

class UpdateAndRemove extends CapNhatTtcbEvent{
  final NhaChoThueDetailModel model;
  final List<int> banVeId;
  final int id;

  UpdateAndRemove({@required this.model, @required this.banVeId, @required this.id});

  @override
  List<Object> get props => [model,banVeId, id];
}
