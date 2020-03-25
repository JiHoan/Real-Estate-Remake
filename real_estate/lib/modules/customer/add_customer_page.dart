import 'package:flutter/material.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/style.dart';

class AddCustomerPage extends StatefulWidget {
  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  String dropdownValue = 'VND';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text('Thêm khách hàng tìm mặt bằng', style: MyAppStyle.appbar),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xffF8A200),
                ),
                onPressed: () {},
              );
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                child: Text(
                  'Thông tin khách/ thương hiệu'.toUpperCase(),
                  style: MyAppStyle.title1,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyInput(
                        hintText: 'Tên khách/ thương hiệu',
                      ),
                    ),
                    SizedBox(height: 10),
//
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: MyInput(
                              hintText: 'Số điện thoại',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: MyInput(
                              hintText: 'Người nhận',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
//
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF8A200),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: MyInput(
                                  hintText: 'Tài chính',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8A200).withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
//                            iconSize: 24,
//                            elevation: 16,
                                    style: TextStyle(color: Colors.black54),
                                    underline: Container(
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    items: <String>[
                                      'VND',
                                      '\$',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
//
                          MyInput(
                            hintText: 'Ghi chú',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
