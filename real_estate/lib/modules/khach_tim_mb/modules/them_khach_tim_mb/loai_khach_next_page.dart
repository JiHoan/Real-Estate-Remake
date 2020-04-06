import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'mo_ta_khac_next_page.dart';

class LoaiKhachNextPage extends StatefulWidget {
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
  final String giaThue;
  final String thoiGianThue;
  final String loaiHinh;
  final int currentSegment;

  const LoaiKhachNextPage(
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
      this.huongNha,
      this.giaThue,
      this.thoiGianThue,
      this.loaiHinh, this.currentSegment})
      : super(key: key);

  @override
  _LoaiKhachNextPageState createState() => _LoaiKhachNextPageState();
}

class _LoaiKhachNextPageState extends State<LoaiKhachNextPage> {
  TextEditingController ctlTenThuongHieu = TextEditingController();
  String rdLoaiKhachValue;
  int rdLoaiKhacGroup = 0;

  List<MyRadioList> rdLoaiKhachList = [
    MyRadioList(
      index: 0,
      title: 'Công ty',
      value: 'CONG_TY',
    ),
    MyRadioList(
      index: 1,
      title: 'Cá nhân',
      value: 'CA_NHAN',
    ),
  ];

  @override
  void initState() {
    super.initState();
    rdLoaiKhachValue = rdLoaiKhachList[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Loại khách'),
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
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                // body
                MyTopTitle(text: 'Loại khách hàng'),
                buildRowNguoiChoThue(),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Tên thương hiệu'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlTenThuongHieu,
                ),
                // bottom
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
                  if (ctlTenThuongHieu.text != '') {
                    print(rdLoaiKhachValue);
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoTaKhacNextPage(
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
                              giaThue: widget.giaThue,
                              thoiGianThue: widget.thoiGianThue,
                              loaiHinh: widget.loaiHinh,
                              loaiKhach: rdLoaiKhachValue,
                              tenThuongHieu: ctlTenThuongHieu.text,
                              currentSegment: widget.currentSegment,
                            )));
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

  Wrap buildRowNguoiChoThue() {
    return Wrap(
      spacing: 80,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdLoaiKhachList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
              ),
              child: Wrap(
                spacing: 7,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Radio(
                      groupValue: rdLoaiKhacGroup,
                      value: data.index,
                      activeColor: Color(0xff3FBF55),
                      onChanged: (val) {
                        setState(
                          () {
                            rdLoaiKhachValue = data.value;
                            rdLoaiKhacGroup = data.index;
                          },
                        );
                        print(rdLoaiKhachValue);
                      },
                    ),
                  ),
                  Text(data.title),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
