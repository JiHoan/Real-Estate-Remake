import 'package:flutter/material.dart';

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
          onWillPop: () async => false,
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
}
