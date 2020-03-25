import 'package:equatable/equatable.dart';

class ThongTinCoBanModel extends Equatable {
  final String sdtNguoiNhan;
  final String tenNguoiNhan;
  final String tinhTpId;
  final String quanHuyenId;
  final String phuongXaId;
  final String soNha;
  final String tenDuong;
  final double ngang;
  final double dai;
  final int floorNumber;
  final String basement;
  final String terrace;
  final String terraceUpgrated;
  final int mezzanine;
  final String balcony;
  final String window;
  final int roomNumber;
  final int wcrNumber;
  final int wccNumber;
  final double gia;
  final double hoaHong;
  final int vat;

  ThongTinCoBanModel({
    this.sdtNguoiNhan,
    this.tenNguoiNhan,
    this.tinhTpId,
    this.quanHuyenId,
    this.phuongXaId,
    this.soNha,
    this.tenDuong,
    this.ngang,
    this.dai,
    this.floorNumber,
    this.basement,
    this.terrace,
    this.terraceUpgrated,
    this.mezzanine,
    this.balcony,
    this.window,
    this.roomNumber,
    this.wcrNumber,
    this.wccNumber,
    this.gia,
    this.hoaHong,
    this.vat,
  });

  factory ThongTinCoBanModel.fromJson(Map<String, dynamic> json) {
    return ThongTinCoBanModel(
      sdtNguoiNhan: json['chu_nha_sdt'],
      tenNguoiNhan: json['chu_nha_ten'],
      tinhTpId: json['tinh_thanh_pho'],
      quanHuyenId: json['quan_huyen'],
      phuongXaId: json['xa_phuong_thi_tran'],
      soNha: json['so_nha'],
      tenDuong: json['ten_duong'],
      ngang: double.tryParse(json['chieu_ngang_bao_nhieu']) ?? 0.0,
      dai: double.tryParse(json['chieu_dai_bao_nhieu']) ?? 0.0,
      basement: json['co_ham_khong'],
      terrace: json['co_san_thuong_khong'],
      terraceUpgrated: json['san_thuong_cai_tao_duoc_khong'],
      mezzanine: json['co_bao_nhieu_lung'],
      roomNumber: json['co_bao_nhieu_phong'],
      wcrNumber: json['bao_nhieu_wc_rieng'],
      wccNumber: json['bao_nhieu_wc_chung'],
      balcony: json['phong_co_ban_cong_khong'],
      window: json['phong_co_cua_so_khong'],
      gia: double.tryParse(json['gia']) ?? 0.0,
      floorNumber: json['co_bao_nhieu_lau'],
      hoaHong: double.tryParse(json['hoa_hong']) ?? 0.0,
      vat: int.tryParse(json['vat']) ?? 0,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        this.sdtNguoiNhan,
        this.tenNguoiNhan,
        this.tinhTpId,
        this.quanHuyenId,
        this.phuongXaId,
        this.soNha,
        this.tenDuong,
        this.ngang,
        this.dai,
        this.floorNumber,
        this.basement,
        this.terrace,
        this.terraceUpgrated,
        this.mezzanine,
        this.balcony,
        this.window,
        this.roomNumber,
        this.wcrNumber,
        this.wccNumber,
        this.gia,
        this.hoaHong,
        this.vat,
      ];
}

