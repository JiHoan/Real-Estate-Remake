import 'package:flutter/material.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/thong_tin_lien_he/thong_tin_lien_he_next_page.dart';
import 'package:real_estate/utils/style.dart';

import 'tinh_trang_next_page.dart';

class ThemKhachTimMbHomePage extends StatefulWidget {
  @override
  _ThemKhachTimMbHomePageState createState() => _ThemKhachTimMbHomePageState();
}

class _ThemKhachTimMbHomePageState extends State<ThemKhachTimMbHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: const Color(0xffE9E9E9),
                  height: 170,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Image.asset(
                    'assets/no-image.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Color(0xffF8A200),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text('Khách tìm mặt bằng'.toUpperCase(), style: TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xffE9E9E9),
                        ),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  bottom: 15,
                  child: Material(
                    color: Color(0xff41BC00),
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        child: Image.asset('assets/camera.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                children: <Widget>[
                  // thong tin co ban
                  Text('Nhu cầu khách tìm mặt bằng'.toUpperCase(), style: MyAppStyle.price),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TinhTrangNextPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Tình trạng: ',
                                style: TextStyle(
                                    color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Cần gấp',
                                    style: TextStyle(
                                      color: Color(0xffA00000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildItemRow(
                    'Thông tin liên hệ',
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinLienHeNextPage()));
                    },
                  ),
                  _buildItemRow('Mục đích thuê', () {}),
                  _buildItemRow('Khu vực cần thuê', () {}),
                  _buildItemRow('Kết cấu nhà cần thuê', () {}),
                  _buildItemRow('Giá cần thuê', () {}),
                  _buildItemRow('Thời gian thuê', () {}),
                  _buildItemRow('Khách lâu năm hay khách mới', () {}),
                  _buildItemRow('Loại khách hàng', () {}),
                  _buildItemRow('Mô tả khác', () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(String text, Function onTap) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                style: MyAppStyle.text,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
