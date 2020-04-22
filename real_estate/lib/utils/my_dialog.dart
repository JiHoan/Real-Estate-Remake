import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogs {
  /*static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.white,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Đang xử lý",
                    style: TextStyle(color: Colors.blueAccent),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }*/

  static Future<void> showProgressDialog(BuildContext context, GlobalKey key) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            key: key,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Container(
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Đang xử lý",
                    style: TextStyle(color: Colors.blueAccent),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  static Future<void> showBackHomeDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          content: Container(
            height: 130,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thông báo",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Hủy thao tác và quay về trang chủ?",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Đồng ý"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            FlatButton(
              child: Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  static showUpdateSuccessToast() {
    return Fluttertoast.showToast(
      msg: "Đã cập nhật thành công.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showRemoveSuccessToast() {
    return Fluttertoast.showToast(
      msg: "Đã xóa thành công.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showFailureToast() {
    return Fluttertoast.showToast(
      msg: "Đã có lỗi xảy ra.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showAddSuccessToast() {
    return Fluttertoast.showToast(
      msg: "Đã thêm thành công.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showMissingTextField (BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Hãy nhập đầy đủ thông tin.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  static showWrongFormatTextField (BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Sai định dạng giá trị diện tích.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
