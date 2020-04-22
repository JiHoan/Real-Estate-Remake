import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/currency_textfield.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class GiaChaoChotUpdatePage extends StatefulWidget {
  final int id;
  final int giaChao;
  final int giaChot;
  final int baoNhieuNamDauKhongTangGia;
  final double baoNhieuNamCuoiTangBaoNhieuPhanTram;

  const GiaChaoChotUpdatePage(
      {Key key,
      @required this.id,
      @required this.giaChao,
      @required this.giaChot,
      @required this.baoNhieuNamDauKhongTangGia,
      @required this.baoNhieuNamCuoiTangBaoNhieuPhanTram})
      : super(key: key);

  @override
  _GiaChaoChotUpdatePageState createState() => _GiaChaoChotUpdatePageState();
}

class _GiaChaoChotUpdatePageState extends State<GiaChaoChotUpdatePage> {
  TextEditingController ctlGiaChao = TextEditingController();
  TextEditingController ctlGiaChot = TextEditingController();
  TextEditingController ctlBnndktg = TextEditingController();
  TextEditingController ctlBnnctbnpt = TextEditingController();

  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(UpdateGiaChaoGiaChot(
        id: widget.id,
        giaChao: int.tryParse(ctlGiaChao.text.replaceAll('.', '')) ?? 0,
        giaChot: int.tryParse(ctlGiaChot.text.replaceAll('.', '')) ?? 0,
        nam: int.tryParse(ctlBnndktg.text),
        phanTram: double.tryParse(ctlBnnctbnpt.text),
      ));
    } catch (error) {
      print(error);
    }
  }

  final formatter = NumberFormat("#,###", "vi_VN");

  String giaChao = '';
  String giaChot = '';

  @override
  void initState() {
    super.initState();
    _capNhatTtncBloc = CapNhatTtncBloc();

    if (widget.giaChao != null) {
      ctlGiaChao.text = formatter.format(widget.giaChao);
    }
    if (widget.giaChot != null) {
      ctlGiaChot.text = formatter.format(widget.giaChot);
    }
    if (widget.baoNhieuNamDauKhongTangGia != null) {
      ctlBnndktg.text = widget.baoNhieuNamDauKhongTangGia.toString();
    }
    if (widget.baoNhieuNamCuoiTangBaoNhieuPhanTram != null) {
      ctlBnnctbnpt.text = widget.baoNhieuNamCuoiTangBaoNhieuPhanTram.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _capNhatTtncBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Giá chào, giá chốt'),
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
                // body
                MyTopTitle(text: 'Giá chào'),
                MyCurrencyTextField(
                  ctl: ctlGiaChao,
                  onChanged: () {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Giá chốt'),
                MyCurrencyTextField(
                  ctl: ctlGiaChot,
                  onChanged: () {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Bao nhiêu năm đầu không tăng giá'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlBnndktg,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Bao nhiêu năm cuối tăng bao nhiêu %'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlBnnctbnpt,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // bottom
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
                  bloc: _capNhatTtncBloc,
                  listener: (context, state) {
                    if (state is UpdateSuccess) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Navigator.pop(context, _changed); // pop về dashboard
                      Dialogs.showUpdateSuccessToast();
                    }
                    if (state is UpdateFailure) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Dialogs.showFailureToast();
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
                          if (ctlGiaChao.text != '' &&
                              ctlGiaChot.text != '' &&
                              ctlBnndktg.text != '' &&
                              ctlBnnctbnpt.text != '') {
                            _changed = true;
                            _handleSubmit(context);
                            /*_capNhatTtncBloc
                                .add(UpdateThoiGianChoThueToiDa(id: widget.id, soNamThueToiDa: ctlSoNamThueToiDa.text));*/
                          } else {
                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Hãy nhập đầy đủ thông tin !'),
                                backgroundColor: Colors.red,
                              ),
                            );
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
}
