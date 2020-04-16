import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class ThoiGianChoThueToiDaUpdatePage extends StatefulWidget {
  final int id;
  final int soNamThueToiDa;

  const ThoiGianChoThueToiDaUpdatePage({Key key, @required this.id, @required this.soNamThueToiDa}) : super(key: key);

  @override
  _ThoiGianChoThueToiDaUpdatePageState createState() => _ThoiGianChoThueToiDaUpdatePageState();
}

class _ThoiGianChoThueToiDaUpdatePageState extends State<ThoiGianChoThueToiDaUpdatePage> {
  TextEditingController ctlSoNamThueToiDa = TextEditingController();
  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(UpdateThoiGianChoThueToiDa(id: widget.id, soNamThueToiDa: ctlSoNamThueToiDa.text));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();
    ctlSoNamThueToiDa.text = widget.soNamThueToiDa.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thời gian cho thuê tối đa'),
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
                // body
                MyTopTitle(text: 'Số năm cho thuê tối đa '),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  type: TextInputType.number,
                  controller: ctlSoNamThueToiDa,
                  onChanged: (value){
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ), // bottom
              ],
            ),
          ),
          _onChanged == false
              ? Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: MyButton(
              color: Colors.black26,
              text: Text(
                'Lưu',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              event: null,
            ),
          )
              : BlocListener(
            bloc: _capNhatTtncBloc,
            listener: (context, state) {
              if (state is UpdateSuccess) {
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                Navigator.pop(context, _changed); // pop về dashboard
                Dialogs.showUpdateSuccessToast();
              }
              if (state is UpdateFailure) {
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                Dialogs.showFailureToast();
              }
            },
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: MyButton(
                  color: Color(0xff3FBF55),
                  text: Text(
                    'Lưu',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  event: () {
                    if (ctlSoNamThueToiDa.text != '') {
                      _changed = true;
                      _handleSubmit(context);
                    } else {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hãy nhập đầy đủ thông tin !'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
