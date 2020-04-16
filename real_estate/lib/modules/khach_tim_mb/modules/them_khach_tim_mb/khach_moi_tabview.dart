import 'package:flutter/material.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'loai_khach_next_page.dart';

class KhachMoiTabView extends StatefulWidget {
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
  final int currentSegment;

  const KhachMoiTabView(
      {Key key,
      this.giaMax,
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
      this.giaMin,
      this.thoiGianThue, this.currentSegment})
      : super(key: key);

  @override
  _KhachMoiTabViewState createState() => _KhachMoiTabViewState();
}

class _KhachMoiTabViewState extends State<KhachMoiTabView> {
  String radioValue;
  int radioGroup = 2;

  List<MyRadioList> radioList = [
    MyRadioList(
      index: 1,
      title: 'Đổi vị trí KD',
      value: 'DOI_VI_TRI_KINH_DOANH',
    ),
    MyRadioList(
      index: 2,
      title: 'Mở cửa hàng/ MB mới',
      value: 'MO_CUA_HANG_MB_MOI',
    ),
  ];

  @override
  void initState() {
    super.initState();
    radioValue = radioList[1].value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: <Widget>[
              MyTopTitle(text: 'Loại hình'),
              buildRow(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: MyButton(
            color: Color(0xff3FBF55),
            text: Text(
              'Lưu & Tiếp tục',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            event: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoaiKhachNextPage(
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
                        loaiHinh: radioValue,
                        currentSegment: widget.currentSegment,
                      )));
            },
          ),
        ),
      ],
    );
  }

  Widget buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: radioList
          .map(
            (data) => Wrap(
          spacing: 7,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 20,
              child: Radio(
                groupValue: radioGroup,
                value: data.index,
                activeColor: Color(0xff3FBF55),
                onChanged: (val) {
                  /*setState(
                            () {
                          radioValue = data.value;
                          radioGroup = data.index;
                        },
                      );*/
                  print(radioValue);
                },
              ),
            ),
            Text(data.title),
          ],
        ),
      )
          .toList(),
    );
  }
}
