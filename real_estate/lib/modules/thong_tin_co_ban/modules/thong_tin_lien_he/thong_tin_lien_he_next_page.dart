import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

import '../dia_chi/dia_chi_next_page.dart';

class ThongTinLienHeNextPage extends StatefulWidget {
  final String type;

  const ThongTinLienHeNextPage({Key key, @required this.type}) : super(key: key);

  @override
  _ThongTinLienHeNextPageState createState() => _ThongTinLienHeNextPageState();
}

class _ThongTinLienHeNextPageState extends State<ThongTinLienHeNextPage> {
  var ctlSdtNguoiNhan = new MaskedTextController(mask: '0000000000');
  TextEditingController ctlTenNguoiNhan = TextEditingController();

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
                // body
                MyTopTitle(text: 'Số điện thoại'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  controller: ctlSdtNguoiNhan,
                  type: TextInputType.number,
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Người nhận'),
                MyTenRiengInput(controller: ctlTenNguoiNhan),
                /*Container(
                  height: 45,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(color: Colors.black87),
                    controller: ctlTenNguoiNhan,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      filled: true,
                      fillColor: Color(0xffEBEBEB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),*/
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
                  'Tiếp tục',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () {
                  if (ctlSdtNguoiNhan.text != '' && ctlTenNguoiNhan.text != '') {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiaChiNextPage(
                          sdtNguoiNhan: ctlSdtNguoiNhan.text,
                          tenNguoiNhan: ctlTenNguoiNhan.text,
                        ),
                      ),
                    );
                  } else {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Dialogs.showMissingTextField(context);
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
