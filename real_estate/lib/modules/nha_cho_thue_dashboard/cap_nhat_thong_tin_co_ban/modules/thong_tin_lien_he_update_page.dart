import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/modules/kiem_tra_lien_lac_page.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class ThongTinLienHeUpdatePage extends StatefulWidget {
  final ThongTinLienHeModel thongTinLienHe;
  final int id;

  const ThongTinLienHeUpdatePage({Key key, @required this.id,  @required  this.thongTinLienHe})
      : super(key: key);

  @override
  _ThongTinLienHeUpdatePageState createState() => _ThongTinLienHeUpdatePageState();
}

class _ThongTinLienHeUpdatePageState extends State<ThongTinLienHeUpdatePage> {
  CapNhatTtcbBloc _nhaChoThueDetailBloc;

  var ctlSdtNguoiNhan = new MaskedTextController(mask: '0000000000');
  TextEditingController ctlTenNguoiNhan = TextEditingController();

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      ThongTinLienHeModel _model = ThongTinLienHeModel(name: ctlTenNguoiNhan.text, phone: ctlSdtNguoiNhan.text);
      _nhaChoThueDetailBloc.add(UpdateThongTinLienHe(model: _model, id: widget.id));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();

    ctlSdtNguoiNhan.text = widget.thongTinLienHe.phone;
    ctlTenNguoiNhan.text = widget.thongTinLienHe.name;
  }

  @override
  void dispose() {
    super.dispose();
    _nhaChoThueDetailBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thông tin liên hệ'),
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
                MyTopTitle(text: 'Số điện thoại'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlSdtNguoiNhan,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Người nhận'),
                Container(
                  height: 45,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(color: Colors.black87),
                    controller: ctlTenNguoiNhan,
                    onChanged: (value) {
                      setState(() {
                        _onChanged = true;
                      });
                    },
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
                // bottom
              ],
            ),
          ),
          _onChanged == false
              ? MyButtonDisable()
              : BlocListener(
            bloc: _nhaChoThueDetailBloc,
            listener: (context, state) {
              print(state);
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
              builder: (context) =>
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: MyButton(
                      color: Color(0xff3FBF55),
                      text: Text(
                        'Lưu',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      event: () {
                        if (ctlSdtNguoiNhan.text == '' || ctlTenNguoiNhan.text == '') {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Hãy nhập đầy đủ thông tin !'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          _changed = true;
                          _handleSubmit(context);
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
