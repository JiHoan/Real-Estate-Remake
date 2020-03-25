import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  final String hintText;
  final Color color;
  final int lines;
  final controller;
  final TextInputType type;
  final Function onChanged;

  MyInput({@required this.hintText, @required this.color, this.lines, this.controller, this.type, this.onChanged});

  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextFormField(
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        maxLines: widget.lines,
        controller: widget.controller,
        keyboardType: widget.type,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          filled: true,
          fillColor: widget.color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class MyDropBox extends StatefulWidget {
  final list;

  MyDropBox({@required this.list});

  @override
  _MyDropBoxState createState() => _MyDropBoxState();
}

class _MyDropBoxState extends State<MyDropBox> {
  String _value;

  @override
  void initState() {
    _value = widget.list[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: _value,
        /*icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,*/
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        underline: SizedBox(),
        onChanged: (String newValue) {
          setState(() {
            _value = newValue;
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}