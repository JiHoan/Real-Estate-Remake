import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/utils/my_dialog.dart';

import 'khach_lau_nam_tabview.dart';
import 'khach_moi_tabview.dart';

class KhachLauNamHayMoiNextPage extends StatefulWidget {
  final String moTa;
  final String sdt;
  final String ten;
  final String mucDich;
  final String thanhPho;
  final String quan;
  final String phuong;
  final String tenDuong;
  final String dienTich;
  final int soLau;
  final String lung;
  final String ham;
  final String sanThuong;
  final String sanThuongCaiTao;
  final int soPhong;
  final int soWCR;
  final int soWCC;
  final String banCong;
  final String cuaSo;
  final String thangBo;
  final int soThangThoatHiem;
  final int soThangMay;
  final String huongNha;
  final String giaMin;
  final String giaMax;
  final String thoiGianThue;

  const KhachLauNamHayMoiNextPage({Key key, this.giaMax, this.moTa, this.sdt, this.ten, this.mucDich, this.thanhPho, this.quan, this.phuong, this.tenDuong, this.dienTich, this.soLau, this.lung, this.ham, this.sanThuong, this.sanThuongCaiTao, this.soPhong, this.soWCR, this.soWCC, this.banCong, this.cuaSo, this.thangBo, this.soThangThoatHiem, this.soThangMay, this.huongNha, this.giaMin, this.thoiGianThue}) : super(key: key);

  @override
  _KhachLauNamHayMoiNextPageState createState() => _KhachLauNamHayMoiNextPageState();
}

class _KhachLauNamHayMoiNextPageState extends State<KhachLauNamHayMoiNextPage> {
  int currentSegment = 0;

  final tab = <int, Widget>{
    0: Text('Khách lâu năm'),
    1: Text('Khách mới'),
  };

  var view;

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    view = <int, Widget>{
      0: KhachLauNamTabView(
        moTa: widget.moTa,
        sdt: widget.sdt,
        ten: widget.ten,
        mucDich: widget.mucDich,
        thanhPho: widget.thanhPho,
        quan: widget.quan,
        phuong: widget.phuong,
        tenDuong: widget.tenDuong,
        dienTich: widget.dienTich,
        soLau: widget.soLau,
        lung: widget.lung,
        ham: widget.ham,
        sanThuong: widget.sanThuong,
        sanThuongCaiTao: widget.sanThuongCaiTao,
        soPhong: widget.soPhong,
        soWCR: widget.soWCR,
        soWCC: widget.soWCC,
        banCong: widget.banCong,
        cuaSo: widget.cuaSo,
        thangBo: widget.thangBo,
        soThangThoatHiem: widget.soThangThoatHiem,
        soThangMay: widget.soThangMay,
        huongNha: widget.huongNha,
        giaMin: widget.giaMin,
        giaMax: widget.giaMax,
        thoiGianThue: widget.thoiGianThue,
        currentSegment: 0,
      ),
      1: KhachMoiTabView(
        moTa: widget.moTa,
        sdt: widget.sdt,
        ten: widget.ten,
        mucDich: widget.mucDich,
        thanhPho: widget.thanhPho,
        quan: widget.quan,
        phuong: widget.phuong,
        tenDuong: widget.tenDuong,
        dienTich: widget.dienTich,
        soLau: widget.soLau,
        lung: widget.lung,
        ham: widget.ham,
        sanThuong: widget.sanThuong,
        sanThuongCaiTao: widget.sanThuongCaiTao,
        soPhong: widget.soPhong,
        soWCR: widget.soWCR,
        soWCC: widget.soWCC,
        banCong: widget.banCong,
        cuaSo: widget.cuaSo,
        thangBo: widget.thangBo,
        soThangThoatHiem: widget.soThangThoatHiem,
        soThangMay: widget.soThangMay,
        huongNha: widget.huongNha,
        giaMin: widget.giaMin,
        giaMax: widget.giaMax,
        thoiGianThue: widget.thoiGianThue,
        currentSegment: 1,
      ),
    };
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
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: (){
                Dialogs.showBackHomeDialog(context);
              },
              child: Container(
                child: Image.asset('assets/group.png'),
              ),
            ),
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
