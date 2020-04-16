import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class GiaCanThueUpdatePage extends StatefulWidget {
  final int id;
  final int giaMin;
  final int giaMax;

  const GiaCanThueUpdatePage({Key key, @required this.id, @required this.giaMin, @required this.giaMax}) : super(key: key);

  @override
  _GiaCanThueUpdatePageState createState() => _GiaCanThueUpdatePageState();
}

class _GiaCanThueUpdatePageState extends State<GiaCanThueUpdatePage> {
  TextEditingController ctlGiaMin = TextEditingController();
  TextEditingController ctlGiaMax = TextEditingController();
  KhachTimMbBloc _khachTimMbBloc;
  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(
        UpdateGiaCanThue(
          id: widget.id,
          giaMin: int.tryParse(ctlGiaMin.text),
          giaMax: int.tryParse(ctlGiaMax.text),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();

    ctlGiaMin.text = widget.giaMin.toString();
    ctlGiaMax.text = widget.giaMax.toString();
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
        title: Text('Giá cần thuê'),
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
                MyTopTitle(text: 'Giá cần thuê'),
                Row(
                  children: <Widget>[
                    Container(
                      height: 45,
                      child: Text('Từ: ', style: TextStyle(color: Colors.black54)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          controller: ctlGiaMin,
                          style: TextStyle(color: Colors.black87),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _onChanged = true;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 15),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 7),
                    Container(
                      height: 45,
                      child: Text('đến: ', style: TextStyle(color: Colors.black54)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          controller: ctlGiaMax,
                          style: TextStyle(color: Colors.black87),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _onChanged = true;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 15),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      Dialogs.showUpdateSuccessToast();
                    }
                    if (state is KhachTimMbFailure) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Dialogs.showFailureToast();
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
