import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/bloc/dia_chi.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/tinh_thanh_pho_search_page.dart';
import 'package:real_estate/modules/tim_kiem_nha_cho_thue/bloc/tim_nha_cho_thue.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

import '../them_khach_tim_mb/ket_cau_nha_can_thue_next_page.dart';

class KhuVucCanThueNextPage extends StatefulWidget {
  final String moTa;
  final String sdt;
  final String ten;
  final String mucDich;

  const KhuVucCanThueNextPage({Key key, this.moTa, this.sdt, this.ten, this.mucDich}) : super(key: key);

  @override
  _KhuVucCanThueNextPageState createState() => _KhuVucCanThueNextPageState();
}

class _KhuVucCanThueNextPageState extends State<KhuVucCanThueNextPage> {
  TinhThanhPhoModel _tinhTpModel;
  TinhThanhPhoBloc _tinhThanhPhoBloc;
  PhuongXaBloc _phuongXaBloc;

  String _quanHuyenSelection;
  String _phuongXaSelection;

  TextEditingController ctlTenDuong = TextEditingController();

  TimNhaChoThueBloc _timNhaChoThueBloc;

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
        title: Text('Khu vực cần thuê'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: (){
                Dialogs.showBackHomeDialog(context);
              },
              child: Container(
                child: Image.asset('assets/group.png'),
              ),
            ),
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
                MyTopTitle(text: 'Chọn tỉnh/ thành phố'),
                Material(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () async {
                      _tinhTpModel = await Navigator.push(context, MaterialPageRoute(builder: (context) => TimTinhTpPage()));

                      print(_tinhTpModel);

                      if (_tinhTpModel != null) {
                        _tinhThanhPhoBloc.add(QuanHuyenFetch(id: _tinhTpModel.id)); //fetch quận/huyện mới theo tỉnh/tp
                      } else{
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
                MyTopTitle(text: 'Chọn quận/ huyện'),
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
                      if (state is QuanHuyenSuccess && _tinhTpModel != null) {
                        return buildQuanHuyenSuccess(state);
                      }
                      if (state is QuanHuyenLoading) {
                        return Container(
                          height: 45,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: <Widget>[
                              SpinKitThreeBounce(color: Colors.black87, size: 15),
                              Spacer(),
                              Icon(Icons.arrow_drop_down),
                            ],
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
                MyTopTitle(text: 'Chọn phường/ xã/ thị trấn'),
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
                      if (state is PhuongXaLoading) {
                        return Container(
                          height: 45,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: <Widget>[
                              SpinKitThreeBounce(color: Colors.black87, size: 15),
                              Spacer(),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        );
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
                MyTopTitle(text: 'Tên đường'),
                Container(
                  height: 45,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(color: Colors.black87),
                    controller: ctlTenDuong,
                    toolbarOptions: ToolbarOptions(cut: false, copy: true, paste: true, selectAll: true),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      filled: true,
                      fillColor: Color(0xffEBEBEB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: MyButton(
                color: Color(0xff3FBF55),
                text: Text(
                  'Lưu & Tiếp tục',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () {
                  if (_quanHuyenSelection != null) {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KetCauNhaCanThueNextPage(
                              moTa: widget.moTa,
                              sdt: widget.sdt,
                              ten: widget.ten,
                              mucDich: widget.mucDich,
                              thanhPho: _tinhTpModel.id,
                              quan: _quanHuyenSelection,
                              phuong: _phuongXaSelection,
                              tenDuong: ctlTenDuong.text,
                            )));
                  } else {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy nhập đầy đủ thông tin.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
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
