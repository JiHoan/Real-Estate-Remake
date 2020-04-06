import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/utils/my_dialog.dart';

import 'khach_lau_nam_tabview.dart';
import 'khach_moi_tabview.dart';

class KhachLauNamHayMoiUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel khachLauNam;
  final CommonModel loaiHinh;

  const KhachLauNamHayMoiUpdatePage({Key key, @required this.id, @required this.khachLauNam, @required this.loaiHinh})
      : super(key: key);

  @override
  _KhachLauNamHayMoiUpdatePageState createState() => _KhachLauNamHayMoiUpdatePageState();
}

class _KhachLauNamHayMoiUpdatePageState extends State<KhachLauNamHayMoiUpdatePage> {
  int currentSegment;
  int tabChange;

  var view;
  final tab = <int, Widget>{
    0: Text('Khách lâu năm'),
    1: Text('Khách mới'),
  };

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
    });
  }

  KhachTimMbBloc _khachTimMbBloc;

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();

    if(widget.khachLauNam.value == 'CO'){
      currentSegment = 0;
      tabChange = 0;
    } else {
      currentSegment = 1;
      tabChange = 1;
    }

    view = <int, Widget>{
      0: KhachLauNamTabView(id: widget.id, khachTimMbBloc: _khachTimMbBloc, loaiHinh: widget.loaiHinh, tabChange: tabChange),
      1: KhachMoiTabView(id: widget.id, khachTimMbBloc: _khachTimMbBloc, loaiHinh: widget.loaiHinh, tabChange: tabChange),
    };
  }

  @override
  void dispose() {
    super.dispose();
    _khachTimMbBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Khách lâu năm hay khách mới'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Image.asset('assets/group.png'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: CupertinoSegmentedControl<int>(
              children: tab,
              borderColor: Color(0xff3FBF55),
              selectedColor: Color(0xff3FBF55),
              onValueChanged: onValueChanged,
              groupValue: currentSegment,
            ),
          ),
          Expanded(
            child: Container(
              child: view[currentSegment],
            ),
          ),
        ],
      ),
    );
  }
}
