import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'mo_ta_khac_next_page.dart';

class LoaiKhachNextPage extends StatefulWidget {
  @override
  _LoaiKhachNextPageState createState() => _LoaiKhachNextPageState();
}

class _LoaiKhachNextPageState extends State<LoaiKhachNextPage> {
  String rdLoaiKhachValue;
  int rdLoaiKhacGroup = 0;

  List<MyRadioList> rdLoaiKhacList = [
    MyRadioList(
      index: 0,
      title: 'Công ty',
      value: 'CONG_TY',
    ),
    MyRadioList(
      index: 1,
      title: 'Cá nhân',
      value: 'CA_NHAN',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Loại khách'),
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
                MyTopTitle(text: 'Loại khách hàng'),
                buildRowNguoiChoThue(),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Tên thương hiệu'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                ),
                // bottom
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
              event: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MoTaKhacNextPage()));
              },
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
      children: rdLoaiKhacList
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
                  groupValue: rdLoaiKhacGroup,
                  value: data.index,
                  activeColor: Color(0xff3FBF55),
                  onChanged: (val) {
                    setState(
                          () {
                        rdLoaiKhachValue = data.value;
                        rdLoaiKhacGroup = data.index;
                      },
                    );
                    print(rdLoaiKhachValue);
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
