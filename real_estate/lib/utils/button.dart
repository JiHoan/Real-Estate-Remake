import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Widget text;
  final Color color;
  final Function event;

  MyButton({@required this.text, @required this.color, @required this.event});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: widget.event,
        borderRadius: BorderRadius.circular(7),
        child: Container(
          height: 45,
          width: double.infinity,
          alignment: Alignment.center,
          child: widget.text,
        ),
      ),
    );
  }
}

class MyRowButton extends StatefulWidget {
  final Widget text;
  final Function event;

  const MyRowButton({Key key, this.text, this.event}) : super(key: key);

  @override
  _MyRowButtonState createState() => _MyRowButtonState();
}

class _MyRowButtonState extends State<MyRowButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(7),
            child: Container(
              height: 50,
              width: 70,
              alignment: Alignment.center,
              child: Image.asset('assets/left-arrow.png'),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Material(
            color: Color(0xff3FBF55),
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              onTap: widget.event,
              borderRadius: BorderRadius.circular(7),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: widget.text,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyButtonDisable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: MyButton(
        color: Colors.black26,
        text: Text(
          'Lưu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        event: null,
      ),
    );
  }
}

