import 'package:flutter/material.dart';
import 'package:real_estate/utils/style.dart';

class DistrictPage extends StatefulWidget {
  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn quận', style: MyAppStyle.appbar),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffF8A200)),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 8,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: Color(0xffEBEBEB),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Quận 1 - ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '72',
                        style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xffF8A200)),
                      ),
                      Spacer(),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.lightGreen,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
