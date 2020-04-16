import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

import 'khu_vuc_can_thue_next_page.dart';

class MucDichThueNextPage extends StatefulWidget {
  final String moTa;
  final String sdt;
  final String ten;

  const MucDichThueNextPage({Key key, @required this.moTa, @required this.sdt, @required this.ten}) : super(key: key);

  @override
  _MucDichThueNextPageState createState() => _MucDichThueNextPageState();
}

class _MucDichThueNextPageState extends State<MucDichThueNextPage> {
  TextEditingController ctlMucDich = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mục đích thuê'),
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
                MyTopTitle(text: 'Mục đích thuê nhà'),
                Container(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black87),
                    maxLines: 3,
                    controller: ctlMucDich,
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
                  if (ctlMucDich.text != '') {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KhuVucCanThueNextPage(
                              moTa: widget.moTa,
                              ten: widget.ten,
                              sdt: widget.sdt,
                              mucDich: ctlMucDich.text,
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
