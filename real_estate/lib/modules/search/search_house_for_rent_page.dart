import 'package:flutter/material.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';
import 'package:real_estate/utils/style.dart';

class SearchHouseForRent extends StatefulWidget {
  @override
  _SearchHouseForRentState createState() => _SearchHouseForRentState();
}

class _SearchHouseForRentState extends State<SearchHouseForRent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tìm nhà cho thuê'),
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
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                MyTopTitle(text: 'Quận'),
                Material(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: <Widget>[
                          Text('adasda'),
                          Spacer(),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Phường'),
                MyDropBox(
                  list: ['Bình Thạnh', 'Gò Vấp', 'Tân Bình', '1', '2', '3'],
                ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Đường'),
                MyDropBox(
                  list: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '11', '12'],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTopTitle(text: 'Diện tích'),
                          MyInput(
                            hintText: 'Ngang',
                            color: Color(0xffEBEBEB),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTopTitle(text: ''),
                          MyInput(
                            hintText: 'Dài',
                            color: Color(0xffEBEBEB),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Giá'),
                MyDropBox(
                  list: [
                    '1.000.000 - 3.000.000',
                    '3.000.000 - 5.000.000',
                    '5.000.000 - 8.000.000',
                    '8.000.000 - 10.000.000',
                    '> 10.000.000',
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: MyButton(
              color: Color(0xff3FBF55),
              text: Text(
                'Tìm',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              event: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => AreaNextPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
