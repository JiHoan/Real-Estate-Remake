import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/lo_trinh/bloc/lo_trinh.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/style.dart';

import 'cap_nhat_thong_tin_co_ban/bloc/call_logs.dart';
import 'cap_nhat_thong_tin_co_ban/modules/kiem_tra_lien_lac_page.dart';
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
  LoTrinhBloc _loTrinhBloc;
  CallLogsBloc _callLogsBloc;

  bool _isUpdateHienTrang = false;

  @override
  void initState() {
    super.initState();
    _choThueDetailBloc = CapNhatTtcbBloc();
    _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
    _loTrinhBloc = LoTrinhBloc();
    _callLogsBloc = CallLogsBloc();
    _callLogsBloc.add(GetCallLogs(id: widget.nhaChoThueModelId));
  }

  @override
  void dispose() {
    super.dispose();
    _choThueDetailBloc.close();
    _loTrinhBloc.close();
    _callLogsBloc.close();
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, _isUpdateHienTrang);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
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
      ),
    );
  }

  Column buildDanhSachThongTin(BuildContext context, FetchLoaded state) {
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
                      _willPopCallback();
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
              state.model.loTrinh == 'KHONG_CO_TRONG_LO_TRINH'
                  ? BlocBuilder(
                      bloc: _loTrinhBloc,
                      builder: (context, state) {
                        print(state);
                        if (state is LoTrinhLoading) {
                          /*return CircularProgressIndicator(
                            strokeWidth: 1,
                          );*/
                        }
                        if (state is LoTrinhSuccess) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 7,
                            children: <Widget>[
                              Image.asset('assets/more.png'),
                              Text(
                                'Đã thêm vào lộ trình',
                                style: TextStyle(color: Color(0xff3FBF55), fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            _loTrinhBloc.add(ThemLoTrinh(id: widget.nhaChoThueModelId));
                          },
                          child: Wrap(
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
                        );
                      },
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 7,
                      children: <Widget>[
                        Image.asset('assets/more.png'),
                        Text(
                          'Đã thêm vào lộ trình',
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
                    /*if (state.model.nguoiThue != null) {
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
                            _isUpdateHienTrang = true;

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
                            list: state.model.hienTrang.value == 'KHONG_CO_THONG_TIN_NANG_CAO'
                                ? [
                                    MyRadioList(
                                      index: 4,
                                      title: 'Chưa có thông tin nâng cao',
                                      value: 'KHONG_CO_THONG_TIN_NANG_CAO',
                                    ),
                                    MyRadioList(
                                      index: 2,
                                      title: 'Đã có thông tin nâng cao (chưa thuê)',
                                      value: 'CHUA_THUE',
                                    ),
                                    MyRadioList(
                                      index: 3,
                                      title: 'Đã thuê',
                                      value: 'DA_THUE',
                                    ),
                                  ]
                                : [
                                    MyRadioList(
                                      index: 2,
                                      title: 'Đã có thông tin nâng cao (chưa thuê)',
                                      value: 'CHUA_THUE',
                                    ),
                                    MyRadioList(
                                      index: 3,
                                      title: 'Đã thuê',
                                      value: 'DA_THUE',
                                    ),
                                  ],
                          ),
                        ),
                      ).then(
                        (value) {
                          if (value == true) {
                            _isUpdateHienTrang = true;

                            _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
                          }
                        },
                      );
                    }*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HienTrangUpdatePage(
                          id: widget.nhaChoThueModelId,
                          hienTrang: state.model.hienTrang,
                          list: state.model.hienTrang.value == 'KHONG_CO_THONG_TIN_NANG_CAO'
                              ? [
                            MyRadioList(
                              index: 4,
                              title: 'Chưa có thông tin nâng cao',
                              value: 'KHONG_CO_THONG_TIN_NANG_CAO',
                            ),
                            MyRadioList(
                              index: 2,
                              title: 'Đã có thông tin nâng cao (chưa thuê)',
                              value: 'CHUA_THUE',
                            ),
                            MyRadioList(
                              index: 3,
                              title: 'Đã thuê',
                              value: 'DA_THUE',
                            ),
                          ]
                              : [
                            MyRadioList(
                              index: 2,
                              title: 'Đã có thông tin nâng cao (chưa thuê)',
                              value: 'CHUA_THUE',
                            ),
                            MyRadioList(
                              index: 3,
                              title: 'Đã thuê',
                              value: 'DA_THUE',
                            ),
                          ],
                        ),
                      ),
                    ).then(
                          (value) {
                        if (value == true) {
                          _isUpdateHienTrang = true;

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
                        Text('Hiện trạng: ', style: MyAppStyle.text),
                        Expanded(
                          child: Text(
                            state.model.hienTrang.value == 'KHONG_CO_THONG_TIN_NANG_CAO'
                                ? 'Chưa có thông tin nâng cao'
                                : state.model.hienTrang.value == 'CHUA_THUE' ? 'Chưa thuê' : 'Đã thuê',
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
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> KiemTraLienLac(id: widget.nhaChoThueModelId, phone: state.model.thongTinLienHe.phone,))).then(
                          (value) {
                        if (value == true) {
                          _callLogsBloc.add(GetCallLogs(id: widget.nhaChoThueModelId));
                        }
                      },
                    );
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Text('Liên lạc với chủ nhà: ', style: MyAppStyle.text),
                        Expanded(
                          child: BlocBuilder(
                            bloc: _callLogsBloc,
                            builder: (context, state){
                              if (state is CallLogsLoading){
                                return Text(
                                  'Đang cập nhật',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                              if (state is CallLogsLoaded){
                                int lastIndex = state.callLogsListModel.length - 1;
                                return Text(
                                  '(' + DateFormat("dd/MM/yyyy hh:mm").format(state.callLogsListModel[lastIndex].createdAt) + ')',
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                              return Text(
                                'Chưa có dữ liệu',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
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
                      type: state.model.matTien.value == 'NHA_MAT_TIEN' ? 0 : 1,
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
                      chungNgaiVatKhac: state.model.chuongNgaiVatKhac == 'KHONG_XAC_DINH' ? '' : state.model.chuongNgaiVatKhac,
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
