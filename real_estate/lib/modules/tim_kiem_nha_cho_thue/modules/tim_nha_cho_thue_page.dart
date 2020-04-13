import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/modules/vi_tri_cau_thang_update_page.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/bloc/dia_chi.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/tinh_thanh_pho_search_page.dart';
import 'package:real_estate/modules/tim_kiem_nha_cho_thue/bloc/tim_nha_cho_thue.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';

import 'ket_qua_tim_kiem_page.dart';

class TimNhaChoThuePage extends StatefulWidget {
  @override
  _TimNhaChoThuePageState createState() => _TimNhaChoThuePageState();
}

class _TimNhaChoThuePageState extends State<TimNhaChoThuePage> {
  TinhThanhPhoModel _tinhTpModel;
  TinhThanhPhoBloc _tinhThanhPhoBloc;
  PhuongXaBloc _phuongXaBloc;

  String _quanHuyenSelection;
  String _phuongXaSelection;
  String idThanhPho;

  TextEditingController _ctlTenDuong = TextEditingController();
  TextEditingController _ctlDienTich = TextEditingController();
  TextEditingController _ctlGiaMin = TextEditingController();
  TextEditingController _ctlGiaMax = TextEditingController();
  int giaMin;
  int giaMax;

  TimNhaChoThueBloc _timNhaChoThueBloc;

  final currencyFormat = new NumberFormat("#,##0", "en_US");

  bool ttncVal = false;
  String lauSelection;
  String lungSelection;
  String hamSelection;
  String sanThuongSelection;
  String phongSelection;
  String wcrSelection;
  String wccSelection;
  String thangMaySelection;
  String thoatHiemSelection;
  String huongNhaSelection;

  var controller = new MaskedTextController(mask: '000.000.000.000');

