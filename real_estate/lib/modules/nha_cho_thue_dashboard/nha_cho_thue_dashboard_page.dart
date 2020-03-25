import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:real_estate/utils/style.dart';

import 'cap_nhat_thong_tin_nang_cao/modules/chuong_ngai_vat_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/coc_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/gia_chao_chot_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/hem_hay_mat_tien_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/hinh_anh_nha_cho_thue_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/phap_ly_chu_nha_update_page.dart';
import 'cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'cap_nhat_thong_tin_co_ban/modules/dia_chi_update_page.dart';
import 'cap_nhat_thong_tin_co_ban/modules/dien_tich_update_page.dart';
import 'cap_nhat_thong_tin_co_ban/modules/ghi_chu_update_page.dart';
import 'cap_nhat_thong_tin_co_ban/modules/hien_trang_update_page.dart';
import 'cap_nhat_thong_tin_co_ban/modules/thong_tin_lien_he_update_page.dart';
import 'cap_nhat_thong_tin_co_ban/modules/vat_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/thoi_gian_cho_thue_toi_da_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/thong_tin_nguoi_cho_thue_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/upload_hinh_anh_update_page.dart';
import 'cap_nhat_thong_tin_nang_cao/modules/vi_tri_cau_thang_update_page.dart';

class NhaChoThueDashboardPage extends StatefulWidget {
  final int nhaChoThueModelId;

  const NhaChoThueDashboardPage({Key key, @required this.nhaChoThueModelId}) : super(key: key);

  @override
  _NhaChoThueDashboardPageState createState() => _NhaChoThueDashboardPageState();
}

class _NhaChoThueDashboardPageState extends State<NhaChoThueDashboardPage> {
  CapNhatTtcbBloc _choThueDetailBloc;

