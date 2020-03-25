import 'package:flutter/material.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';

import 'khu_vuc_can_thue_next_page.dart';

class MucDichThueNextPage extends StatefulWidget {
  @override
  _MucDichThueNextPageState createState() => _MucDichThueNextPageState();
}

class _MucDichThueNextPageState extends State<MucDichThueNextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mục đích thuê'),
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
                MyTopTitle(text: 'Mục đích thuê nhà'),
                MyInput(hintText: '', color: Color(0xffEBEBEB), lines: 3),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => KhuVucCanThueNextPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
