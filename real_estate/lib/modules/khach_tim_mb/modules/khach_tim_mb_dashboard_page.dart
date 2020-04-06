import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/khach_tim_mb/model/detail_ktmb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/modules/cap_nhat_khach_tim_mb/thong_tin_lien_he_update_page.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/thong_tin_lien_he/thong_tin_lien_he_next_page.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/style.dart';

import 'cap_nhat_khach_tim_mb/gia_can_thue_update_page.dart';
import 'cap_nhat_khach_tim_mb/hinh_anh_ktmb_page.dart';
import 'cap_nhat_khach_tim_mb/hinh_anh_ktmb_upload_page.dart';
import 'cap_nhat_khach_tim_mb/ket_cau_nha_can_thue_update_page.dart';
import 'cap_nhat_khach_tim_mb/khach_lau_nam_hay_moi_update_page.dart';
import 'cap_nhat_khach_tim_mb/khu_vuc_can_thue_update_page.dart';
import 'cap_nhat_khach_tim_mb/loai_khach_update_page.dart';
import 'cap_nhat_khach_tim_mb/mo_ta_khac_update_page.dart';
import 'cap_nhat_khach_tim_mb/muc_dich_thue_update_page.dart';
import 'cap_nhat_khach_tim_mb/thoi_gian_thue_update_page.dart';
import 'cap_nhat_khach_tim_mb/tinh_trang_update_page.dart';

class KhachTimMbDashboardPage extends StatefulWidget {
  final int id;

  const KhachTimMbDashboardPage({Key key, @required this.id}) : super(key: key);

  @override
  _KhachTimMbDashboardPageState createState() => _KhachTimMbDashboardPageState();
}

