import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/modules/thong_tin_co_ban/bloc/thong_tin_co_ban.dart';
import 'package:real_estate/modules/thong_tin_co_ban/model/thong_tin_co_ban_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class VATNextPage extends StatefulWidget {
  final String sdtNguoiNhan;
  final String tenNguoiNhan;
  final String tinhTpId;
  final String quanHuyenId;
  final String phuongXaId;
  final String soNha;
  final String tenDuong;
  final double ngang;
  final double dai;
  final int floorNumber;
  final String basement;
  final String terrace;
  final String terraceUpgrated;
  final int mezzanine;
  final String balcony;
  final String window;
  final int roomNumber;
  final int wcrNumber;
  final int wccNumber;

  const VATNextPage({
    Key key,
    @required this.sdtNguoiNhan,
    @required this.tenNguoiNhan,
    @required this.tinhTpId,
    @required this.quanHuyenId,
    @required this.phuongXaId,
    @required this.soNha,
    @required this.tenDuong,
    @required this.ngang,
    @required this.dai,
    @required this.floorNumber,
    @required this.basement,
    @required this.terrace,
    @required this.terraceUpgrated,
    @required this.mezzanine,
    @required this.balcony,
    @required this.window,
    @required this.roomNumber,
    @required this.wcrNumber,
    @required this.wccNumber,
  }) : super(key: key);

  @override
  _VATNextPageState createState() => _VATNextPageState();
}

class _VATNextPageState extends State<VATNextPage> {
  var ctlGia = new MaskedTextController(mask: '000000000000');
  var ctlVAT = new MaskedTextController(mask: '000000000000');
  var ctlHoaHong = new MaskedTextController(mask: '000000000000');

  ThongTinCoBanBloc _thongTinCoBanBloc;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      ThongTinCoBanModel _thongTinCoBanModel = ThongTinCoBanModel(
        sdtNguoiNhan: widget.sdtNguoiNhan,
        tenNguoiNhan: widget.tenNguoiNhan,
        tinhTpId: widget.tinhTpId,
        quanHuyenId: widget.quanHuyenId,
        phuongXaId: widget.phuongXaId,
        soNha: widget.soNha,
        tenDuong: widget.tenDuong,
        ngang: widget.ngang,
        dai: widget.dai,
        basement: widget.basement,
        terrace: widget.terrace,
        terraceUpgrated: widget.terraceUpgrated,
        mezzanine: widget.mezzanine,
        roomNumber: widget.roomNumber,
        wcrNumber: widget.wcrNumber,
        wccNumber: widget.wccNumber,
        balcony: widget.balcony,
        window: widget.window,
        gia: double.parse(ctlGia.text),
        floorNumber: widget.floorNumber,
        hoaHong: double.parse(ctlHoaHong.text),
        vat: int.parse(ctlVAT.text),
      );
      _thongTinCoBanBloc.add(ThongTinCoBanSave(thongTinCoBanModel: _thongTinCoBanModel)); // bloc
    } catch (error, s) {
      print(error);
      print(s);
    }
  }

  @override
  void initState() {
    super.initState();
    _thongTinCoBanBloc = ThongTinCoBanBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _thongTinCoBanBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Giá, hoa hồng, VAT'),
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
                MyTopTitle(text: 'Giá'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlGia,
                  type: TextInputType.number,
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Hoa hồng'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlHoaHong,
                  type: TextInputType.number,
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'VAT'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlVAT,
                  type: TextInputType.number,
                ),
              ],
            ),
          ), // bottom
          BlocListener(
            bloc: _thongTinCoBanBloc,
            listener: (context, state){
              if(state is ThongTinCoBanSaveSuccess){
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Dialogs.showAddSuccessToast();
              }
              if(state is ThongTinCoBanSaveFailure){
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                Dialogs.showFailureToast();
              }
            },
            child: Builder(
              builder: (context) =>  Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: MyButton(
                  color: Color(0xff3FBF55),
                  text: Text(
                    'Lưu',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  event: (){
                    if (ctlGia.text != '' && ctlHoaHong.text != '' && ctlVAT.text != '') {
                      _handleSubmit(context);
                    } else {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hãy nhập đầy đủ thông tin !'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
