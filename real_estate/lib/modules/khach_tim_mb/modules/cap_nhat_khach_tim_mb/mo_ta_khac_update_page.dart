import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class MoTaKhacUpdatePage extends StatefulWidget {
  final int id;
  final String moTaKhac;

  const MoTaKhacUpdatePage({Key key,@required this.id, @required this.moTaKhac}) : super(key: key);

  @override
  _MoTaKhacUpdatePageState createState() => _MoTaKhacUpdatePageState();
}

class _MoTaKhacUpdatePageState extends State<MoTaKhacUpdatePage> {
  TextEditingController ctlMoTaKhac = TextEditingController();
  KhachTimMbBloc _khachTimMbBloc;
  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(UpdateMoTaKhac(id: widget.id, moTaKhac: ctlMoTaKhac.text));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
    ctlMoTaKhac.text = widget.moTaKhac;
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
        title: Text('Mô tả khác'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Image.asset('assets/group.png'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                MyTopTitle(text: 'Mô tả khác'),
                Container(
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                    maxLines: 3,
                    controller: ctlMoTaKhac,
                    onChanged: (value){
                      setState(() {
                        _onChanged = true;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      filled: true,
                      fillColor: Color(0xffEBEBEB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // bottom
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
                Dialogs.showSuccessToast();
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
