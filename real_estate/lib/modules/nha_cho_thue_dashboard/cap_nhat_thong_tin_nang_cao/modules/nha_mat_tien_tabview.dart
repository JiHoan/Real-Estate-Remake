import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import '../../cap_nhat_thong_tin_co_ban/model/common_model.dart';
import '../bloc/cap_nhat_ttnc.dart';

class NhaMatTienTabView extends StatefulWidget {
  final int id;
  final CommonModel matTien;
  final double leDuong;
  final CommonModel duongMotChieu;

  const NhaMatTienTabView(
      {Key key, @required this.id, @required this.matTien, @required this.leDuong, @required this.duongMotChieu})
      : super(key: key);

  @override
  _NhaMatTienTabViewState createState() => _NhaMatTienTabViewState();
}

class _NhaMatTienTabViewState extends State<NhaMatTienTabView> {
  TextEditingController ctlLeDuong = TextEditingController();

  String radioValue;
  int radioGroup;

  List<MyRadioList> radioList = [
    MyRadioList(
      index: 1,
      title: 'Đường 1 chiều',
      value: 'DUONG_1_CHIEU',
    ),
    MyRadioList(
      index: 2,
      title: 'Đường 2 chiều',
      value: 'DUONG_2_CHIEU',
    ),
  ];

  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(UpdateMatTien(id: widget.id, leDuong: double.tryParse(ctlLeDuong.text), duongMotChieu: radioValue));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();

    if (widget.duongMotChieu.value == 'KHONG_XAC_DINH' || widget.matTien.value != 'NHA_MAT_TIEN') {
      radioGroup = 1;
      radioValue = radioList[0].value;
    } else {
      radioGroup = widget.duongMotChieu.index;
      radioValue = widget.duongMotChieu.value;

      ctlLeDuong.text = widget.leDuong.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _capNhatTtncBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: <Widget>[
              MyTopTitle(text: 'Lề đường bao nhiêu mét?'),
              MyInput(
                hintText: '',
                color: Color(0xffEBEBEB),
                lines: 1,
                type: TextInputType.number,
                controller: ctlLeDuong,
                onChanged: (value){
                  setState(() {
                    _onChanged = true;
                  });
                },
              ),
              SizedBox(height: 20),
              MyTopTitle(text: 'Đường trước nhà'),
              buildRow(),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: MyButton(
                    color: Color(0xff3FBF55),
                    text: Text(
                      'Lưu',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    event: () {
                      if (ctlLeDuong.text != '') {
                        _changed = true;
                        _handleSubmit(context);
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
      ],
    );
  }

  Widget buildRow() {
    return Row(
      children: <Widget>[
        Wrap(
          spacing: 60,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: radioList
              .map(
                (data) => Wrap(
                  spacing: 7,
                  crossAxisAlignment: WrapCrossAlignment.center,
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
                        },
                      ),
                    ),
                    Text(data.title),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
