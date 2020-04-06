import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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

  TextEditingController _ctlTenDuong = TextEditingController();
  TextEditingController _ctlDienTich = TextEditingController();
  TextEditingController _ctlGiaMin = TextEditingController();
  TextEditingController _ctlGiaMax = TextEditingController();
  int giaMin;
  int giaMax;

  TimNhaChoThueBloc _timNhaChoThueBloc;

  final currencyFormat = new NumberFormat("#,##0", "en_US");

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
                MyTopTitle(text: 'Thành phố'),
                Material(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () async {
                      _tinhTpModel = await Navigator.push(context, MaterialPageRoute(builder: (context) => TimTinhTpPage()));

                      print(_tinhTpModel);

                      if (_tinhTpModel != null) {
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
                        return buildQuanHuyenSuccess(state);
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
                        return buildPhuongXaSuccess(state);
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
                  children: <Widget>[
                    Container(
                      height: 45,
                      child: Text('Từ: ', style: TextStyle(color: Colors.black54)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          controller: _ctlGiaMin,
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter(maxDigits: 15),
                          ],
                          onChanged: (value){
                            String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
                            double _doubleValue = int.parse(_onlyDigits) / 100;
                            giaMin = int.parse(_onlyDigits);
                            print(_doubleValue);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 15),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 7),
                    Container(
                      height: 45,
                      child: Text('đến: ', style: TextStyle(color: Colors.black54)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          controller: _ctlGiaMax,
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter(maxDigits: 15),
                          ],
                          onChanged: (value){
                            String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
                            double _doubleValue = double.parse(_onlyDigits) / 100;
                            giaMax = int.parse(_onlyDigits);
                            print(_doubleValue);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 15),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  print(giaMin);
                  print(giaMax);

                  _timNhaChoThueBloc.add(TimNhaChoThueCoBan(
                    thanhPho: _tinhTpModel.id,
                    quan: _quanHuyenSelection,
                    phuong: _phuongXaSelection,
                    duong: _ctlTenDuong.text,
                    dienTich: double.tryParse(_ctlDienTich.text) ?? 0.0,
                    giaMin: int.tryParse(_ctlGiaMin.text),
                    giaMax: int.tryParse(_ctlGiaMax.text),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildQuanHuyenSuccess(QuanHuyenSuccess state) {
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

  Container buildPhuongXaSuccess(PhuongXaSuccess state) {
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
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "vi_VN");
    String newText = formatter.format(value / 100);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}