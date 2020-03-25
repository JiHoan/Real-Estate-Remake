import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class NhaHemTabView extends StatefulWidget {
  final int id;
  final int soXet;
  final CommonModel kichThuocHem;
  final CommonModel loaiHem;
  final double hemBaoNhieuMet;
  final CommonModel matTien;

  const NhaHemTabView(
      {Key key,
      @required this.id,
      @required this.soXet,
      @required this.kichThuocHem,
      @required this.loaiHem,
      @required this.hemBaoNhieuMet,
      @required this.matTien})
      : super(key: key);

  @override
  _NhaHemTabViewState createState() => _NhaHemTabViewState();
}

class _NhaHemTabViewState extends State<NhaHemTabView> {
  String radioValue1;
  int radioGroup1;

  String radioValue2;
  int radioGroup2;

  List<MyRadioList> radioList1 = [
    MyRadioList(
      index: 1,
      title: 'Hẻm nhỏ',
      value: 'HEM_NHO',
    ),
    MyRadioList(
      index: 2,
      title: 'Hẻm xe hơi',
      value: 'HEM_XE_HOI',
    ),
    MyRadioList(
      index: 3,
      title: 'Hẻm xe tải',
      value: 'HEM_XE_TAI',
    ),
  ];

  List<MyRadioList> radioList2 = [
    MyRadioList(
      index: 1,
      title: 'Hẻm thông',
      value: 'HEM_THONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Hẻm cụt',
      value: 'HEM_CUT',
    ),
  ];

  List<SoXet> listSoXet = [
    SoXet(
      index: 1,
      title: '1 xẹt',
      value: 1,
    ),
    SoXet(
      index: 2,
      title: '2 xẹt',
      value: 2,
    ),
    SoXet(
      index: 3,
      title: '3 xẹt',
      value: 3,
    ),
  ];

  String _soXetSelection;

  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  TextEditingController ctlHemBaoNhieuMet = TextEditingController();

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();
    print(widget.soXet.toString());

    if (widget.matTien.value != 'NHA_HEM') {
      radioGroup1 = 1;
      radioValue1 = radioList1[0].value;
      radioGroup2 = 1;
      radioValue2 = radioList1[0].value;

//      _soXetSelection = listSoXet[1].value.toString();
    } else {
      radioGroup1 = widget.kichThuocHem.index;
      radioValue1 = widget.kichThuocHem.value;
      radioGroup2 = widget.loaiHem.index;
      radioValue2 = widget.loaiHem.value;
      _soXetSelection = widget.soXet.toString();
      ctlHemBaoNhieuMet.text = widget.hemBaoNhieuMet.toString();
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
              MyTopTitle(text: 'Hẻm mấy xẹt?'),
              /*MyDropBox(
                list: ['1 xẹt', '2 xẹt', '3 xẹt'],
              ),*/
              buildSoXet(),
              SizedBox(height: 20),
              MyTopTitle(text: 'Loại 1'),
              buildRow1(),
              SizedBox(height: 20),
              MyTopTitle(text: 'Loại 2'),
              buildRow2(),
              SizedBox(height: 20),
              MyTopTitle(text: 'Hẻm bao nhiêu mét?'),
              MyInput(
                hintText: '',
                color: Color(0xffEBEBEB),
                lines: 1,
                controller: ctlHemBaoNhieuMet,
                type: TextInputType.number,
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
                    Navigator.pop(context, _changed);
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
                      if (ctlHemBaoNhieuMet.text != '') {
                        _changed = true;
                        _capNhatTtncBloc.add(
                          UpdateHem(
                            id: widget.id,
                            baoNhieuMet: double.tryParse(ctlHemBaoNhieuMet.text),
                            kichThuocHem: radioValue1,
                            loaiHem: radioValue2,
                            soXet: int.parse(_soXetSelection),
                          ),
                        );
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

  Container buildSoXet() {
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
            _soXetSelection = newVal;

            _onChanged = true;
          });
        },
        value: _soXetSelection,
        items: listSoXet.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value.toString(),
          );
        }).toList(),
      ),
    );
  }

  Widget buildRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: radioList1
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: radioGroup1,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          radioValue1 = data.value;
                          radioGroup1 = data.index;
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
    );
  }

  Widget buildRow2() {
    return Row(
      children: <Widget>[
        Wrap(
          spacing: 33,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: radioList2
              .map(
                (data) => Wrap(
                  spacing: 7,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Radio(
                        groupValue: radioGroup2,
                        value: data.index,
                        activeColor: Color(0xff3FBF55),
                        onChanged: (val) {
                          setState(
                            () {
                              radioValue2 = data.value;
                              radioGroup2 = data.index;
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

class SoXet {
  final index;
  final title;
  final value;

  SoXet({this.index, this.title, this.value});
}
