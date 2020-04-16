import 'package:flutter/material.dart';
import 'package:real_estate/utils/style.dart';

import 'tim_nha_cho_thue_page.dart';

class ChonLoaiNhaCanTimPage extends StatefulWidget {
  @override
  _ChonLoaiNhaCanTimPageState createState() => _ChonLoaiNhaCanTimPageState();
}

class _ChonLoaiNhaCanTimPageState extends State<ChonLoaiNhaCanTimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chọn loại'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          children: <Widget>[
            Material(
              color: Color(0xffEBEBEB),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TimNhaChoThuePage()));
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tìm nhà cho thuê',
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Material(
              color: Color(0xffEBEBEB),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tìm khách cần tìm mặt bằng',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
