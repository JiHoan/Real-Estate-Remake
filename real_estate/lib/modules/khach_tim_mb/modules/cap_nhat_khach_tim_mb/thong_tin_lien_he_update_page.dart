import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class ThongTinLienHeUpdatePage extends StatefulWidget {
  final int id;
  final String sdt;
  final String ten;

  const ThongTinLienHeUpdatePage({Key key, @required this.sdt, @required this.id, @required this.ten}) : super(key: key);

  @override
  _ThongTinLienHeUpdatePageState createState() => _ThongTinLienHeUpdatePageState();
}

class _ThongTinLienHeUpdatePageState extends State<ThongTinLienHeUpdatePage> {
  KhachTimMbBloc _khachTimMbBloc;
  var ctlSdt = new MaskedTextController(mask: '0000000000');
  TextEditingController ctlTen = TextEditingController();
  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(UpdateThongTinLienHe(id: widget.id, sdt: ctlSdt.text, ten: ctlTen.text));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
    ctlSdt.text = widget.sdt;
    ctlTen.text = widget.ten;
  }

  @override
  void dispose() {
    super.dispose();
    _khachTimMbBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thông tin liên hệ'),
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
                //
                MyTopTitle(text: 'Số điện thoại'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black87),
                          controller: ctlSdt,
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            setState(() {
                              _onChanged = true;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), topLeft: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
                        child: Container(
                          width: 45,
                          height: 45,
                          child: Image.asset('assets/phone.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //
                MyTopTitle(text: 'Tên'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlTen,
                  onChanged: (value){
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
              ],
            ),
          ),
          _onChanged == false
              ? MyButtonDisable()
              : BlocListener(
                  bloc: _khachTimMbBloc,
                  listener: (context, state) {
                    if (state is KhachTimMbSuccess) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Navigator.pop(context, _changed); // pop về dashboard
                      Fluttertoast.showToast(
                        msg: "Đã cập nhật thành công.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                    if (state is KhachTimMbFailure) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Fluttertoast.showToast(
                        msg: "Đã có lỗi xảy ra.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: MyButton(
                      color: Color(0xff3FBF55),
                      text: Text(
                        'Lưu',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      event: () {
                        _changed = true;
                        _handleSubmit(context);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
