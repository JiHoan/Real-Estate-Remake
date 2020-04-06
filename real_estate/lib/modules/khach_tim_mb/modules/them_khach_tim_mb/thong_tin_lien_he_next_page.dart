import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

import 'muc_dich_thue_next_page.dart';

class ThongTinLienHeNextPage extends StatefulWidget {
  final String moTa;

  const ThongTinLienHeNextPage({Key key, @required this.moTa}) : super(key: key);

  @override
  _ThongTinLienHeNextPageState createState() => _ThongTinLienHeNextPageState();
}

class _ThongTinLienHeNextPageState extends State<ThongTinLienHeNextPage> {
  var ctlSdt = new MaskedTextController(mask: '0000000000');
  TextEditingController ctlTen = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thông tin liên hệ'),
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
                //
                MyTopTitle(text: 'Số điện thoại'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                          controller: ctlSdt,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), topLeft: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
                        child: Container(
                          width: 45,
                          height: 45,
                          child: Image.asset('assets/phone.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //
                MyTopTitle(text: 'Tên'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlTen,
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
                  if (ctlTen.text != '' && ctlSdt.text != null) {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MucDichThueNextPage(
                              moTa: widget.moTa,
                              sdt: ctlSdt.text,
                              ten: ctlTen.text,
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
}
