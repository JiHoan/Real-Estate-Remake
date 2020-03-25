import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class TinhTrangNextPage extends StatefulWidget {
  @override
  _TinhTrangNextPageState createState() => _TinhTrangNextPageState();
}

class _TinhTrangNextPageState extends State<TinhTrangNextPage> {
  String rdMoTaValue;
  int rdMoTaGroup = 0;

  List<MyRadioList> rdMoTaList = [
    MyRadioList(
      index: 0,
      title: 'Bình thường',
      value: 'BINH_THUONG',
    ),
    MyRadioList(
      index: 1,
      title: 'Cần gấp',
      value: 'CAN_GAP',
    ),
  ];

  @override
  void initState() {
    super.initState();
    rdMoTaValue = rdMoTaList[0].value;
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
                MyTopTitle(text: 'Mô tả'),
                buildRowMoTa(),
                // bottom
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: MyRowButton(
              text: Text(
                'Lưu & Tiếp tục',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              event: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => NguoiChoThueNextPage()));
              },
            ),
          ),
        ],
      ),
    );
  }

  Wrap buildRowMoTa() {
    return Wrap(
      spacing: 80,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdMoTaList
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
                    print(rdMoTaValue);
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
