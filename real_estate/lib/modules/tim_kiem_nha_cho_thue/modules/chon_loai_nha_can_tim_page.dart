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
      appBar: AppBar(
        title: Text('Chọn loại', style: MyAppStyle.appbar),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffF8A200)),
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
                    style: TextStyle(fontWeight: FontWeight.w500),
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
                    style: TextStyle(fontWeight: FontWeight.w500),
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
