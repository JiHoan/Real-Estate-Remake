import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class HienTrangUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel hienTrang;
  final String sdt;
  final String ten;
  final List<MyRadioList> list;

  const HienTrangUpdatePage({Key key, @required this.id, @required this.hienTrang, this.sdt, this.ten, @required this.list}) : super(key: key);

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

  /*List<MyRadioList> radioList = [
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
  ];*/

  @override
  void initState() {
    super.initState();
    print(widget.hienTrang.value);
    print(widget.list);

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();

    radioValue = widget.hienTrang.value;
    radioGroup = widget.hienTrang.index;

    if (widget.sdt != null && widget.ten != null) {
      ctlSdtNguoiNhan.text = widget.sdt;
      ctlTenNguoiNhan.text = widget.ten;
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
                          MyInput(
                            hintText: '',
                            color: Color(0xffEBEBEB),
                            lines: 1,
                            controller: ctlTenNguoiNhan,
                            onChanged: (value) {
                              setState(() {
                                _onChanged = true;
                              });
                            },
                          ),
                        ],
                      )
                    : SizedBox(), // bottom
              ],
            ),
          ),
          (_onChanged == false)
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
                    print(state);
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

                            _nhaChoThueDetailBloc.add(UpdateHienTrang(
                                id: widget.id, hienTrang: radioValue, sdt: ctlSdtNguoiNhan.text, ten: ctlTenNguoiNhan.text));
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
