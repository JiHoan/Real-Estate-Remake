import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class LoaiKhachUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel loaiKhachHang;
  final String tenThuongHieu;

  const LoaiKhachUpdatePage({Key key, @required this.id, @required this.loaiKhachHang, @required this.tenThuongHieu})
      : super(key: key);

  @override
  _LoaiKhachUpdatePageState createState() => _LoaiKhachUpdatePageState();
}

class _LoaiKhachUpdatePageState extends State<LoaiKhachUpdatePage> {
  TextEditingController ctlTenThuongHieu = TextEditingController();
  String rdLoaiKhachValue;
  int rdLoaiKhacGroup;

  List<MyRadioList> rdLoaiKhachList = [
    MyRadioList(
      index: 1,
      title: 'Công ty',
      value: 'CONG_TY',
    ),
    MyRadioList(
      index: 2,
      title: 'Cá nhân',
      value: 'CA_NHAN',
    ),
  ];

  KhachTimMbBloc _khachTimMbBloc;
  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(UpdateLoaiKhachHang(id: widget.id, loaiKhach: rdLoaiKhachValue, tenThuongHieu: ctlTenThuongHieu.text));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();

    rdLoaiKhachValue = widget.loaiKhachHang.value;
    rdLoaiKhacGroup = widget.loaiKhachHang.index;
    ctlTenThuongHieu.text = widget.tenThuongHieu;
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
        title: Text('Loại khách'),
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
                MyTopTitle(text: 'Loại khách hàng'),
                buildRowNguoiChoThue(),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Tên thương hiệu'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlTenThuongHieu,
                  onChanged: (value){
                    setState(() {
                      _onChanged = true;
                    });
                  },
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

  Wrap buildRowNguoiChoThue() {
    return Wrap(
      spacing: 80,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdLoaiKhachList
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
                      groupValue: rdLoaiKhacGroup,
                      value: data.index,
                      activeColor: Color(0xff3FBF55),
                      onChanged: (val) {
                        setState(
                          () {
                            rdLoaiKhachValue = data.value;
                            rdLoaiKhacGroup = data.index;
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
