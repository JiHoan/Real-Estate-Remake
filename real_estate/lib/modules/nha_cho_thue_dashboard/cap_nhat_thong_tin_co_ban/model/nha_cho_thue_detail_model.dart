import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:real_estate/models/hinh_anh_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/check_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';

import 'common_model.dart';
import 'dia_chi_common_model.dart';

class NhaChoThueDetailModel extends Equatable {
  final int id;
  final CommonModel hienTrang;
  final String ghiChu;
  final ThongTinLienHeModel thongTinLienHe;
  final double ngang;
  final double dai;
  final int soLau;
  final CommonModel lung;
  final CommonModel ham;
  final CommonModel sanThuong;
  final CommonModel sanThuongCaiTao;
  final int soPhong;
  final int soWcr;
  final int soWcc;
  final CommonModel banCong;
  final CommonModel cuaSo;
  final HinhAnhListModel hinhAnhBanVe;
  final List<File> hinhAnhBanVeUpdate;
  final int gia;
  final int hoaHong;
  final int vat;
  final ThongTinLienHeModel nguoiThue;
  final DiaChiCommonModel thanhPho;
  final DiaChiCommonModel quanHuyen;
  final DiaChiCommonModel phuongXa;
  final String soNha;
  final String tenDuong;
  final CheckListModel chuongNgaiVat;
  final String chuongNgaiVatKhac;

  // thông tin nâng cao
  final CommonModel phapLy;
  final CommonModel matTien;
  final double leDuong;
  final CommonModel duongMotChieu;

  final int soXet;
  final CommonModel kichThuocHem;
  final CommonModel loaiHem;
  final double hemBaoNhieuMet;
  final int soNamThueToiDa;
  final int cocBaoNhieuThang;
  final int giaChao;
  final int giaChot;
  final int baoNhieuNamDauKhongTangGia;
  final double baoNhieuNamCuoiTangBaoNhieuPhanTram;
  final CommonModel viTriThangBo;
  final int soThangThoatHiem;
  final int soThangMay;
  final CommonModel nhaHuongGi;
  final CommonModel chuNhaChoThue;
  final int phiMoiGioi;
  final CommonModel nhaTheChap;
  final HinhAnhListModel hinhAnhNha;
  final List<File> hinhAnhNhaUpdate;

  NhaChoThueDetailModel({
    this.id,
    this.hienTrang,
    this.ghiChu,
    this.thongTinLienHe,
    this.ngang,
    this.dai,
    this.soLau,
    this.lung,
    this.ham,
    this.sanThuong,
    this.sanThuongCaiTao,
    this.soPhong,
    this.soWcr,
    this.soWcc,
    this.banCong,
    this.cuaSo,
    this.hinhAnhBanVe,
    this.hinhAnhBanVeUpdate,
    this.gia,
    this.hoaHong,
    this.vat,
    this.nguoiThue,
    this.thanhPho,
    this.quanHuyen,
    this.phuongXa,
    this.soNha,
    this.tenDuong, // thông tin nâng cao
    this.phapLy,
    this.matTien,
    this.leDuong,
    this.duongMotChieu,
    this.soXet,
    this.kichThuocHem,
    this.loaiHem,
    this.hemBaoNhieuMet,
    this.soNamThueToiDa,
    this.cocBaoNhieuThang,
    this.giaChao,
    this.giaChot,
    this.baoNhieuNamDauKhongTangGia,
    this.baoNhieuNamCuoiTangBaoNhieuPhanTram,
    this.viTriThangBo,
    this.soThangThoatHiem,
    this.soThangMay,
    this.nhaHuongGi,
    this.chuNhaChoThue,
    this.phiMoiGioi,
    this.nhaTheChap,
    this.hinhAnhNha,
    this.hinhAnhNhaUpdate,
    this.chuongNgaiVat,
    this.chuongNgaiVatKhac,
  });

