import 'package:flutter/material.dart';
import 'package:real_estate/my_application.dart';
import 'package:real_estate/modules/authentication/repository/authentication_repository.dart';
import 'modules/add_house_for_rent.dart';
import 'modules/district/district_page.dart';
import 'modules/home/home_page.dart';
import 'modules/kh_tim_mb_page.dart';
import 'modules/login/login_page.dart';
import 'modules/nha_cho_thue/nha_cho_thue_page.dart';
import 'modules/route/route_map_page.dart';
import 'modules/route/route_today_page.dart';
import 'modules/them_khach_tim_mb/them_khach_tim_mb_home.dart';
import 'modules/thong_tin_co_ban/modules/dia_chi/tinh_thanh_pho_search_page.dart';
import 'modules/nha_cho_thue_dashboard/nha_cho_thue_dashboard_page.dart';
import 'modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/modules/upload_hinh_anh_update_page.dart';

void main() => runApp(MyApplication(authenticationRepository: AuthenticationRepository()));

//void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'HelveticaNeue',
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Color(0xffF8A200)),
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 18.0,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      home: Home(),
    );
  }
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Đăng nhập'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            RaisedButton(
              child: Text('Trang chủ'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            RaisedButton(
              child: Text('Chọn quận'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DistrictPage()));
              },
            ),
            RaisedButton(
              child: Text('Thêm nhà cho thuê'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddHouseForRent()));
              },
            ),
            RaisedButton(
              child: Text('Nhà cho thuê'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NhaChoThuePage()));
              },
            ),
            RaisedButton(
              child: Text('Cập nhật thông tin nhà main'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NhaChoThueDashboardPage()));
              },
            ),
            RaisedButton(
              child: Text('Thêm khách tìm mặt bằng'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ThemKhachTimMbHomePage()));
              },
            ),
            RaisedButton(
              child: Text('Khách hàng tìm mặt bằng'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KhTimMbPage()));
              },
            ),
            RaisedButton(
              child: Text('Upload hình ảnh'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UploadHinhAnhUpdatePage()));
              },
            ),
            RaisedButton(
              child: Text('Tìm kiếm chi tiết'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TimTinhTpPage()));
              },
            ),
            RaisedButton(
              child: Text('Lộ trình hôm nay'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RouteTodayPage()));
              },
            ),
            RaisedButton(
              child: Text('Lộ trình map'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RouteMapPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