  @override
  void initState() {
    super.initState();

    _tinhThanhPhoBloc = TinhThanhPhoBloc();
    _phuongXaBloc = PhuongXaBloc();
    _timNhaChoThueBloc = TimNhaChoThueBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _timNhaChoThueBloc.close();
    _phuongXaBloc.close();
    _timNhaChoThueBloc.close();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tìm nhà cho thuê'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Image.asset('assets/group.png'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                buildTTCB(),
                Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: ttncVal,
                        onChanged: (value) {
                          setState(() {
                            ttncVal = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('Tìm nâng cao'),
                  ],
                ),
                SizedBox(height: 10),
                ttncVal ? buildTTNC() : SizedBox(),
              ],
            ),
          ),
          BlocListener(
            bloc: _timNhaChoThueBloc,
            listener: (context, state) {
              print(state);
              if (state is TimNhaChoThueLoaded) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KetQuaTimKiemPage(list: state.list)));
              }
              if (state is TimNhaChoThueEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KetQuaTimKiemPage(list: null)));
              }
              if (state is TimNhaChoThueFailure) {
                Fluttertoast.showToast(
                  msg: "Đã có lỗi xảy ra.",
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
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: MyButton(
                color: Color(0xff3FBF55),
                text: Text(
                  'Tìm',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () async {
                  ttncVal == false
                      ? _timNhaChoThueBloc.add(TimNhaChoThue(
                          thanhPho: idThanhPho,
                          quan: _quanHuyenSelection,
                          phuong: _phuongXaSelection,
                          duong: _ctlTenDuong.text,
                          dienTich: double.tryParse(_ctlDienTich.text),
                          giaMin: int.tryParse(_ctlGiaMin.text),
                          giaMax: int.tryParse(_ctlGiaMax.text),
                        ))
                      : _timNhaChoThueBloc.add(TimNhaChoThue(
                          thanhPho: idThanhPho,
                          quan: _quanHuyenSelection,
                          phuong: _phuongXaSelection,
                          duong: _ctlTenDuong.text,
                          dienTich: double.tryParse(_ctlDienTich.text),
                          giaMin: int.tryParse(_ctlGiaMin.text),
                          giaMax: int.tryParse(_ctlGiaMax.text),
                          soLau: lauSelection,
                          lung: lungSelection,
                          ham: hamSelection,
                          sanThuong: sanThuongSelection,
                          soPhong: phongSelection,
                          soWCR: wcrSelection,
                          soWCC: wccSelection,
                          thangMay: thangMaySelection,
                          thoatHiem: thoatHiemSelection,
                          huongNha: huongNhaSelection,
                        ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTTCB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Thông tin cơ bản'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 10),
        MyTopTitle(text: 'Thành phố'),
        Material(
          color: Color(0xffEBEBEB),
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            onTap: () async {
              _tinhTpModel = await Navigator.push(context, MaterialPageRoute(builder: (context) => TimTinhTpPage()));

              if (_tinhTpModel != null) {
                idThanhPho = _tinhTpModel.id;
                _tinhThanhPhoBloc.add(QuanHuyenFetch(id: _tinhTpModel.id)); //fetch quận/huyện mới theo tỉnh/tp
              } else {
                _quanHuyenSelection = null;
                _phuongXaSelection = null;
              }
            },
            borderRadius: BorderRadius.circular(7),
            child: Container(
              height: 45,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: <Widget>[
                  _tinhTpModel != null ? Text(_tinhTpModel.name) : Text(''),
                  Spacer(),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Quận'),
        BlocListener(
          bloc: _tinhThanhPhoBloc,
          listener: (BuildContext context, TinhThanhPhoState state) {
            if (state is QuanHuyenSuccess) {
              _quanHuyenSelection =
                  state.quanHuyenListModel.elementAt(0).id; //reset value mặc định(row đầu tiên) cho dropdown quận/huyện
              _phuongXaBloc.add(PhuongXaFetch(id: state.quanHuyenListModel.elementAt(0).id)); //fetch data phường/xã
            }
          },
          child: BlocBuilder(
            bloc: _tinhThanhPhoBloc,
            builder: (BuildContext context, TinhThanhPhoState state) {
              print(state);
              if (state is QuanHuyenSuccess && _tinhTpModel != null) {
                return buildQuan(state);
              }
              return Material(
                color: Color(0xffEBEBEB),
                borderRadius: BorderRadius.circular(7),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy chọn tỉnh/ thành phố!!!'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Phường'),
        BlocListener(
          bloc: _phuongXaBloc,
          listener: (BuildContext context, PhuongXaState state) {
            if (state is PhuongXaSuccess) {
              _phuongXaSelection = null;
            }
          },
          child: BlocBuilder(
            bloc: _phuongXaBloc,
            builder: (BuildContext context, PhuongXaState state) {
              print(state);
              if (state is PhuongXaSuccess && _tinhTpModel != null) {
                return buildPhuong(state);
              }
              if (state is PhuongXaFailure) {
                return Material(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hãy chọn tỉnh/ thành phố và quận/ huyện!!!'),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Material(
                color: Color(0xffEBEBEB),
                borderRadius: BorderRadius.circular(7),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy chọn tỉnh/ thành phố và quận/ huyện!!!'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Đường'),
        MyInput(
          hintText: '',
          color: Color(0xffEBEBEB),
          lines: 1,
          controller: _ctlTenDuong,
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Diện tích'),
        MyInput(
          hintText: '',
          color: Color(0xffEBEBEB),
          lines: 1,
          controller: _ctlDienTich,
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Giá'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 45,
                child: TextFormField(
                  controller: _ctlGiaMin,
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    filled: true,
                    fillColor: Color(0xffEBEBEB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 7),
            Expanded(
              child: Container(
                height: 45,
                child: TextFormField(
                  controller: _ctlGiaMax,
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    filled: true,
                    fillColor: Color(0xffEBEBEB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTTNC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Thông tin nâng cao'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Số lầu'),
                  buildLau(),
                ],
              ),
            ),
            SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Lửng'),
                  buildLung(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Hầm'),
                  buildHam(),
                ],
              ),
            ),
            SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Sân thượng'),
                  buildSanThuong(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Số phòng'),
        buildPhong(),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Số WCR'),
                  buildWCR(),
                ],
              ),
            ),
            SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Số WCC'),
                  buildWCC(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Thang máy'),
                  buildThangMay(),
                ],
              ),
            ),
            SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTopTitle(text: 'Thoát hiểm'),
                  buildThangThoatHiem(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        MyTopTitle(text: 'Hướng nhà'),
        Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(7),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            style: TextStyle(color: Colors.black87),
            underline: SizedBox(),
            onChanged: (newVal) {
              setState(() {
                huongNhaSelection = newVal;
              });
            },
            value: huongNhaSelection,
            items: listHuongNha.map((item) {
              return new DropdownMenuItem(
                child: new Text(item.title),
                value: item.value.toString(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Container buildQuan(QuanHuyenSuccess state) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            _quanHuyenSelection = newVal;
          });
          _phuongXaBloc.add(PhuongXaFetch(id: newVal));
        },
        value: _quanHuyenSelection,
        items: state.quanHuyenListModel.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.name),
            value: item.id.toString(),
          );
        }).toList(),
      ),
    );
  }

  Container buildPhuong(PhuongXaSuccess state) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            _phuongXaSelection = newVal;
          });
        },
        value: _phuongXaSelection,
        items: state.phuongXaListModel.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.name),
            value: item.id.toString(),
          );
        }).toList(),
      ),
    );
  }

  Container buildLau() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            lauSelection = newVal;
          });
        },
        value: lauSelection,
        items: listSoLauWcrWcc.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildLung() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            lungSelection = newVal;
          });
        },
        value: lungSelection,
        items: listCommon.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildHam() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            hamSelection = newVal;
          });
        },
        value: hamSelection,
        items: listCommon.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildSanThuong() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            sanThuongSelection = newVal;
          });
        },
        value: sanThuongSelection,
        items: listCommon.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildPhong() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            phongSelection = newVal;
          });
        },
        value: phongSelection,
        items: listPhong.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildWCR() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            wcrSelection = newVal;
          });
        },
        value: wcrSelection,
        items: listSoLauWcrWcc.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildWCC() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            wccSelection = newVal;
          });
        },
        value: wccSelection,
        items: listSoLauWcrWcc.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildThangMay() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            thangMaySelection = newVal;
          });
        },
        value: thangMaySelection,
        items: listCommon.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  Container buildThangThoatHiem() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            thoatHiemSelection = newVal;
          });
        },
        value: thoatHiemSelection,
        items: listCommon.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value,
          );
        }).toList(),
      ),
    );
  }

  List<HuongNha> listHuongNha = [
    HuongNha(
      index: 1,
      title: 'Đông',
      value: 'DONG',
    ),
    HuongNha(
      index: 2,
      title: 'Tây',
      value: 'TAY',
    ),
    HuongNha(
      index: 3,
      title: 'Nam',
      value: 'NAM',
    ),
    HuongNha(
      index: 4,
      title: 'Bắc',
      value: 'BAC',
    ),
    HuongNha(
      index: 5,
      title: 'Đông Nam',
      value: 'DONG_NAM',
    ),
    HuongNha(
      index: 6,
      title: 'Tây Nam',
      value: 'TAY_NAM',
    ),
    HuongNha(
      index: 7,
      title: 'Đông Bắc',
      value: 'DONG_BAC',
    ),
    HuongNha(
      index: 8,
      title: 'Tây Bắc',
      value: 'TAY_BAC',
    ),
  ];

  List<Common> listSoLauWcrWcc = [
    Common(value: '1', title: '1'),
    Common(value: '2', title: '2'),
    Common(value: '3', title: '3'),
    Common(value: '4', title: '4'),
    Common(value: '5', title: '5'),
    Common(value: '6', title: '6'),
    Common(value: '7', title: '7'),
    Common(value: '8', title: '8'),
    Common(value: '9', title: '9'),
    Common(value: '10', title: '10'),
    Common(value: '', title: 'Không quan tâm'),
  ];

  List<Common> listPhong = [
    Common(value: '1', title: '1'),
    Common(value: '2', title: '2'),
    Common(value: '3', title: '3'),
    Common(value: '4', title: '4'),
    Common(value: '5', title: '5'),
    Common(value: '6', title: '6'),
    Common(value: '7', title: '7'),
    Common(value: '8', title: '8'),
    Common(value: '9', title: '9'),
    Common(value: '10', title: '10'),
    Common(value: '11', title: '11'),
    Common(value: '12', title: '12'),
    Common(value: '13', title: '13'),
    Common(value: '14', title: '14'),
    Common(value: '15', title: '15'),
    Common(value: '', title: 'Không quan tâm'),
  ];

  List<Common> listCommon = [
    Common(value: 'CO', title: 'Có'),
    Common(value: 'KHONG', title: 'Không'),
    Common(value: '', title: 'Không quan tâm'),
  ];
}

class Common {
  final String value;
  final String title;

  Common({this.value, this.title});
}
