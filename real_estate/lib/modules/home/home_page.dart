import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:real_estate/modules/authentication/bloc/authentication.dart';
import 'package:real_estate/modules/home/bloc/home.dart';
import 'package:real_estate/modules/nha_cho_thue/nha_cho_thue_page.dart';
import 'package:real_estate/modules/search/search_page.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/thong_tin_lien_he/thong_tin_lien_he_next_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationBloc _authenticationBloc;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _homeBloc = HomeBloc();
    _homeBloc.add(HomeStart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/shield.png'),
                  SizedBox(width: 5),
                  Expanded(
                    child: BlocBuilder(
                      bloc: _homeBloc,
                      builder: (BuildContext context, HomeState state){
                        if(state is HomeSuccess){
                          return Text(
                            state.userModel.username,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xffF8A200),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _authenticationBloc.add(LoggedOut());
                    },
                    child: Text(
                      'Đăng xuất',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xffF8A200),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Tìm kiếm',
                          style: TextStyle(color: Color(0xff6C6C6C)),
                        ),
                        Spacer(),
                        Image.asset('assets/search.png'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  buildItem('Nhà cho thuê', 'assets/home.png', (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NhaChoThuePage()));
                  }),
                  SizedBox(width: 10),
                  buildItem('Thêm nhà cho thuê', 'assets/add1.png', (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinLienHeNextPage(type: 'NHA_CHO_THUE',)));
                  },),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  buildItem('Khách tìm MB', 'assets/map.png', (){}),
                  SizedBox(width: 10),
                  buildItem('Thêm khách tìm MB', 'assets/add.png', (){}),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  buildItem('Lên lộ trình', 'assets/action.png', (){}),
                  SizedBox(width: 10),
                  buildItem('Hệ thống', 'assets/settings.png', (){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildItem(String text, String imgUrl, Function onTap) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(imgUrl),
                SizedBox(height: 8),
                Text(
                  text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}