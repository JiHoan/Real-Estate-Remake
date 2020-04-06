import 'package:equatable/equatable.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';

class DetailKtmbModel extends Equatable{
  final int id;
  final CommonModel tinhTrang;
  final ThongTinLienHeModel khachHang;
  final String mucDich;
  final String dienTich;
  final int soLau;
  final CommonModel lung;
  final CommonModel ham;
  final CommonModel sanThuong;
  final CommonModel sanThuongCaiTao;
  final int soPhong;
  final int soWCR;
  final int soWCC;
  final CommonModel banCong;
  final CommonModel cuaSo;
  final CommonModel viTriThangBo;
  final int soThangThoatHiem;
  final int soThangMay;
  final CommonModel huongNha;
  final int giaMin;
  final int giaMax;

  factory DetailKtmbModel.fromJson(Map<String, dynamic> json){
    return DetailKtmbModel(
      id: json['id'],
      tinhTrang: CommonModel.fromJson(json['tinh_trang']),
      khachHang: ThongTinLienHeModel.fromJson(json['khach_hang']),
      mucDich: json['muc_dich_thue'],
      dienTich: json['dien_tich'],
      soLau: json['co_bao_nhieu_lau'],
      lung: CommonModel.fromJson(json['co_bao_nhieu_lung']),
      ham: CommonModel.fromJson(json['co_ham_khong']),
      sanThuong: CommonModel.fromJson(json['co_san_thuong_khong']),
      sanThuongCaiTao: CommonModel.fromJson(json['san_thuong_cai_tao_duoc_khong']),
      soPhong: json['bao_nhieu_phong'],
      soWCR: json['bao_nhieu_wc_rieng'],
      soWCC: json['bao_nhieu_wc_chung'],
      banCong: CommonModel.fromJson(json['phong_co_ban_cong_khong']),
      cuaSo: CommonModel.fromJson(json['phong_co_cua_so_khong']),
      viTriThangBo: CommonModel.fromJson(json['vi_tri_thang_bo']),
      soThangThoatHiem: json['bao_nhieu_thang_thoat_hiem'],
      soThangMay: json['bao_nhieu_thang_may'],
      huongNha: CommonModel.fromJson(json['nha_huong_gi']),
      giaMin: json['gia_can_thue_min'],
      giaMax: json['gia_can_thue_max'],
    );
  }

  DetailKtmbModel({this.giaMax, this.giaMin, this.id, this.tinhTrang, this.khachHang, this.mucDich, this.dienTich, this.soLau, this.lung, this.ham, this.sanThuong, this.sanThuongCaiTao, this.soPhong, this.soWCR, this.soWCC, this.banCong, this.cuaSo, this.viTriThangBo, this.soThangThoatHiem, this.soThangMay, this.huongNha,});

  @override
  List<Object> get props => [giaMax, giaMin, id, tinhTrang, khachHang, mucDich, dienTich, soLau, lung, ham,sanThuong, sanThuongCaiTao, soPhong, soWCR, soWCC, banCong, cuaSo, viTriThangBo, soThangThoatHiem, soThangMay, huongNha,];
}