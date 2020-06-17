import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
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
  String nguoiNhan;

  final formatter = NumberFormat("#,##0", "vi_VN");

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

  // page controller
  int _numPages;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 2,
      width: isActive ? 16 : 10,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff41BC00) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  // page controller
  getKetCauNhaCanThue(DetailKtmbModel model){
    String dt = '${model.dienTich} - ';
    String lau = '${model.soLau} lầu - ';
    String lung = '${model.lung.value == 'CO' ? 'có' : model.lung.value == 'KHONG' ? 'không có' : model.lung.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} lửng - ';
    String ham = '${model.ham.value == 'CO' ? 'có' : model.ham.value == 'KHONG' ? 'không có' : model.ham.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} hầm - ';
    String sanThuong = '${model.sanThuong.value == 'CO' ? 'có' : model.sanThuong.value == 'KHONG' ? 'không có' : model.sanThuong.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} sân thượng - ';
    String sanThuongCaiTao = 'sân thượng cải tạo ${model.sanThuongCaiTao.value == 'CO' ? 'được' : model.sanThuongCaiTao.value == 'KHONG' ? 'không được' : model.sanThuongCaiTao.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} - ';
    String phong = '${model.soPhong} phòng - ';
    String wcr = '${model.soWCR} WCR - ';
    String wcc = '${model.soWCC} WCC - ';
    String banCong = 'phòng ${model.banCong.value == 'CO' ? 'có' : model.banCong.value == 'KHONG' ? 'không có' : model.banCong.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} ban công - ';
    String cuaSo = 'phòng ${model.cuaSo.value == 'CO' ? 'có' : model.cuaSo.value == 'KHONG' ? 'không có' : model.cuaSo.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} cửa sổ - ';
    String thangBo = 'vị trí thang bộ ${model.viTriThangBo.value == 'KHONG_CO' ? 'không có' : model.viTriThangBo.value == 'TRUOC' ? 'trước nhà' : model.viTriThangBo.value == '2/3' ? '2/3 nhà' : model.viTriThangBo.value == 'GIUA_NHA' ? 'giữa nhà' : model.viTriThangBo.value == 'CUOI_NHA' ? 'cuối nhà' : model.viTriThangBo.value == 'TAT_CA' ? 'không bắt buộc' : 'chưa có dữ liệu'} - ';
    String thangThoatHiem = '${model.soThangThoatHiem} thang thoát hiểm - ';
    String thangMay = '${model.soThangMay} thang máy - ';
    String huongNha = 'nhà hướng ${model.huongNha.value == 'KHONG_XAC_DINH' ? 'chưa xác định' : model.huongNha.value == 'DONG' ? 'đông' : model.huongNha.value == 'TAY' ? 'tây' : model.huongNha.value == 'NAM' ? 'nam' : model.huongNha.value == 'BAC' ? 'bắc' : model.huongNha.value == 'DONG_NAM' ? 'đông nam' : model.huongNha.value == 'TAY_NAM' ? 'tây nam' : model.huongNha.value == 'DONG_BAC' ? 'đông bắc' : model.huongNha.value == 'TAY_BAC' ? 'tây bắc' : model.huongNha.value}';

    return dt + lau + lung + ham + sanThuong + sanThuongCaiTao + phong + wcr + wcc + banCong + cuaSo + thangBo + thangThoatHiem + thangMay + huongNha;
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
                _numPages = state.model.hinhAnh.length;
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
            children: <Widget>[
              // thong tin co ban
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
                child: Text('Nhu cầu khách tìm mặt bằng'.toUpperCase(), style: MyAppStyle.price),
              ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Text('Tình trạng: ', style: MyAppStyle.text01),
                        Expanded(
                          child: Text(
                            model.tinhTrang.value == 'CAN_GAP' ? 'Cần gấp' : 'Bình thường',
                            style: TextStyle(color: Color(0xffA00000), fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Thông tin liên hệ',
                          style: MyAppStyle.text,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Người liên hệ: ' + model.khachHang.name,
                          style: MyAppStyle.text01,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Số điện thoại: ' + model.khachHang.phone,
                          style: MyAppStyle.text01,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*_buildItemRow(
                'Thông tin liên hệ',
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
              ),*/
              _buildItemRow(
                'Mục đích thuê',
                model.mucDich == '' ? 'chưa có dữ liệu' : model.mucDich,
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
              _buildItemRow(
                'Khu vực cần thuê',
                '${model.phuongXa.name}, ${model.quanHuyen.name}, ${model.thanhPho.name}',
                () {
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
                },
              ),
              _buildItemRow(
                'Kết cấu nhà cần thuê',
                getKetCauNhaCanThue(model),
                () {
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
                },
              ),
              _buildItemRow(
                'Giá cần thuê',
                '${formatter.format(model.giaMin)} - ${formatter.format(model.giaMax)}',
                () {
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
                },
              ),
              _buildItemRow(
                'Thời gian thuê',
                '${model.thoiGianThue} tháng',
                () {
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
                },
              ),
              _buildItemRow(
                'Khách lâu năm hay khách mới',
                model.khachLauNam.value == 'CO' ? 'khách lâu năm - ${model.loaiHinh.value == 'MO_CUA_HANG_MB_MOI' ? 'mở cửa hàng/ mặt bằng mới' : model.loaiHinh.value == 'DOI_VI_TRI_KINH_DOANH' ? 'đổi vị trí kinh doanh' : 'chưa có dữ liệu'}' : 'khách mới - mở cửa hàng/ mặt bằng mới',
                () {
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
                },
              ),
              _buildItemRow(
                'Loại khách hàng',
                '${model.loaiKhachHang.value == 'CONG_TY' ? 'Công ty - ' : model.loaiKhachHang.value == 'CA_NHAN' ? 'Cá nhân - ' : 'Chưa có dữ liệu - '} ${model.tenThuongHieu}',
                () {
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
                },
              ),
              _buildItemRow(
                'Mô tả khác',
                model.moTaKhac != '' ? model.moTaKhac : 'Chưa có dữ liệu',
                () {
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
                },
              ),
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
                : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, position) {
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
                          'http://nhadat.imark.vn/' + model.hinhAnh[position].url,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    itemCount: model.hinhAnh.length, // Can be null
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
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(String text, String text01, Function onTap) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style: MyAppStyle.text,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                text01,
                style: MyAppStyle.text01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