  @override
  void initState() {
    super.initState();
    _choThueDetailBloc = CapNhatTtcbBloc();

    _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder(
          bloc: _choThueDetailBloc,
          builder: (BuildContext context, CapNhatTtcbState state) {
            print(state);
            if (state is FetchLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchEmpty) {
              return Center(
                child: Text('Không có dữ liệu.'),
              );
            }
            if (state is FetchLoaded) {
              return buildDanhSachThongTin(context, state);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Column buildDanhSachThongTin(BuildContext context, FetchLoaded state) {
    print(state.model.hinhAnhNha);

    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                color: const Color(0xffE9E9E9),
                height: 170,
                width: double.infinity,
                child: state.model.hinhAnhNha.isEmpty
                    ? Image.asset(
                        'assets/no-image.png',
                        fit: BoxFit.contain,
                      )
                    : Swiper(
                        itemCount: state.model.hinhAnhNha.length,
                        pagination: state.model.hinhAnhNha.length > 1
                            ? SwiperPagination(
                                builder: SwiperPagination.dots,
                              )
                            : SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
                                return SizedBox();
                              }),
                        loop: state.model.hinhAnhNha.length > 1 ? true : false,
                        autoplay: state.model.hinhAnhNha.length > 1 ? true : false,
                        autoplayDelay: 5000,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HinhAnhNhaChoThueUpdatePage(
                                    id: widget.nhaChoThueModelId,
                                    listHinhAnh: state.model.hinhAnhNha,
                                  ),
                                ),
                              ).then(
                                (value) {
                                  if (value == true) {
                                    _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                                  }
                                },
                              );
                            },
                            child: Image.network(
                              'http://nhadat.imark.vn/' + state.model.hinhAnhNha[index].url,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Color(0xffF8A200),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('Nhà cho thuê'.toUpperCase(), style: TextStyle(fontSize: 16, color: Color(0xffF8A200))),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 15,
              bottom: 15,
              child: Material(
                color: Color(0xff41BC00),
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadHinhAnhUpdatePage(
                          id: widget.nhaChoThueModelId,
                        ),
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                        }
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/camera.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 7,
                children: <Widget>[
                  Image.asset('assets/location.png'),
                  Text(
                    'Xem trên map',
                    style: TextStyle(color: Color(0xff3FBF55), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 7,
                children: <Widget>[
                  Image.asset('assets/more.png'),
                  Text(
                    'Thêm vào lộ trình',
                    style: TextStyle(color: Color(0xff3FBF55), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 15),
            children: <Widget>[
              // thong tin co ban
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Thông tin cơ bản'.toUpperCase(), style: MyAppStyle.price),
              ),
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    if (state.model.nguoiThue != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HienTrangUpdatePage(
                            id: widget.nhaChoThueModelId,
                            hienTrang: state.model.hienTrang,
                            ten: state.model.nguoiThue.name,
                            sdt: state.model.nguoiThue.phone,
                          ),
                        ),
                      ).then(
                        (value) {
                          if (value == true) {
                            _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                          }
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HienTrangUpdatePage(
                            id: widget.nhaChoThueModelId,
                            hienTrang: state.model.hienTrang,
                          ),
                        ),
                      ).then(
                        (value) {
                          if (value == true) {
                            _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                          }
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Text('Hiện trạng: ', style: MyAppStyle.text),
                        Expanded(
                          child: Text(
                            state.model.hienTrang.value == 'CHUA_LIEN_HE'
                                ? 'Chưa liên hệ'
                                : state.model.hienTrang.value == 'CHUA_THUE' ? 'Chưa thuê' : 'Khác',
                            style: TextStyle(color: Color(0xffA00000), fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 100),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GhiChuUpdatePage(id: state.model.id, ghiChu: state.model.ghiChu),
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                        }
                      },
                    );
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Text('Ghi chú: ', style: MyAppStyle.text),
                        Expanded(
                          child: Text(
                            state.model.ghiChu == '' ? 'chưa có ghi chú' : state.model.ghiChu,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 100),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              ),
              _buildItemRow(
                'Thông tin liên hệ',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThongTinLienHeUpdatePage(
                        thongTinLienHe: state.model.thongTinLienHe,
                        id: widget.nhaChoThueModelId,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value == true) {
                        _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                      }
                    },
                  );
                },
              ),
              _buildItemRow(
                'Địa chỉ',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiaChiUpdatePage(
                        id: widget.nhaChoThueModelId,
                        thanhPho: state.model.thanhPho,
                        quanHuyen: state.model.quanHuyen,
                        phuongXa: state.model.phuongXa,
                        soNha: state.model.soNha,
                        tenDuong: state.model.tenDuong,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value == true) {
                        _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                      }
                    },
                  );
                },
              ),
              _buildItemRow('Diện tích, kết cấu, nội thất, bản vẽ', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DienTichUpdatePage(
                      id: widget.nhaChoThueModelId,
                      ngang: state.model.ngang,
                      dai: state.model.dai,
                      lau: state.model.soLau,
                      lung: state.model.lung,
                      ham: state.model.ham,
                      sanThuong: state.model.sanThuong,
                      sanThuongCaiTao: state.model.sanThuongCaiTao,
                      soPhong: state.model.soPhong,
                      soWcc: state.model.soWcc,
                      soWcr: state.model.soWcr,
                      banCong: state.model.banCong,
                      cuaSo: state.model.cuaSo,
                      listHinhAnh: state.model.hinhAnhBanVe,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              _buildItemRow('Giá, hoa hồng, VAT', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VATUpdatePage(
                      id: widget.nhaChoThueModelId,
                      gia: state.model.gia,
                      hoaHong: state.model.hoaHong,
                      vat: state.model.vat,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              // thong tin nang cao
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Thông tin nâng cao'.toUpperCase(), style: MyAppStyle.price),
              ),
              _buildItemRow(
                'Pháp lý chủ nhà',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhapLyChuNhaUpdatePage(
                        id: widget.nhaChoThueModelId,
                        phapLy: state.model.phapLy,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value == true) {
                        _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                      }
                    },
                  );
                },
              ),
              _buildItemRow('Nhà hẻm hay mặt tiền', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HemHayMatTienUpdatePage(
                      id: widget.nhaChoThueModelId,
                      matTien: state.model.matTien,
                      leDuong: state.model.leDuong,
                      duongMotChieu: state.model.duongMotChieu,
                      hemBaoNhieuMet: state.model.hemBaoNhieuMet,
                      loaiHem: state.model.loaiHem,
                      kichThuocHem: state.model.kichThuocHem,
                      soXet: state.model.soXet,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),

              _buildItemRow('Chướng ngại vật trước nhà', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChuongNgaiVatUpdatePage(
                      id: widget.nhaChoThueModelId,
                      chuongNgaiVat: state.model.chuongNgaiVat,
                      chungNgaiVatKhac: state.model.chuongNgaiVatKhac,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              _buildItemRow('Thời gian cho thuê tối đa', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThoiGianChoThueToiDaUpdatePage(
                      id: widget.nhaChoThueModelId,
                      soNamThueToiDa: state.model.soNamThueToiDa,
                      /*id: widget.nhaChoThueModelId,
                      matTien: state.model.matTien,
                      leDuong: state.model.leDuong,
                      duongMotChieu: state.model.duongMotChieu,

                      hemBaoNhieuMet: state.model.hemBaoNhieuMet,
                      loaiHem: state.model.loaiHem,
                      kichThuocHem: state.model.kichThuocHem,
                      soXet: state.model.soXet,*/
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              _buildItemRow('Cọc bao nhiêu tháng', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CocUpdatePage(
                      id: widget.nhaChoThueModelId,
                      conBaoNhieuThang: state.model.cocBaoNhieuThang,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              _buildItemRow('Giá chào, giá chốt', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GiaChaoChotUpdatePage(
                      id: widget.nhaChoThueModelId,
                      giaChao: state.model.giaChao,
                      giaChot: state.model.giaChot,
                      baoNhieuNamDauKhongTangGia: state.model.baoNhieuNamDauKhongTangGia,
                      baoNhieuNamCuoiTangBaoNhieuPhanTram: state.model.baoNhieuNamCuoiTangBaoNhieuPhanTram,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              _buildItemRow('Vị trí cầu thang', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViTriCauThangUpdatePage(
                      id: widget.nhaChoThueModelId,
                      viTriThangBo: state.model.viTriThangBo,
                      soThangThoatHiem: state.model.soThangThoatHiem,
                      soThangMay: state.model.soThangMay,
                      nhaHuongGi: state.model.nhaHuongGi,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              _buildItemRow('Thông tin người cho thuê', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThongTinNguoiChoThueUpdatePage(
                      id: widget.nhaChoThueModelId,
                      chuNhaChoThue: state.model.chuNhaChoThue,
                      phiMoiGioi: state.model.phiMoiGioi,
                      nhaTheChap: state.model.nhaTheChap,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                    }
                  },
                );
              }),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Material(
                  color: Color(0xff3FBF55),
                  borderRadius: BorderRadius.circular(40),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 7,
                        children: <Widget>[
                          Image.asset('assets/excel.png'),
                          Text(
                            'Xuất excel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(String text, Function onTap) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  text,
                  style: MyAppStyle.text,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.navigate_next,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
