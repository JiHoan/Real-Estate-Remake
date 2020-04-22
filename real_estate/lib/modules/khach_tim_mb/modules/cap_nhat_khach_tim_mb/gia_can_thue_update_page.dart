import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/currency_textfield.dart';
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
          giaMin: int.tryParse(ctlGiaMin.text.replaceAll('.', '')) ?? 0,
          giaMax: int.tryParse(ctlGiaMax.text.replaceAll('.', '')) ?? 0,
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  final formatter = NumberFormat("#,###", "vi_VN");

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();

    ctlGiaMin.text = formatter.format(widget.giaMin);
    ctlGiaMax.text = formatter.format(widget.giaMax);
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
                    Expanded(
                      child: MyCurrencyTextField(
                        ctl: ctlGiaMin,
                        onChanged: (){
                          setState(() {
                            _onChanged = true;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 7),
                    Expanded(
                      child: MyCurrencyTextField(
                        ctl: ctlGiaMax,
                        onChanged: (){
                          setState(() {
                            _onChanged = true;
                          });
                        },
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
