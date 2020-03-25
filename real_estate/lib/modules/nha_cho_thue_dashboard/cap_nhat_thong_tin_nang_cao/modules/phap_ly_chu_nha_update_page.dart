import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class PhapLyChuNhaUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel phapLy;

  const PhapLyChuNhaUpdatePage({Key key, this.id, this.phapLy}) : super(key: key);

  @override
  _PhapLyChuNhaUpdatePageState createState() => _PhapLyChuNhaUpdatePageState();
}

class _PhapLyChuNhaUpdatePageState extends State<PhapLyChuNhaUpdatePage> {
  String radioValue;
  int radioGroup;

  List<MyRadioList> radioList = [
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

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();

    if (widget.phapLy.value == 'KHONG_XAC_DINH') {
      radioGroup = 1;
      radioValue = radioList[0].value;
    } else {
      radioValue = widget.phapLy.value;
      radioGroup = widget.phapLy.index;
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
        title: Text('Pháp lý chủ nhà'),
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
                MyTopTitle(text: 'Pháp lý chủ nhà'), buildRow(), // bottom
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
                        _changed = true;
                        _capNhatTtncBloc.add(UpdatePhapLy(id: widget.id, phapLy: radioValue));
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildRow() {
    return Row(
      children: <Widget>[
        Wrap(
          spacing: 100,
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
