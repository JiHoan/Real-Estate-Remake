import 'package:flutter/material.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/currency_textfield.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

import 'thoi_gian_thue_next_page.dart';

class GiaCanThueNextPage extends StatefulWidget {
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

  const GiaCanThueNextPage(
      {Key key,
      this.moTa,
      this.sdt,
      this.ten,
      this.mucDich,
      this.thanhPho,
      this.quan,
      this.phuong,
      this.tenDuong,
      this.dienTich,
      this.soLau,
      this.lung,
      this.ham,
      this.sanThuong,
      this.sanThuongCaiTao,
      this.soPhong,
      this.soWCR,
      this.soWCC,
      this.banCong,
      this.cuaSo,
      this.thangBo,
      this.soThangThoatHiem,
      this.soThangMay,
      this.huongNha})
      : super(key: key);

  @override
  _GiaCanThueNextPageState createState() => _GiaCanThueNextPageState();
}

class _GiaCanThueNextPageState extends State<GiaCanThueNextPage> {
  TextEditingController ctlGiaMin = TextEditingController();
  TextEditingController ctlGiaMax = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Giá cần thuê'),
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
                MyTopTitle(text: 'Giá cần thuê'),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: MyCurrencyTextField(
                        ctl: ctlGiaMin,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 5,
                      child: MyCurrencyTextField(
                        ctl: ctlGiaMax,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: MyButton(
                color: Color(0xff3FBF55),
                text: Text(
                  'Lưu & Tiếp tục',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () {

                  if (ctlGiaMin.text != '' && ctlGiaMax.text != '') {
                    if(int.tryParse(ctlGiaMin.text.replaceAll('.', '')) >= int.tryParse(ctlGiaMax.text.replaceAll('.', ''))){
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Giá min phải thấp hơn giá max.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThoiGianThueNextPage(
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
                                giaMin: int.tryParse(ctlGiaMin.text.replaceAll('.', '')).toString(),
                                giaMax: int.tryParse(ctlGiaMax.text.replaceAll('.', '')).toString(),
                              )));
                    }
                  } else {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy nhập đầy đủ thông tin.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
