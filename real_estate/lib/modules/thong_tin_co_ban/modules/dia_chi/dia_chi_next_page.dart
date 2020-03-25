import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dien_tich_ket_cau_noi_that/dien_tich_next_page.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';

import 'bloc/dia_chi.dart';
import 'model/tinh_thanh_pho_model.dart';
import 'tinh_thanh_pho_search_page.dart';

class DiaChiNextPage extends StatefulWidget {
  final String sdtNguoiNhan;
  final String tenNguoiNhan;

  const DiaChiNextPage({Key key, @required this.sdtNguoiNhan, @required this.tenNguoiNhan}) : super(key: key);

  @override
  _DiaChiNextPageState createState() => _DiaChiNextPageState();
}

class _DiaChiNextPageState extends State<DiaChiNextPage> {
  TinhThanhPhoModel _tinhTpModel;

  String _quanHuyenSelection;
  String _phuongXaSelection;

  TinhThanhPhoBloc _tinhThanhPhoBloc;
  PhuongXaBloc _phuongXaBloc;

  TextEditingController _ctlSoNha = TextEditingController();
  TextEditingController _ctlTenDuong = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tinhThanhPhoBloc = TinhThanhPhoBloc();
    _phuongXaBloc = PhuongXaBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Địa chỉ'),
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
                MyTopTitle(text: 'Chọn tỉnh/ thành phố'),
                Material(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () async {
                      _tinhTpModel = await Navigator.push(context, MaterialPageRoute(builder: (context) => TimTinhTpPage()));

                      if (_tinhTpModel != null) {
                        _tinhThanhPhoBloc.add(QuanHuyenFetch(id: _tinhTpModel.id)); //fetch quận/huyện mới theo tỉnh/tp
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
                      print(state);
                      if (state is QuanHuyenSuccess) {
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
                      if (state is PhuongXaSuccess) {
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
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTopTitle(text: 'Số nhà'),
                          MyInput(
                            hintText: '',
                            color: Color(0xffEBEBEB),
                            lines: 1,
                            controller: _ctlSoNha,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTopTitle(text: 'Tên đường'),
                          MyInput(
                            hintText: '',
                            color: Color(0xffEBEBEB),
                            lines: 1,
                            controller: _ctlTenDuong,
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  'Tiếp tục',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () {
                  if (_tinhTpModel == null ||
                      _quanHuyenSelection == null ||
                      _phuongXaSelection == null ||
                      _ctlSoNha.text == '' ||
                      _ctlTenDuong.text == '') {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy nhập đầy đủ thông tin !'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DienTichNextPage(
                          type: 'NHA_CHO_THUE',
                          sdtNguoiNhan: widget.sdtNguoiNhan,
                          tenNguoiNhan: widget.tenNguoiNhan,
                          tinhTpId: _tinhTpModel.id,
                          quanHuyenId: _quanHuyenSelection,
                          phuongXaId: _phuongXaSelection,
                          soNha: _ctlSoNha.text,
                          tenDuong: _ctlTenDuong.text,
                        ),
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
