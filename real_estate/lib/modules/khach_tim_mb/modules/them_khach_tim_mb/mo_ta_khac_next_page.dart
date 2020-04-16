import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class MoTaKhacNextPage extends StatefulWidget {
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
  final String loaiHinh;
  final String loaiKhach;
  final String tenThuongHieu;
  final int currentSegment;

  const MoTaKhacNextPage({Key key, this.giaMax, this.moTa, this.sdt, this.ten, this.mucDich, this.thanhPho, this.quan, this.phuong, this.tenDuong, this.dienTich, this.soLau, this.lung, this.ham, this.sanThuong, this.sanThuongCaiTao, this.soPhong, this.soWCR, this.soWCC, this.banCong, this.cuaSo, this.thangBo, this.soThangThoatHiem, this.soThangMay, this.huongNha, this.giaMin, this.thoiGianThue, this.loaiHinh, this.loaiKhach, this.tenThuongHieu, this.currentSegment}) : super(key: key);
  @override
  _MoTaKhacNextPageState createState() => _MoTaKhacNextPageState();
}

class _MoTaKhacNextPageState extends State<MoTaKhacNextPage> {
  TextEditingController ctlMoTaKhac = TextEditingController();
  KhachTimMbBloc _khachTimMbBloc;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      KhachTimMbModel _model = KhachTimMbModel(
        moTa: widget.moTa,
        sdt: widget.sdt,
        nguoiNhan: widget.ten,
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
        giaMin: int.tryParse(widget.giaMin) ?? 0,
        giaMax: int.tryParse(widget.giaMax) ?? 0,
        thoiGianThue: int.tryParse(widget.thoiGianThue) ?? 0,
        loaiHinh: widget.loaiHinh,
        khachLauNam: widget.currentSegment == 0 ? 'CO' : 'KHONG',
        loaiKhach: widget.loaiKhach,
        tenThuongHieu: widget.tenThuongHieu,
        moTaKhac: ctlMoTaKhac.text,
      );
      _khachTimMbBloc.add(ThemKhachTimMb(model: _model));
    } catch (error, s) {
      print(error);
      print(s);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
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
        title: Text('Mô tả khác'),
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
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                MyTopTitle(text: 'Mô tả khác'),
                Container(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black87),
                    maxLines: 3,
                    controller: ctlMoTaKhac,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      filled: true,
                      fillColor: Color(0xffEBEBEB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // bottom
              ],
            ),
          ),
          BlocListener(
            bloc: _khachTimMbBloc,
            listener: (context, state){
              if(state is KhachTimMbSuccess){
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Dialogs.showAddSuccessToast();
              }
              if(state is KhachTimMbFailure){
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                Dialogs.showFailureToast();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: MyButton(
                color: Color(0xff3FBF55),
                text: Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: (){
                  _handleSubmit(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
