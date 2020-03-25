import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/style.dart';

class AddHouseForRent extends StatefulWidget {
  @override
  _AddHouseForRentState createState() => _AddHouseForRentState();
}

class _AddHouseForRentState extends State<AddHouseForRent> {
  List<File> _images = List<File>();
  var priceController = new MaskedTextController(mask: '000.000.000.000');
  var phoneController = new MaskedTextController(mask: '0000000000');

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600, maxHeight: 600);
    setState(() {
      if (image != null) {
        _images.add(image);
      }
    });
  }

  removeImage(int index) {
    setState(() {
      _images = List.from(_images)..removeAt(index);
    });
  }

  previewImage(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.file(
            _images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm nhà cho thuê'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text(
              'Thông tin nhà cho thuê'.toUpperCase(),
              style: MyAppStyle.price,
            ),
//
            SizedBox(height: 15),
            Text(
              'Hình ảnh',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Material(
                  color: Color(0xff3FBF55),
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () {
                      getImage();
                    },
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Image.asset('assets/camera.png'),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 5,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) => Stack(
                        children: <Widget>[
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.file(
                                _images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: GestureDetector(
                              onTap: () {
                                removeImage(index);
                              },
                              child: Image.asset('assets/close.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
//
            SizedBox(height: 15),
            Text(
              'Số nhà',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(hintText: '', color: Color(0xffEBEBEB)),
            ),

//
            SizedBox(height: 15),
            Text(
              'Tên đường',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(hintText: '', color: Color(0xffEBEBEB)),
            ),
//
            SizedBox(height: 15),
            Text(
              'Phường/ xã',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(hintText: '', color: Color(0xffEBEBEB)),
            ),
//
            SizedBox(height: 15),
            Text(
              'Quận/ huyện',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyDropBox(
                list: ['Bình Thạnh', 'Gò Vấp', 'Tân Bình', '1', '2', '3'],
              ),
            ),
//
            SizedBox(height: 15),
            Text(
              'Diện tích',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(hintText: '', color: Color(0xffEBEBEB)),
            ),
//
            SizedBox(height: 15),
            Text(
              'Tình trạng',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(
                hintText: '',
                color: Color(0xffEBEBEB),
                lines: 3,
              ),
            ),
//
            SizedBox(height: 15),
            Text(
              'Giá',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(
                hintText: '',
                color: Color(0xffEBEBEB),
                controller: priceController,
                type: TextInputType.number,
              ),
            ),
//
            SizedBox(height: 15),
            Text(
              'Điện thoại',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(
                hintText: '',
                color: Color(0xffEBEBEB),
                controller: phoneController,
                type: TextInputType.number,
              ),
            ),
//
            SizedBox(height: 15),
            Text(
              'Người nhận',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(hintText: '', color: Color(0xffEBEBEB)),
            ),
//
            SizedBox(height: 15),
            Text(
              'Yêu cầu chủ nhà',
              style: TextStyle(color: Color(0xffA00000)),
            ),
            SizedBox(height: 5),
            Container(
              child: MyInput(
                hintText: '',
                color: Color(0xffEBEBEB),
                lines: 3,
              ),
            ),
//
            SizedBox(height: 15),
            MyButton(
              text: Text('Thêm', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
              color: Color(0xff3FBF55),
              event: () {},
            ),
          ],
        ),
      ),
    );
  }
}
