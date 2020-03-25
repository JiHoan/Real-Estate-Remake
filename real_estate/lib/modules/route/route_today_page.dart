import 'package:flutter/material.dart';
import 'package:real_estate/utils/style.dart';

class RouteTodayPage extends StatefulWidget {
  @override
  _RouteTodayPageState createState() => _RouteTodayPageState();
}

class _RouteTodayPageState extends State<RouteTodayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Lộ trình hôm nay'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Xóa hết'),
          ),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                return _buildItemRoute();
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Material _buildItemRoute() {
    return Material(
      color: Color(0xffEDEDED),
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '54A Trần Bình Trọng, p5, Bình Thạnh',
                          style: TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '(4 x 18 ) 2 lầu ,2p ,2wc  2 lầu ,2p ,2wc',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      Text(
                        'Note: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          'chưa bắt máy 13/12',
                          style: TextStyle(color: Color(0xff259B39)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    '21.000.000 vnd',
                    style: MyAppStyle.price,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Image.asset('assets/close.png'),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Text('22/3/2020'),
            ),

          ],
        ),
      ),
    );
  }
}
