import 'package:flutter/material.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'loai_khach_next_page.dart';


class KhachMoiTabView extends StatefulWidget {
  @override
  _KhachMoiTabViewState createState() => _KhachMoiTabViewState();
}

class _KhachMoiTabViewState extends State<KhachMoiTabView> {
  String radioValue;
  int radioGroup = 2;

  List<MyRadioList> radioList = [
    MyRadioList(
      index: 1,
      title: 'Đổi vị trí KD',
      value: 'DOI_VI_TRI_KINH_DOANH',
    ),
    MyRadioList(
      index: 2,
      title: 'Mở cửa hàng/ MB mới',
      value: 'MOI_CUA_HANG_MB_MOI',
    ),
  ];

  @override
  void initState() {
    super.initState();
    radioValue = radioList[1].value;
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
              MyTopTitle(text: 'Loại hình'),
              buildRow(),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: MyRowButton(
            text: Text(
              'Lưu & Tiếp tục',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            event: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoaiKhachNextPage()));
            },
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
                      /*setState(
                            () {
                          radioValue = data.value;
                          radioGroup = data.index;
                        },
                      );*/
                      print(radioValue);
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
