import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/dia_chi_common_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/bloc/dia_chi.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/model/tinh_thanh_pho_model.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/dia_chi/tinh_thanh_pho_search_page.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';

class DiaChiUpdatePage extends StatefulWidget {
  final int id;
  final DiaChiCommonModel thanhPho;
  final DiaChiCommonModel quanHuyen;
  final DiaChiCommonModel phuongXa;
  final String soNha;
  final String tenDuong;

  const DiaChiUpdatePage({Key key, @required this.id, @required this.thanhPho, @required this.quanHuyen, @required this.phuongXa,@required this.soNha, @required this.tenDuong}) : super(key: key);

  @override
  _DiaChiUpdatePageState createState() => _DiaChiUpdatePageState();
}

class _DiaChiUpdatePageState extends State<DiaChiUpdatePage> {
  TinhThanhPhoModel _tinhTpModel;

  String _quanHuyenSelection;
  String _phuongXaSelection;

  TinhThanhPhoBloc _tinhThanhPhoBloc;
  PhuongXaBloc _phuongXaBloc;

  TextEditingController ctlSoNha = TextEditingController();
  TextEditingController ctlTenDuong = TextEditingController();

  String _tenThanhPho = '';
  String _idThanhPho;

  /*DiaChiCommonModel get _thanhPho => widget.thanhPho;
  DiaChiCommonModel get _quanHuyen => widget.quanHuyen;
  DiaChiCommonModel get _phuongXa => widget.phuongXa;*/

  bool _quanHuyenUpdated = false;
  bool _phuongXaUpdated = false;

  CapNhatTtcbBloc _nhaChoThueDetailBloc;
  bool _onChanged = false;
  bool _changed = false;

  @override
  void initState() {
    super.initState();

    _tinhThanhPhoBloc = TinhThanhPhoBloc();
    _phuongXaBloc = PhuongXaBloc();

    if(widget.thanhPho != null){
      _tenThanhPho = widget.thanhPho.name;
      _idThanhPho = widget.thanhPho.id;

      _tinhThanhPhoBloc.add(QuanHuyenFetch(id: widget.thanhPho.id));
    }

    ctlSoNha.text = widget.soNha;
    ctlTenDuong.text = widget.tenDuong;

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();
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
                        _tenThanhPho = _tinhTpModel.name;
                        _idThanhPho = _tinhTpModel.id;

                        _quanHuyenUpdated = true;

                        _onChanged = true;

                        _tinhThanhPhoBloc.add(QuanHuyenFetch(id: _tinhTpModel.id)); //fetch quận/huyện mới theo tỉnh/tp
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
                      if (widget.quanHuyen != null  && _quanHuyenUpdated == false) {
                        // fetch dữ liệu vào quân/ huyện khi vào trang update
                        _quanHuyenSelection = widget.quanHuyen.id;
                        // fetch data phường/xã
                        _phuongXaBloc.add(PhuongXaFetch(id: widget.quanHuyen.id));
                      } else {
                        // khi update mới địa chỉ
                        // reset value mặc định(row đầu tiên) cho dropdown quận/huyện
                        _quanHuyenSelection = state.quanHuyenListModel.elementAt(0).id;

                        _phuongXaUpdated = true;
                        // fetch data phường/xã
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
                        _phuongXaSelection = widget.phuongXa.id;
                      } else {
                        _phuongXaSelection = null;
                      }
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
                            controller: ctlSoNha,
                            onChanged: (value) {
                              setState(() {
                                _onChanged = true;
                              });
                            },
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
                  ],
                ),
              ],
            ),
          ),
          _onChanged == false
              ? Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: MyButton(
              color: Colors.black26,
              text: Text(
                'Lưu',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              event: null,
            ),
          )
              : BlocListener(
            bloc: _nhaChoThueDetailBloc,
            listener: (context, state) {
              if (state is UpdateSuccess) {
                Navigator.pop(context, _changed);
              }
            },
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: MyButton(
                  color: Color(0xff3FBF55),
                  text: Text(
                    'Lưu',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  event: () {
                    if (_tenThanhPho == null ||
                        _quanHuyenSelection == null ||
                        _phuongXaSelection == null ||
                        ctlSoNha.text == '' ||
                        ctlTenDuong.text == '') {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hãy nhập đầy đủ thông tin !'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      _changed = true;

                      _nhaChoThueDetailBloc.add(
                          UpdateDiaChi(
                            id: widget.id,
                            thanhPho: _idThanhPho,
                            quanHuyen: _quanHuyenSelection,
                            phuongXa: _phuongXaSelection,
                            soNha: ctlSoNha.text,
                            tenDuong: ctlTenDuong.text,
                          ),
                      );
                      /*ThongTinLienHeModel _model =
                      ThongTinLienHeModel(name: ctlTenNguoiNhan.text, phone: ctlSdtNguoiNhan.text);

                      _nhaChoThueDetailBloc.add(UpdateThongTinLienHe(model: _model, id: widget.id));*/
                    }
                  },
                ),
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
