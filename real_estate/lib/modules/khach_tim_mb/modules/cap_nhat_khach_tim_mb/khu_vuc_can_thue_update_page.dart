import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/dia_chi_common_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/bloc/dia_chi.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/tinh_thanh_pho_search_page.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class KhuVucCanThueUpdatePage extends StatefulWidget {
  final int id;
  final DiaChiCommonModel thanhPho;
  final DiaChiCommonModel quanHuyen;
  final DiaChiCommonModel phuongXa;
  final String tenDuong;

  const KhuVucCanThueUpdatePage(
      {Key key,
      @required this.id,
      @required this.thanhPho,
      @required this.quanHuyen,
      @required this.phuongXa,
      @required this.tenDuong})
      : super(key: key);

  @override
  _KhuVucCanThueUpdatePageState createState() => _KhuVucCanThueUpdatePageState();
}

class _KhuVucCanThueUpdatePageState extends State<KhuVucCanThueUpdatePage> {
  TinhThanhPhoModel _tinhTpModel;
  String _quanHuyenSelection;
  String _phuongXaSelection;

  KhachTimMbBloc _khachTimMbBloc;
  TinhThanhPhoBloc _tinhThanhPhoBloc;
  PhuongXaBloc _phuongXaBloc;

  TextEditingController ctlTenDuong = TextEditingController();

  String _tenThanhPho = '';
  String _idThanhPho;

  bool _quanHuyenUpdated = false;
  bool _phuongXaUpdated = false;

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(
        UpdateKhuVucCanThue(
          id: widget.id,
          thanhPho: _idThanhPho,
          quan: _quanHuyenSelection,
          phuong: _phuongXaSelection,
          tenDuong: ctlTenDuong.text,
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
    _tinhThanhPhoBloc = TinhThanhPhoBloc();
    _phuongXaBloc = PhuongXaBloc();

    _tenThanhPho = widget.thanhPho.name; // fetch ten tp => dien vao UI
    _idThanhPho = widget.thanhPho.id;
    _tinhThanhPhoBloc.add(QuanHuyenFetch(id: widget.thanhPho.id)); // fetch quan theo tp => du lieu vao dropdown

    ctlTenDuong.text = widget.tenDuong;
  }

  @override
  void dispose() {
    super.dispose();
    _khachTimMbBloc.close();
    _tinhThanhPhoBloc.close();
    _phuongXaBloc.close();
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
                      // chuyen sang page tim kiem tp
                      _tinhTpModel = await Navigator.push(context, MaterialPageRoute(builder: (context) => TimTinhTpPage()));

                      if (_tinhTpModel != null) {
                        _tenThanhPho = _tinhTpModel.name;
                        _idThanhPho = _tinhTpModel.id;
                        _quanHuyenUpdated = true; // state quan huyen duoc cap nhat khi chon tp khac
                        _onChanged = true;

                        _tinhThanhPhoBloc.add(QuanHuyenFetch(id: _tinhTpModel.id)); //fetch quan theo tp moi chon
                      }
                    },
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: <Widget>[
                          Text(_tenThanhPho),
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
                      if (widget.quanHuyen != null && _quanHuyenUpdated == false) {
                        // khi moi vao trang update && chua chon tp khac
                        // fetch du lieu quan/huyen vao dropdown
                        _quanHuyenSelection = widget.quanHuyen.id;
                        _phuongXaBloc.add(PhuongXaFetch(id: widget.quanHuyen.id)); // fetch du lieu phuong/xa theo quan
                      } else {
                        // khi da chon tp khac
                        // fetch lai quan/huyen theo tp khac
                        // gia tri mac dinh cua dropdown index[0]
                        _quanHuyenSelection = state.quanHuyenListModel.elementAt(0).id;
                        _phuongXaUpdated = true; // state da cap nhat quan/huyen
                        _phuongXaBloc.add(PhuongXaFetch(id: state.quanHuyenListModel.elementAt(0).id));
                      }
                    }
                  },
                  child: BlocBuilder(
                    bloc: _tinhThanhPhoBloc,
                    builder: (BuildContext context, TinhThanhPhoState state) {
                      print(state);
                      if (state is QuanHuyenSuccess) {
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
                      if (widget.phuongXa != null && _phuongXaUpdated == false) {
                        // khi moi vao & chua update gi
                        _phuongXaSelection = widget.phuongXa.id;
                      } else {
                        // da update quan huyen khac
                        // reset mac dinh la null
                        _phuongXaSelection = null;
                      }
                    }
                  },
                  child: BlocBuilder(
                    bloc: _phuongXaBloc,
                    builder: (BuildContext context, PhuongXaState state) {
                      if (state is PhuongXaSuccess) {
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
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlTenDuong,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
              ],
            ),
          ),
          _onChanged == false
              ? MyButtonDisable()
              : BlocListener(
                  bloc: _khachTimMbBloc,
                  listener: (context, state) {
                    if (state is KhachTimMbSuccess) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Navigator.pop(context, _changed); // pop về dashboard
                      Dialogs.showUpdateSuccessToast();
                    }
                    if (state is KhachTimMbFailure) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Dialogs.showFailureToast();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: MyButton(
                      color: Color(0xff3FBF55),
                      text: Text(
                        'Lưu',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      event: () {
                        if(_idThanhPho != null && _quanHuyenSelection != null && _phuongXaSelection != null && ctlTenDuong.text != ''){
                          _changed = true;
                          _handleSubmit(context);
                        } else {
                          // todo
//                          Dialogs.showMissInfoToast()
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
            _phuongXaUpdated = true;

            _onChanged = true;
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

            _onChanged = true;
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
