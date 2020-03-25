import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'khach_lau_nam_tabview.dart';
import 'khach_moi_tabview.dart';

class KhachLauNamHayMoiNextPage extends StatefulWidget {
  @override
  _KhachLauNamHayMoiNextPageState createState() => _KhachLauNamHayMoiNextPageState();
}

class _KhachLauNamHayMoiNextPageState extends State<KhachLauNamHayMoiNextPage> {
  int currentSegment = 0;

  final tab = <int, Widget>{
    0: Text('Khách lâu năm'),
    1: Text('Khách mới'),
  };

  final view = <int, Widget>{
    0: KhachLauNamTabView(),
    1: KhachMoiTabView(),
  };

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
    });
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