class _KhachTimMbDashboardPageState extends State<KhachTimMbDashboardPage> {
  KhachTimMbBloc _khachTimMbBloc;
  bool _isUpdateTinhTrang = false;

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
    _khachTimMbBloc.add(FetchDetail(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    _khachTimMbBloc.close();
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, _isUpdateTinhTrang);
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
            bloc: _khachTimMbBloc,
            builder: (context, state) {
              print(state);
              if (state is KhachTimMbLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is KhachTimMbEmpty) {
                return Center(
                  child: Text('Không có dữ liệu.'),
                );
              }
              if (state is DetailKhachTimMbLoaded) {
                DetailKtmbModel model = state.model;
                return _buildDanhSachChiTiet(context, model);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Column _buildDanhSachChiTiet(BuildContext context, DetailKtmbModel model) {
    return Column(
      children: <Widget>[
        _buildHinhAnh(context, model),
        Flexible(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            children: <Widget>[
              // thong tin co ban
              Text('Nhu cầu khách tìm mặt bằng'.toUpperCase(), style: MyAppStyle.price),
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TinhTrangUpdatePage(
                          id: model.id,
                          tinhTrang: model.tinhTrang,
                          rdMoTaList: [
                            MyRadioList(
                              index: 1,
                              title: 'Bình thường',
                              value: 'BINH_THUONG',
                            ),
                            MyRadioList(
                              index: 2,
                              title: 'Cần gấp',
                              value: 'CAN_GAP',
                            ),
                          ],
                        ),
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          _isUpdateTinhTrang = true;
                          _khachTimMbBloc.add(FetchDetail(id: widget.id));
                        }
                      },
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'Tình trạng: ',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(
                                text: model.tinhTrang.value == 'CAN_GAP' ? 'Cần gấp' : 'Bình thường',
                                style: TextStyle(
                                  color: Color(0xffA00000),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
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
              _buildItemRow(
                'Thông tin liên hệ',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThongTinLienHeUpdatePage(
                        id: widget.id,
                        sdt: model.khachHang.phone,
                        ten: model.khachHang.name,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value == true) {
                        _khachTimMbBloc.add(FetchDetail(id: widget.id));
                      }
                    },
                  );
                },
              ),
              _buildItemRow(
                'Mục đích thuê',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MucDichThueUpdatePage(
                        id: widget.id,
                        mucDich: model.mucDich,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value == true) {
                        _khachTimMbBloc.add(FetchDetail(id: widget.id));
                      }
                    },
                  );
                },
              ),
              _buildItemRow('Khu vực cần thuê', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KhuVucCanThueUpdatePage(
                      id: widget.id,
                      thanhPho: model.thanhPho,
                      quanHuyen: model.quanHuyen,
                      phuongXa: model.phuongXa,
                      tenDuong: model.tenDuong,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
              _buildItemRow('Kết cấu nhà cần thuê', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KetCauNhaCanThueUpdatePage(
                      id: widget.id,
                      dienTich: model.dienTich,
                      soLau: model.soLau,
                      lung: model.lung,
                      ham: model.ham,
                      sanThuong: model.sanThuong,
                      sanThuongCaiTao: model.sanThuongCaiTao,
                      soPhong: model.soPhong,
                      soWCR: model.soWCR,
                      soWCC: model.soWCC,
                      banCong: model.banCong,
                      cuaSo: model.cuaSo,
                      viTriThangBo: model.viTriThangBo,
                      soThangThoatHiem: model.soThangThoatHiem,
                      soThangMay: model.soThangMay,
                      huongNha: model.huongNha,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
              _buildItemRow('Giá cần thuê', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GiaCanThueUpdatePage(
                      id: widget.id,
                      giaMin: model.giaMin,
                      giaMax: model.giaMax,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
              _buildItemRow('Thời gian thuê', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThoiGianThueUpdatePage(
                      id: widget.id,
                      thoiGianThue: model.thoiGianThue,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
              _buildItemRow('Khách lâu năm hay khách mới', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KhachLauNamHayMoiUpdatePage(
                      id: widget.id,
                      khachLauNam: model.khachLauNam,
                      loaiHinh: model.loaiHinh,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
              _buildItemRow('Loại khách hàng', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoaiKhachUpdatePage(
                      id: widget.id,
                      loaiKhachHang: model.loaiKhachHang,
                      tenThuongHieu: model.tenThuongHieu,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
              _buildItemRow('Mô tả khác', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoTaKhacUpdatePage(
                      id: widget.id,
                      moTaKhac: model.moTaKhac,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Stack _buildHinhAnh(BuildContext context, DetailKtmbModel model) {
    return Stack(
      children: <Widget>[
        Container(
            color: const Color(0xffE9E9E9),
            height: 170,
            width: double.infinity,
            child: model.hinhAnh.isEmpty
                ? Image.asset(
                    'assets/no-image.png',
                    fit: BoxFit.contain,
                  )
                : Swiper(
                    itemCount: model.hinhAnh.length,
                    pagination: model.hinhAnh.length > 1
                        ? SwiperPagination(
                            builder: SwiperPagination.dots,
                          )
                        : SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
                            return SizedBox();
                          }),
                    loop: model.hinhAnh.length > 1 ? true : false,
                    autoplay: model.hinhAnh.length > 1 ? true : false,
                    autoplayDelay: 5000,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HinhAnhKtmbPage(
                                id: widget.id,
                                listHinhAnh: model.hinhAnh,
                              ),
                            ),
                          ).then(
                            (value) {
                              if (value == true) {
                                _khachTimMbBloc.add(FetchDetail(id: widget.id));
                              }
                            },
                          );
                        },
                        child: Image.network(
                          'http://nhadat.imark.vn/' + model.hinhAnh[index].url,
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
              Text('Khách tìm mặt bằng'.toUpperCase(), style: TextStyle(fontSize: 16, color: Color(0xffF8A200))),
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
                    builder: (context) => HinhAnhKtmbUploadPage(
                      id: widget.id,
                    ),
                  ),
                ).then(
                  (value) {
                    if (value == true) {
                      _khachTimMbBloc.add(FetchDetail(id: widget.id));
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
    );
  }

  Material _buildItemRow(String text, Function onTap) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
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
    );
  }
}
