import 'package:flutter/material.dart';
import 'package:real_estate/utils/style.dart';

class KhTimMbPage extends StatefulWidget {
  @override
  _KhTimMbPageState createState() => _KhTimMbPageState();
}

class _KhTimMbPageState extends State<KhTimMbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Khách hàng tìm mặt bằng'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, bottom: 15),
            child: Row(
              children: <Widget>[
                Text('Kết quả: 72'),
                Spacer(),
                Text('Tất cả'),
                SizedBox(width: 5),
                Image.asset('assets/filter.png'),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 4,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      Material(
                        color: Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(7),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Chuỗi Tous Les Jours', style: TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 4),
                                Text('Quận 1, quận 2, quận 7'),
                                SizedBox(height: 4),
                                Text('21.000\$', style: MyAppStyle.price),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('22/3/2020'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Image.asset('assets/star (2).png'),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
