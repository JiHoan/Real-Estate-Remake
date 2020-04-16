import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class GhiChuUpdatePage extends StatefulWidget {
  final int id;
  final String ghiChu;

  const GhiChuUpdatePage({Key key, @required this.id, @required this.ghiChu}) : super(key: key);

  @override
  _GhiChuUpdatePageState createState() => _GhiChuUpdatePageState();
}

class _GhiChuUpdatePageState extends State<GhiChuUpdatePage> {
  CapNhatTtcbBloc _nhaChoThueDetailBloc;

  TextEditingController ctlGhiChu = TextEditingController();

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _nhaChoThueDetailBloc
          .add(UpdateRow(type: 'ghi-chu', obType: 'ghi_chu', id: widget.id, text: ctlGhiChu.text));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();
    ctlGhiChu.text = widget.ghiChu;
  }

  @override
  void dispose() {
    super.dispose();
    _nhaChoThueDetailBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ghi chú'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context, _changed);
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
                MyTopTitle(text: 'Nội dung ghi chú'),
                Container(
                  child: TextFormField(
                    style: TextStyle(color: Colors.black87),
                    maxLines: 3,
                    controller: ctlGhiChu,
                    onChanged: (value) {
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
              ],
            ),
          ),
          _onChanged == false
              ? MyButtonDisable()
              : BlocListener(
            bloc: _nhaChoThueDetailBloc,
            listener: (context, state) {
              print(state);
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
              builder: (context) =>
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: MyButton(
                      color: Color(0xff3FBF55),
                      text: Text(
                        'Lưu',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      event: () {
                        if (ctlGhiChu.text == '') {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Hãy nhập đầy đủ thông tin !'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          _changed = true;
                          _handleSubmit(context);
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
