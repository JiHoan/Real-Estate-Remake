import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';

import 'nha_hem_tabview.dart';
import 'nha_mat_tien_tabview.dart';

class HemHayMatTienUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel matTien;
  final double leDuong;
  final CommonModel duongMotChieu;

  final int soXet;
  final CommonModel kichThuocHem;
  final CommonModel loaiHem;
  final double hemBaoNhieuMet;

  final int type;

  const HemHayMatTienUpdatePage({
    Key key,
    @required this.id,
    @required this.matTien,
    @required this.leDuong,
    @required this.duongMotChieu,
    @required this.soXet,
    @required this.kichThuocHem,
    @required this.loaiHem,
    @required this.hemBaoNhieuMet,
    @required this.type,
  }) : super(key: key);

  @override
  _HemHayMatTienUpdatePageState createState() => _HemHayMatTienUpdatePageState();
}

class _HemHayMatTienUpdatePageState extends State<HemHayMatTienUpdatePage> {
  int currentSegment;

  final tab = <int, Widget>{
    0: Text('Nhà mặt tiền'),
    1: Text('Nhà hẻm'),
  };

  Map<int, Widget> view;

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
    });
  }

  @override
  void initState() {
    super.initState();

    currentSegment = widget.type;

    view = <int, Widget>{
      0: NhaMatTienTabView(
        id: widget.id,
        leDuong: widget.leDuong,
        duongMotChieu: widget.duongMotChieu,
        matTien: widget.matTien,
      ),
      1: NhaHemTabView(
        id: widget.id,
        soXet: widget.soXet,
        kichThuocHem: widget.kichThuocHem,
        loaiHem: widget.loaiHem,
        hemBaoNhieuMet: widget.hemBaoNhieuMet,
        matTien: widget.matTien,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nhà hẻm hay mặt tiền'),
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
