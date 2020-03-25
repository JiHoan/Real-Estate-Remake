import 'package:flutter/material.dart';
import 'package:real_estate/utils/style.dart';

class LandSpaceAllPage extends StatefulWidget {
  @override
  _LandSpaceAllPageState createState() => _LandSpaceAllPageState();
}

class _LandSpaceAllPageState extends State<LandSpaceAllPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (context, index) {
            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffF8A200),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset('assets/fire.png'),
                          SizedBox(width: 7),
                          Text('Chuỗi Tous Les Jours', style: MyAppStyle.title),
                        ],
                      ),
                      Text('Quận 1, quận 2, quận 7', style: MyAppStyle.desc),
                      Text('20.000\$', style: MyAppStyle.price),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
