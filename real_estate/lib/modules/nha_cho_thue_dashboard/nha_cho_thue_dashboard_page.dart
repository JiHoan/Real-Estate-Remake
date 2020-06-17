import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:real_estate/modules/lo_trinh/bloc/lo_trinh.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/check_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc_bloc.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final String type;
  final String diaChi;

  const NhaChoThueDashboardPage({Key key, @required this.nhaChoThueModelId, @required this.type, @required this.diaChi})
      : super(key: key);

  @override
  _NhaChoThueDashboardPageState createState() => _NhaChoThueDashboardPageState();
}

class _NhaChoThueDashboardPageState extends State<NhaChoThueDashboardPage> {
  CapNhatTtcbBloc _choThueDetailBloc;
  LoTrinhBloc _loTrinhBloc;
  CallLogsBloc _callLogsBloc;
  CapNhatTtncBloc _capNhatTtncBloc;

  bool _isUpdateHienTrang = false;
  bool _isUpdateLienLacChuNha = false;

  final formatter = NumberFormat("#,##0", "vi_VN");

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(ExportExcel(id: widget.nhaChoThueModelId));
    } catch (error) {
      print(error);
    }
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

  @override
  void initState() {
    super.initState();
    _choThueDetailBloc = CapNhatTtcbBloc();
    _choThueDetailBloc.add(FetchDetail(id: widget.nhaChoThueModelId));
    _loTrinhBloc = LoTrinhBloc();
    _callLogsBloc = CallLogsBloc();
    _callLogsBloc.add(GetCallLogs(id: widget.nhaChoThueModelId));
    _capNhatTtncBloc = CapNhatTtncBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _choThueDetailBloc.close();
    _loTrinhBloc.close();
    _callLogsBloc.close();
    _capNhatTtncBloc.close();
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(
        context, {'isUpdateHienTrang': _isUpdateHienTrang, 'isUpdateLienLacChuNha': _isUpdateLienLacChuNha, 'type': widget.type});
//    Navigator.pop(context, _isUpdateHienTrang);
    return false;
  }

  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMap() async {
    try {
      MapsLauncher.launchQuery(widget.diaChi);
    } catch (e, s) {
      print(e);
      print(s);
      throw 'Could not launch map';
    }
  }

  String getChuongNgaiVat(CheckListModel list, String chuongNgaiVatKhac) {
    List<String> listStr = [];
    String str = '';

    for (int i = 0; i < list.length; i++) {
      if (list[i].isChecked) {
        listStr.add(list[i].title);
      }
    }

    if (listStr.isEmpty) {
      str = 'chưa có dữ liệu';
      return str;
    }

    for (int i = 0; i < listStr.length; i++) {
      if (listStr[i] == listStr.last && chuongNgaiVatKhac != ' ') {
        str = str + listStr[i] + ' - ' + chuongNgaiVatKhac;
      } else if (listStr[i] == listStr.last) {
        str = str + listStr[i];
      } else {
        str = str + listStr[i] + ' - ';
      }
    }

    return str;
  }

  String getGiaChaoGiaChot(int giaChao, int giaChot, int khongTangGia, double tangPhanTram) {
    String str = '';

    str = giaChao == null ? str + 'Giá chào không có - ' : str + giaChao.toString();
    str = giaChot == null ? str + 'Giá chốt không có - ' : str + giaChot.toString();
    str = khongTangGia == null ? str + 'Giá chốt không có - ' : str + giaChot.toString();
    str = tangPhanTram == null ? str + 'Giá chốt không có' : str + giaChot.toString();

    return str;
  }

  String getViTriCauThang(NhaChoThueDetailModel model) {
    String vttb = 'Vị trí thang bộ ${model.viTriThangBo.value == 'TRUOC' ? 'trước nhà - ' : model.viTriThangBo.value == '2/3' ? '2/3 nhà - ' : model.viTriThangBo.value == 'GIUA_NHA' ? 'giữa nhà - ' : model.viTriThangBo.value == 'CUOI_NHA' ? 'cuối nhà - ' : 'không có - '}';
    String stth = '${model.soThangThoatHiem} thang thoát hiểm - ';
    String stm = '${model.soThangMay} thang máy - ';
    String hn = 'nhà hướng ${model.nhaHuongGi.value == 'KHONG_XAC_DINH' ? 'chưa xác định' : model.nhaHuongGi.value == 'DONG' ? 'đông' : model.nhaHuongGi.value == 'TAY' ? 'tây' : model.nhaHuongGi.value == 'NAM' ? 'nam' : model.nhaHuongGi.value == 'BAC' ? 'bắc' : model.nhaHuongGi.value == 'DONG_NAM' ? 'đông nam' : model.nhaHuongGi.value == 'TAY_NAM' ? 'tây nam' : model.nhaHuongGi.value == 'DONG_BAC' ? 'đông bắc' : model.nhaHuongGi.value == 'TAY_BAC' ? 'tây bắc' : model.nhaHuongGi.value}';

    return vttb + stth + stm + hn;
  }

  String getThongTinNguoiChoThue(NhaChoThueDetailModel model) {
    String nct = 'Người cho thuê là ${model.chuNhaChoThue.value == 'CHU_NHA' ? 'chủ nhà - ' : model.chuNhaChoThue.value == 'MOI_GIOI' ? 'môi giới - ' : 'chưa xác định - '}';
    String pmg = model.chuNhaChoThue.value == 'MOI_GIOI' ? 'phí môi giới ${formatter.format(model.phiMoiGioi)} - ' : '';
    String ntc = 'nhà ${model.nhaTheChap.value == 'CO' ? 'có' : 'không'} thế chấp';

    return nct + pmg + ntc;
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
                _numPages = state.model.hinhAnhNha.length;
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
        buildAppbarImage(state, context),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 7,
                children: <Widget>[
                  Image.asset('assets/location.png', height: 15),
                  GestureDetector(
                    onTap: () {
                      _launchMap();
                    },
                    child: Text(
                      'Xem trên map',
                      style: TextStyle(color: Color(0xff3FBF55), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              state.model.loTrinh == 'KHONG_CO_TRONG_LO_TRINH'
                  ? BlocListener(
                      bloc: _loTrinhBloc,
                      listener: (context, state) {
                        if (state is LoTrinhSuccess) {
                          Dialogs.showAddSuccessToast();
                        }
                      },
                      child: BlocBuilder(
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
                                Image.asset('assets/tick.png', height: 15),
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
                                Image.asset('assets/more.png', height: 15),
                                Text(
                                  'Thêm vào lộ trình',
                                  style: TextStyle(color: Color(0xff3FBF55), fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 7,
                      children: <Widget>[
                        Image.asset('assets/tick.png', height: 15),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HienTrangUpdatePage(
                          id: widget.nhaChoThueModelId,
                          hienTrang: state.model.hienTrang,
                          nguoiThue: state.model.nguoiThue,
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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Text('Hiện trạng: ', style: MyAppStyle.text01),
                        Expanded(
                          child: Text(
                            state.model.hienTrang.value == 'KHONG_CO_THONG_TIN_NANG_CAO'
                                ? 'Chưa có thông tin nâng cao'
                                : state.model.hienTrang.value == 'CHUA_THUE' ? 'Chưa thuê' : 'Đã thuê',
                            style: TextStyle(color: Color(0xffA00000), fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 20),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Text('Ghi chú: ', style: MyAppStyle.text01),
                        Expanded(
                          child: Text(
                            state.model.ghiChu == null ? 'Chưa có ghi chú' : state.model.ghiChu,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 20),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                          'Người liên hệ: ' + state.model.thongTinLienHe.name,
                          style: MyAppStyle.text01,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Số điện thoại: ' + state.model.thongTinLienHe.phone,
                          style: MyAppStyle.text01,
                          overflow: TextOverflow.ellipsis,
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
                            builder: (context) => KiemTraLienLac(
                                  id: widget.nhaChoThueModelId,
                                  phone: state.model.thongTinLienHe.phone,
                                ))).then(
                      (value) {
                        if (value == true) {
                          _isUpdateLienLacChuNha = true;
                          _callLogsBloc.add(GetCallLogs(id: widget.nhaChoThueModelId));
                        }
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Liên lạc với chủ nhà: ', style: MyAppStyle.text),
                        SizedBox(height: 5),
                        BlocBuilder(
                          bloc: _callLogsBloc,
                          builder: (context, state) {
                            if (state is CallLogsLoading) {
                              return Text(
                                'Đang cập nhật',
                                style: MyAppStyle.text01,
                              );
                            }
                            if (state is CallLogsLoaded) {
                              int lastIndex = state.callLogsListModel.length - 1;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Liên lạc gần nhất: ' +
                                        DateFormat("dd/MM/yyyy hh:mm").format(state.callLogsListModel[lastIndex].createdAt),
                                    style: MyAppStyle.text01,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      'Ghi chú: ' + state.callLogsListModel[lastIndex].note,
                                      style: MyAppStyle.text01,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Text(
                              'Chưa có dữ liệu',
                              style: MyAppStyle.text01,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildItemRow(
                'Địa chỉ',
                state.model.soNha +
                    ' ' +
                    state.model.tenDuong +
                    ', ' +
                    state.model.phuongXa.name +
                    ', ' +
                    state.model.quanHuyen.name +
                    ', ' +
                    state.model.thanhPho.name,
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
              _buildItemRow(
                'Diện tích, kết cấu, nội thất, bản vẽ',
                state.model.soLau.toString() +
                    ' lầu - ' +
                    state.model.lung.value +
                    ' lửng - ' +
                    (state.model.ham.value == 'CO' ? 'có' : 'không có') +
                    ' hầm - ' +
                    (state.model.sanThuong.value == 'CO' ? 'có' : 'không có') +
                    ' sân thượng - ' +
                    (state.model.sanThuongCaiTao.value == 'CO'
                        ? 'sân thượng cải tạo được - '
                        : 'sân thượng cải tạo không được - ') +
                    state.model.soPhong.toString() +
                    ' phòng - ' +
                    state.model.soWcr.toString() +
                    ' WCR - ' +
                    state.model.soWcc.toString() +
                    ' WCC - ' +
                    (state.model.banCong.value == 'CO' ? 'có' : 'không có') +
                    ' ban công - ' +
                    (state.model.cuaSo.value == 'CO' ? 'có' : 'không có') +
                    ' cửa sổ',
                () {
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
                },
              ),
              _buildItemRow(
                'Giá, hoa hồng, VAT',
                'Giá ' +
                    formatter.format(state.model.gia) +
                    ' - hoa hồng ' +
                    formatter.format(state.model.hoaHong) +
                    ' - VAT ' +
                    formatter.format(state.model.vat),
                () {
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
                },
              ),
              // thong tin nang cao
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Thông tin nâng cao'.toUpperCase(), style: MyAppStyle.price),
              ),
              _buildItemRow(
                'Pháp lý chủ nhà',
                (state.model.phapLy.value == 'KHONG_XAC_DINH'
                    ? 'chưa có dữ liệu'
                    : state.model.phapLy.value == 'CO' ? 'có pháp lý chủ nhà' : 'không có pháp lý chủ nhà'),
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
              _buildItemRow(
                'Nhà hẻm hay mặt tiền',
                (state.model.matTien.value == 'KHONG_XAC_DINH'
                    ? 'chưa có dữ liệu'
                    : state.model.matTien.value == 'NHA_MAT_TIEN'
                        ? 'Nhà mặt tiền - ${(state.model.duongMotChieu.value == 'DUONG_2_CHIEU' ? 'đường 2 chiều' : 'đường 1 chiều')} - lề đường ${state.model.leDuong}m'
                        : 'Nhà hẻm - ${state.model.soXet} xẹt - ${(state.model.loaiHem.value == 'HEM_NHO' ? 'hẻm nhỏ' : state.model.loaiHem.value == 'HEM_XE_HOI' ? 'hẻm xe hơi' : 'hẻm xe tải')} - ${(state.model.kichThuocHem.value == 'HEM_THONG' ? 'hẻm thông' : 'hẻm cụt')} - hẻm rộng ${state.model.hemBaoNhieuMet}m'),
                () {
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
                },
              ),

              _buildItemRow(
                'Chướng ngại vật trước nhà',
                getChuongNgaiVat(state.model.chuongNgaiVat, state.model.chuongNgaiVatKhac),
                () {
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
                },
              ),
              _buildItemRow(
                'Thời gian cho thuê tối đa',
                state.model.soNamThueToiDa == null ? 'chưa có dữ liệu' : '${state.model.soNamThueToiDa.toString()} năm',
                () {
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
                },
              ),
              _buildItemRow(
                'Cọc bao nhiêu tháng',
                state.model.cocBaoNhieuThang == null ? 'chưa có dữ liệu' : '${state.model.cocBaoNhieuThang.toString()} tháng',
                () {
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
                },
              ),
              _buildItemRow(
                'Giá chào, giá chốt',
                getGiaChaoGiaChot(state.model.giaChao, state.model.giaChot, state.model.baoNhieuNamDauKhongTangGia,
                    state.model.baoNhieuNamCuoiTangBaoNhieuPhanTram),
                () {
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
                },
              ),
              _buildItemRow(
                'Vị trí cầu thang',
                getViTriCauThang(state.model),
                () {
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
                },
              ),

              _buildItemRow(
                'Thông tin người cho thuê',
                getThongTinNguoiChoThue(state.model),
                () {
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
                },
              ),
              SizedBox(height: 15),
              BlocListener(
                bloc: _capNhatTtncBloc,
                listener: (context, state) async {
                  print(state);
                  if (state is DownloadSuccess) {
                    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                    Fluttertoast.showToast(
                      msg: "Quá trình tải xuống tập tin excel.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    _launchBrowser(state.url);
                  }
                  if (state is DownloadFailure) {
                    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                    Fluttertoast.showToast(
                      msg: "Tải xuống thất bại.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Material(
                    color: Color(0xff3FBF55),
                    borderRadius: BorderRadius.circular(40),
                    child: InkWell(
                      onTap: () {
                        _handleSubmit(context);
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 7,
                          children: <Widget>[
                            Image.asset('assets/excel.png', height: 30),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack buildAppbarImage(FetchLoaded state, BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            color: const Color(0xffE9E9E9),
            height: 170,
            width: double.infinity,
            child: state.model.hinhAnhNha.isEmpty
                ? Image.asset(
                    'assets/no-image.jpg',
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
                          'http://nhadat.imark.vn/' + state.model.hinhAnhNha[position].url,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    itemCount: state.model.hinhAnhNha.length, // Can be null
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
