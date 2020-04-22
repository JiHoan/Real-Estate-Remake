import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyCurrencyTextField extends StatefulWidget {
  final double fontSize;
  final TextEditingController ctl;
  final Function onChanged;

  const MyCurrencyTextField({Key key, this.fontSize = 28, @required this.ctl, this.onChanged}) : super(key: key);

  @override
  _MyCurrencyTextFieldState createState() => _MyCurrencyTextFieldState();
}

class _MyCurrencyTextFieldState extends State<MyCurrencyTextField> {
//  bool isNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              style: const TextStyle(color: Colors.black87),
              controller: widget.ctl,
              keyboardType: TextInputType.number,
              autovalidate: true,
              toolbarOptions: ToolbarOptions(cut: false, copy: true, paste: false, selectAll: true),
              onChanged: (value) {
                /*setState(() {
                  isNotEmpty = value != null && value.trim().length > 0;
                });*/
                widget.onChanged();
              },
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                filled: true,
                fillColor: const Color(0xffEBEBEB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    topLeft: Radius.circular(7),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: const Text('vnđ', style: TextStyle(color: Colors.black26)),
            decoration: BoxDecoration(
              color: const Color(0xffEBEBEB),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat("#,##0", "vi_VN");

    String newText = formatter.format(value);

    if (newText.length > 15) {
      return oldValue;
    }

    return newValue.copyWith(text: newText, selection: new TextSelection.collapsed(offset: newText.length));
  }
}