  factory NhaChoThueDetailModel.fromJson(Map<String, dynamic> json) {
    return NhaChoThueDetailModel(
      id: json['id'],
      hienTrang: json['hien_trang'] == null ? null : CommonModel.fromJson(json['hien_trang']),
      ghiChu: json['ghi_chu'] != null ? json['ghi_chu'] : 'Chưa có ghi chú',
      thongTinLienHe: json['chu_nha'] == null ? null : ThongTinLienHeModel.fromJson(json['chu_nha']),
      ngang: double.tryParse(json['chieu_ngang_bao_nhieu'].toString()) ?? null,
      dai: double.tryParse(json['chieu_dai_bao_nhieu'].toString()) ?? null,
      soLau: int.tryParse(json['co_bao_nhieu_lau'].toString()) ?? 0,
      lung: json['co_bao_nhieu_lung'] == null ? null : CommonModel.fromJson(json['co_bao_nhieu_lung']),
      ham: json['co_ham_khong'] == null ? null : CommonModel.fromJson(json['co_ham_khong']),
      sanThuong: json['co_san_thuong_khong'] == null ? null : CommonModel.fromJson(json['co_san_thuong_khong']),
      sanThuongCaiTao:
          json['san_thuong_cai_tao_duoc_khong'] == null ? null : CommonModel.fromJson(json['san_thuong_cai_tao_duoc_khong']),
      soPhong: int.tryParse(json['bao_nhieu_phong'].toString()) ?? 0,
      soWcr: int.tryParse(json['bao_nhieu_wc_rieng'].toString()) ?? 0,
      soWcc: int.tryParse(json['bao_nhieu_wc_chung'].toString()) ?? 0,
      banCong: json['phong_co_ban_cong_khong'] == null ? null : CommonModel.fromJson(json['phong_co_ban_cong_khong']),
      cuaSo: json['phong_co_cua_so_khong'] == null ? null : CommonModel.fromJson(json['phong_co_cua_so_khong']),
      hinhAnhBanVe: json['ban_ve'] == null ? null : HinhAnhListModel.fromJson(json['ban_ve']),
      gia: int.tryParse(json['gia'].toString()) ?? 0,
      hoaHong: int.tryParse(json['hoa_hong'].toString()) ?? 0,
      vat: int.tryParse(json['vat'].toString()) ?? 0,
      nguoiThue: json['nguoi_thue'] == null ? null : ThongTinLienHeModel.fromJson(json['nguoi_thue']),
      thanhPho: json['tinh_thanh_pho'] == null ? null : DiaChiCommonModel.fromJson(json['tinh_thanh_pho']),
      quanHuyen: json['quan_huyen'] == null ? null : DiaChiCommonModel.fromJson(json['quan_huyen']),
      phuongXa: json['xa_phuong_thi_tran'] == null ? null : DiaChiCommonModel.fromJson(json['xa_phuong_thi_tran']),
      soNha: json['so_nha'] == null ? '' : json['so_nha'],
      tenDuong: json['ten_duong'] == null ? '' : json['ten_duong'],
      // thông tin nâng cao
      phapLy: json['phap_ly_chu_nha'] == null ? null : CommonModel.fromJson(json['phap_ly_chu_nha']),
      matTien: json['nha_mat_tien'] == null ? null : CommonModel.fromJson(json['nha_mat_tien']),
      leDuong: double.tryParse(json['le_duong_bao_nhieu'].toString()) ?? 0.0,
      duongMotChieu: json['duong_1_chieu'] == null ? null : CommonModel.fromJson(json['duong_1_chieu']),

      soXet: json['so_xet_hem'] == null ? null : json['so_xet_hem'],
      kichThuocHem: json['nha_hem'] == null ? null : CommonModel.fromJson(json['nha_hem']),
      loaiHem: json['hem_thong'] == null ? null : CommonModel.fromJson(json['hem_thong']),
      hemBaoNhieuMet: double.tryParse(json['hem_dai_bao_nhieu'].toString()) ?? null,
      soNamThueToiDa: json['thoi_gian_cho_thue_toi_da'] == null ? 0 : json['thoi_gian_cho_thue_toi_da'],
      cocBaoNhieuThang: json['coc_bao_nhieu_thang'] == null ? 0 : json['coc_bao_nhieu_thang'],
      giaChao: json['gia_chao_bao_nhieu'] == null ? 0 : json['gia_chao_bao_nhieu'],
      giaChot: json['gia_chot_bao_nhieu'] == null ? 0 : json['gia_chot_bao_nhieu'],
      baoNhieuNamDauKhongTangGia: json['bao_nhieu_nam_dau_khong_tang_gia'] == null ? 0 : json['bao_nhieu_nam_dau_khong_tang_gia'],
      baoNhieuNamCuoiTangBaoNhieuPhanTram: double.tryParse(json['nam_cuoi_tang_bao_nhieu'].toString()) ?? null,
      viTriThangBo: json['vi_tri_thang_bo'] == null ? null : CommonModel.fromJson(json['vi_tri_thang_bo']),
      soThangThoatHiem: int.tryParse(json['bao_nhieu_thang_thoat_hiem'].toString()) ?? 0,
      soThangMay: int.tryParse(json['bao_nhieu_thang_may'].toString()) ?? 0,
      nhaHuongGi: json['nha_huong_gi'] == null ? null : CommonModel.fromJson(json['nha_huong_gi']),
      chuNhaChoThue: json['chu_nha_cho_thue'] == null ? null : CommonModel.fromJson(json['chu_nha_cho_thue']),
      phiMoiGioi: json['phi_muoi_gioi'] == null ? 0 : json['phi_muoi_gioi'],
      nhaTheChap: json['nha_dang_the_chap'] == null ? null : CommonModel.fromJson(json['nha_dang_the_chap']),
      chuongNgaiVat: json['chuong_ngai_vat_truoc_nha'] == null ? null : CheckListModel.fromJson(json['chuong_ngai_vat_truoc_nha']),
      chuongNgaiVatKhac: json['chuong_ngai_vat_khac'] == null ? null : json['chuong_ngai_vat_khac'],

      hinhAnhNha: json['hinh_anh'] == null ? null : HinhAnhListModel.fromJson(json['hinh_anh']),
    );
  }

  @override
  List<Object> get props => [
        id,
        hienTrang,
        ghiChu,
        thongTinLienHe,
        ngang,
        dai,
        soLau,
        ham,
        sanThuong,
        sanThuongCaiTao,
        soPhong,
        soWcr,
        soWcc,
        banCong,
        cuaSo,
        hinhAnhBanVe,
        hinhAnhBanVeUpdate,
        gia,
        hoaHong,
        vat,
        nguoiThue,
        thanhPho,
        quanHuyen,
        phuongXa,
        soNha,
        tenDuong,
        phapLy,
        matTien,
        duongMotChieu,
        leDuong,
        soXet,
        loaiHem,
        kichThuocHem,
        hemBaoNhieuMet,
        soNamThueToiDa,
        giaChao,
        giaChot,
        baoNhieuNamDauKhongTangGia,
        baoNhieuNamCuoiTangBaoNhieuPhanTram,
        viTriThangBo,
        soThangThoatHiem,
        soThangMay,
        nhaHuongGi,
        chuNhaChoThue,
        phiMoiGioi,
        nhaTheChap,
        hinhAnhNha,
        hinhAnhNhaUpdate,
      ];
}
