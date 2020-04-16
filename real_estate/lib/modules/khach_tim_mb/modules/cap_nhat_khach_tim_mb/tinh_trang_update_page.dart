import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class TinhTrangUpdatePage extends StatefulWidget {
  final int id;
  final List<MyRadioList> rdMoTaList;
  final CommonModel tinhTrang;

  const TinhTrangUpdatePage({Key key, @required this.rdMoTaList, @required this.tinhTrang, @required this.id}) : super(key: key);

  @override
  _TinhTrangUpdatePageState createState() => _TinhTrangUpdatePageState();
}

class _TinhTrangUpdatePageState extends State<TinhTrangUpdatePage> {
  KhachTimMbBloc _khachTimMbBloc;
  String rdMoTaValue;
  int rdMoTaGroup;
  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(UpdateTinhTrang(id: widget.id, tinhTrang: rdMoTaValue));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();

    rdMoTaGroup = widget.tinhTrang.index;
    rdMoTaValue = widget.tinhTrang.value;
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
        title: Text('Tình trạng'),
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
                MyTopTitle(text: 'Mô tả'), buildRowMoTa(), // bottom
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
                    if(state is KhachTimMbFailure){
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

  Wrap buildRowMoTa() {
    return Wrap(
      spacing: 80,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widget.rdMoTaList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
              ),
              child: Wrap(
                spacing: 7,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Radio(
                      groupValue: rdMoTaGroup,
                      value: data.index,
                      activeColor: Color(0xff3FBF55),
                      onChanged: (val) {
                        setState(
                          () {
                            rdMoTaValue = data.value;
                            rdMoTaGroup = data.index;
                            _onChanged = true;
                          },
                        );
                      },
                    ),
                  ),
                  Text(data.title),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

