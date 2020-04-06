import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class KhachMoiTabView extends StatefulWidget {
  final int id;
  final KhachTimMbBloc khachTimMbBloc;
  final CommonModel loaiHinh;
  final int tabChange;

  const KhachMoiTabView(
      {Key key, @required this.id, @required this.khachTimMbBloc, @required this.loaiHinh, @required this.tabChange})
      : super(key: key);

  @override
  _KhachMoiTabViewState createState() => _KhachMoiTabViewState();
}

class _KhachMoiTabViewState extends State<KhachMoiTabView> {
  String radioValue;
  int radioGroup = 2;

  List<MyRadioList> radioList = [
    MyRadioList(
      index: 1,
      title: 'Đổi vị trí KD',
      value: 'DOI_VI_TRI_KINH_DOANH',
    ),
    MyRadioList(
      index: 2,
      title: 'Mở cửa hàng/ MB mới',
      value: 'MO_CUA_HANG_MB_MOI',
    ),
  ];

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      widget.khachTimMbBloc.add(UpdateKhachLauNam(id: widget.id, khachLauNam: 'KHONG', loaiHinh: radioValue));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    radioValue = radioList[1].value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: <Widget>[
              MyTopTitle(text: 'Loại hình'),
              buildRow(),
            ],
          ),
        ),
        widget.tabChange == 0
            ? BlocListener(
                bloc: widget.khachTimMbBloc,
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
              )
            : _onChanged == false
                ? MyButtonDisable()
                : BlocListener(
                    bloc: widget.khachTimMbBloc,
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
    );
  }

  Widget buildRow() {
    return Row(
      children: <Widget>[
        Wrap(
          spacing: 60,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: radioList
              .map(
                (data) => Wrap(
                  spacing: 7,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Radio(
                        groupValue: radioGroup,
                        value: data.index,
                        activeColor: Color(0xff3FBF55),
                        onChanged: (val) {
                          /*setState(
                            () {
                          radioValue = data.value;
                          radioGroup = data.index;
                        },
                      );*/
                          print(radioValue);
                        },
                      ),
                    ),
                    Text(data.title),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
