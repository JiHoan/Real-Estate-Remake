import 'package:flutter/material.dart';
import 'package:real_estate/modules/nha_cho_thue/modules/chua_thue_view.dart';
import 'modules/chua_lien_he_view.dart';
import 'modules/da_thue_view.dart';

class NhaChoThuePage extends StatefulWidget {
  @override
  _NhaChoThuePageState createState() => _NhaChoThuePageState();
}

class _NhaChoThuePageState extends State<NhaChoThuePage> {
  // Default Radio Button Item
  String radioItem = 'Chưa liên hệ';

  // Group Value for Radio Button.
  int id = 1;

  List<FilterList> fList = [
    FilterList(
      index: 1,
      name: "Chưa liên hệ",
    ),
    FilterList(
      index: 2,
      name: "Chưa thuê",
    ),
    FilterList(
      index: 3,
      name: "Đã thuê",
    ),
  ];

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: fList
                  .map((data) => GestureDetector(
                        onTap: () {
                          setState(() {
                            radioItem = data.name;
                            id = data.index;
                          });
                          Navigator.pop(context);
                        },
                        child: Wrap(
                          spacing: 7,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                              width: 20,
                              child: Radio(
                                groupValue: id,
                                value: data.index,
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = data.name;
                                    id = data.index;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Text(data.name),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            actions: <Widget>[
              Material(
                color: Color(0xff3FBF55),
                borderRadius: BorderRadius.circular(7),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 30,
                    width: 70,
                    alignment: Alignment.center,
                    child: Text(
                      'Hủy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nhà cho thuê'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, bottom: 10, top: 10),
            child: Row(
              children: <Widget>[
                Text('Kết quả: 4'),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _showDialog();
                  },
                  child: Text(radioItem),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/filter.png'),
                ),
              ],
            ),
          ),
          Expanded(
            child: radioItem == 'Chưa liên hệ' ? ChuaLienHeView() : radioItem == 'Chưa thuê' ? ChuaThueView() : DaThueView(),
          ),
        ],
      ),
    );
  }
}

class FilterList {
  String name;
  int index;

  FilterList({this.name, this.index});
}
