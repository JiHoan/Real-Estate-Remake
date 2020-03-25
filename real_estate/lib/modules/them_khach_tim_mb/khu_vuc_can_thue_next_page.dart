import 'package:flutter/material.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';

import 'ket_cau_nha_can_thue_next_page.dart';

class KhuVucCanThueNextPage extends StatefulWidget {
  @override
  _KhuVucCanThueNextPageState createState() => _KhuVucCanThueNextPageState();
}

class _KhuVucCanThueNextPageState extends State<KhuVucCanThueNextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Khu vực cần thuê'),
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
                MyTopTitle(text: 'Chọn tỉnh/ thành phố'),
                MyDropBox(
                  list: ['Hồ Chí Minh', 'Đà Nẵng', 'Hà Nội', 'Vũng Tàu'],
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Chọn quận/ huyện'),
                MyDropBox(
                  list: ['Bình Thạnh', 'Gò Vấp', 'Tân Bình', '1', '2', '3'],
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Chọn phường/ xã/ thị trấn'),
                MyDropBox(
                  list: ['phường 5', 'phường 1', 'phường 10'],
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Tên đường'),
                MyInput(hintText: '', color: Color(0xffEBEBEB), lines: 1),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => KetCauNhaCanThueNextPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
