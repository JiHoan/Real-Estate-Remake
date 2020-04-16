import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'thong_tin_lien_he_next_page.dart';


class TinhTrangNextPage extends StatefulWidget {
  final List<MyRadioList> rdMoTaList;

  const TinhTrangNextPage({Key key, @required this.rdMoTaList}) : super(key: key);

  @override
  _TinhTrangNextPageState createState() => _TinhTrangNextPageState();
}

class _TinhTrangNextPageState extends State<TinhTrangNextPage> {
  String rdMoTaValue;
  int rdMoTaGroup = 0;

  @override
  void initState() {
    super.initState();
    rdMoTaValue = widget.rdMoTaList[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tình trạng'),
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
                MyTopTitle(text: 'Mô tả'), buildMoTa(), // bottom
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinLienHeNextPage(moTa: rdMoTaValue,)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Wrap buildMoTa() {
    return Wrap(
      spacing: 70,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widget.rdMoTaList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdMoTaGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdMoTaValue = data.value;
                          rdMoTaGroup = data.index;
                        },
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      rdMoTaValue = data.value;
                      rdMoTaGroup = data.index;
                    });
                  },
                  child: Text(data.title)
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
