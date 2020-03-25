import 'package:flutter/material.dart';

class MyTopTitle extends StatelessWidget {
  final String text;

  const MyTopTitle({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(color: Color(0xffA00000)),
      ),
    );
  }
}
