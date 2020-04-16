import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class HienTrangUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel hienTrang;
  final ThongTinLienHeModel nguoiThue;
  final List<MyRadioList> list;

  const HienTrangUpdatePage({Key key, @required this.id, @required this.hienTrang, this.nguoiThue, @required this.list}) : super(key: key);

  @override
  _HienTrangUpdatePageState createState() => _HienTrangUpdatePageState();
}

class _HienTrangUpdatePageState extends State<HienTrangUpdatePage> {
  var ctlSdtNguoiNhan = new MaskedTextController(mask: '0000000000');
  TextEditingController ctlTenNguoiNhan = TextEditingController();

  String radioValue;
  int radioGroup;

  CapNhatTtcbBloc _nhaChoThueDetailBloc;

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _nhaChoThueDetailBloc.add(UpdateHienTrang(
          id: widget.id, hienTrang: radioValue, sdt: ctlSdtNguoiNhan.text, ten: ctlTenNguoiNhan.text));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();

    radioValue = widget.hienTrang.value;
    radioGroup = widget.hienTrang.index;

    if(widget.hienTrang.value == 'DA_THUE'){
      ctlSdtNguoiNhan.text = widget.nguoiThue.phone;
      ctlTenNguoiNhan.text = widget.nguoiThue.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hiện trạng'),
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
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                MyTopTitle(text: 'Hiện trạng'), buildRow(), SizedBox(height: 20), //
                radioValue == 'DA_THUE'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                        ],
                      )
                    : SizedBox(), // bottom
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
                          if (ctlSdtNguoiNhan.text == '' && ctlTenNguoiNhan.text == '' && radioValue == 'DA_THUE') {
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

  Widget buildRow() {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widget.list
          .map(
            (data) => Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: radioGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          radioValue = data.value;
                          radioGroup = data.index;
                          _onChanged = true;
                        },
                      );
                      print(radioValue);
                    },
                  ),
                ),
                SizedBox(width: 7),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }
}
