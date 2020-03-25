import 'package:flutter/material.dart';
import 'package:real_estate/utils/style.dart';

import 'land_space_all_page.dart';

class LandSpaceHomePage extends StatefulWidget {
  @override
  _LandSpaceHomePageState createState() => _LandSpaceHomePageState();
}

class _LandSpaceHomePageState extends State<LandSpaceHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text('Khách hàng tìm mặt bằng', style: MyAppStyle.appbar),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xffF8A200),
                  ),
                  onPressed: () {},
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: new Size(100.0, 50.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  isScrollable: false,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 18.0),
                  indicatorColor: Color(0xffF8A200),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(text: 'Tất cả'),
                    Tab(text: 'Cần gấp'),
                    Tab(text: 'Đã thuê'),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xffF8A200),
            onPressed: () {},
          ),
          body: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                LandSpaceAllPage(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
