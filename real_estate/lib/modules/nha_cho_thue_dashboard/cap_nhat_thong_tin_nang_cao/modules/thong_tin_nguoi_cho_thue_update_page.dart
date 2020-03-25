import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class ThongTinNguoiChoThueUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel chuNhaChoThue;
  final int phiMoiGioi;
  final CommonModel nhaTheChap;

  const ThongTinNguoiChoThueUpdatePage(
      {Key key, @required this.id, @required this.chuNhaChoThue, @required this.phiMoiGioi, @required this.nhaTheChap})
      : super(key: key);

  @override
  _ThongTinNguoiChoThueUpdatePageState createState() => _ThongTinNguoiChoThueUpdatePageState();
}

class _ThongTinNguoiChoThueUpdatePageState extends State<ThongTinNguoiChoThueUpdatePage> {
  String rdNguoiChoThueValue;
  int rdNguoiChoThueGroup;
  String rdTheChapValue;
  int rdTheChapGroup;

  List<MyRadioList> rdNguoiChoThueList = [
    MyRadioList(
      index: 1,
      title: 'Chủ nhà',
      value: 'CHU_NHA',
    ),
    MyRadioList(
      index: 2,
      title: 'Môi giới',
      value: 'MOI_GIOI',
    ),
  ];

  List<MyRadioList> rdTheChapList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
  ];

  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  TextEditingController ctlPhiMoiGioi = TextEditingController();

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();

    ctlPhiMoiGioi.text = widget.phiMoiGioi.toString();

    if (widget.chuNhaChoThue.value == 'KHONG_XAC_DINH') {
      rdNguoiChoThueGroup = 1;
      rdNguoiChoThueValue = rdNguoiChoThueList[0].value;
    } else {
      rdNguoiChoThueGroup = widget.chuNhaChoThue.index;
      rdNguoiChoThueValue = widget.chuNhaChoThue.value;
    }

    if (widget.nhaTheChap.value == 'KHONG_XAC_DINH') {
      rdTheChapGroup = 1;
      rdTheChapValue = rdNguoiChoThueList[0].value;
    } else {
      rdTheChapGroup = widget.nhaTheChap.index;
      rdTheChapValue = widget.nhaTheChap.value;
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
        title: Text('Thông tin người cho thuê'),
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
                // body
                MyTopTitle(text: 'Người cho thuê là?'),
                buildRowNguoiChoThue(),
                const SizedBox(height: 20),
                rdNguoiChoThueValue == 'CHU_NHA' ? SizedBox() : MyTopTitle(text: 'Phí môi giới'),
                rdNguoiChoThueValue == 'CHU_NHA'
                    ? SizedBox()
                    : MyInput(
                        hintText: '',
                        color: Color(0xffEBEBEB),
                        lines: 1,
                        controller: ctlPhiMoiGioi,
                        type: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _onChanged = true;
                          });
                        },
                      ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Nhà có đang thế chấp hay không?'),
                buildRowTheChap(),
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
                          if (ctlPhiMoiGioi.text != '') {
                            _changed = true;
                            if(rdNguoiChoThueValue == 'CHU_NHA'){
                              _capNhatTtncBloc.add(UpdateThongTinNguoiChoThue(
                                  id: widget.id,
                                  nguoiChoThue: rdNguoiChoThueValue,
                                  phiMoiGioi: 0,
                                  nhaTheChap: rdTheChapValue));
                            } else{
                              _capNhatTtncBloc.add(UpdateThongTinNguoiChoThue(
                                  id: widget.id,
                                  nguoiChoThue: rdNguoiChoThueValue,
                                  phiMoiGioi: int.tryParse(ctlPhiMoiGioi.text),
                                  nhaTheChap: rdTheChapValue));
                            }
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

  Wrap buildRowNguoiChoThue() {
    return Wrap(
      spacing: 80,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdNguoiChoThueList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
              ),
              child: Wrap(
                spacing: 7,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Radio(
                      groupValue: rdNguoiChoThueGroup,
                      value: data.index,
                      activeColor: Color(0xff3FBF55),
                      onChanged: (val) {
                        setState(
                          () {
                            rdNguoiChoThueValue = data.value;
                            rdNguoiChoThueGroup = data.index;
                            _onChanged = true;
                          },
                        );
                        print(rdNguoiChoThueValue);
                      },
                    ),
                  ),
                  Text(data.title),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Wrap buildRowTheChap() {
    return Wrap(
      spacing: 80,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdTheChapList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
              ),
              child: Wrap(
                spacing: 7,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Radio(
                      groupValue: rdTheChapGroup,
                      value: data.index,
                      activeColor: Color(0xff3FBF55),
                      onChanged: (val) {
                        setState(
                          () {
                            rdTheChapValue = data.value;
                            rdTheChapGroup = data.index;
                            _onChanged = true;
                          },
                        );
                        print(rdTheChapValue);
                      },
                    ),
                  ),
                  Text(data.title),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
