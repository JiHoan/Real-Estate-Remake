import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/check_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_check_box.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class ChuongNgaiVatUpdatePage extends StatefulWidget {
  final int id;
  final CheckListModel chuongNgaiVat;
  final String chungNgaiVatKhac;

  const ChuongNgaiVatUpdatePage({Key key, @required this.id, @required this.chuongNgaiVat, @required this.chungNgaiVatKhac})
      : super(key: key);

  @override
  _ChuongNgaiVatUpdatePageState createState() => _ChuongNgaiVatUpdatePageState();
}

class _ChuongNgaiVatUpdatePageState extends State<ChuongNgaiVatUpdatePage> {
  List<MyCheckBox> cbList = [
    MyCheckBox(
      isChecked: false,
      value: 'TRU_DIEN',
      title: 'Trụ điện',
    ),
    MyCheckBox(
      isChecked: false,
      value: 'BINH_DIEN',
      title: 'Bình điện',
    ),
    MyCheckBox(
      isChecked: false,
      value: 'CAY_XANH',
      title: 'Cây xanh',
    ),
    MyCheckBox(
      isChecked: false,
      value: 'CONG_RANH',
      title: 'Cống rãnh',
    ),
    MyCheckBox(
      isChecked: false,
      value: 'TRU_BOM_NUOC_CUU_HOA',
      title: 'Trụ bơm nước cứu hởa',
    ),
  ];

  CheckListModel _checkListModel;
  List<String> _isCheckedList = [];

  TextEditingController ctlChuongNgaiVatKhac = TextEditingController();
  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context, String chuongNgaiVat) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(UpdateChuongNgaiVat(id: widget.id, chuongNgaiVat: _isCheckedList, chuongNgaiVatKhac: chuongNgaiVat));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();

    _checkListModel = CheckListModel.fromJson(widget.chuongNgaiVat.toJson());

    if(widget.chungNgaiVatKhac == ' '){
      ctlChuongNgaiVatKhac.text = '';
    } else {
      ctlChuongNgaiVatKhac.text = widget.chungNgaiVatKhac;
    }

    for(int i = 0; i < widget.chuongNgaiVat.length; i++){
      if(widget.chuongNgaiVat[i].isChecked == true){
        _isCheckedList.add(widget.chuongNgaiVat[i].value);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _capNhatTtncBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chướng ngại vật trước nhà'),
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
                MyTopTitle(text: 'Chọn chướng ngại vật'),
                _buildCheckBoxGroup(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Chướng ngại vật khác'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlChuongNgaiVatKhac,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                //
                // bottom
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
                          _changed = true;
                          if(ctlChuongNgaiVatKhac.text.isEmpty){
                            _handleSubmit(context, ' ');
//                            _capNhatTtncBloc.add(UpdateChuongNgaiVat(id: widget.id, chuongNgaiVat: _isCheckedList, chuongNgaiVatKhac: ' '));
                          } else {
                            _handleSubmit(context, ctlChuongNgaiVatKhac.text);
//                            _capNhatTtncBloc.add(UpdateChuongNgaiVat(id: widget.id, chuongNgaiVat: _isCheckedList, chuongNgaiVatKhac: ctlChuongNgaiVatKhac.text));
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

  Widget _buildCheckBoxGroup() {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _checkListModel.map((element) {
        final index = _checkListModel.indexOf(element);
        return ConstrainedBox(
          constraints: BoxConstraints(minWidth: 160),
          child: Wrap(
            spacing: 7,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  activeColor: Color(0xff3FBF55),
                  value: element.isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      _onChanged = true;

                      _checkListModel[index] = element.copyWith(isChecked : value);

                      value == true ? _isCheckedList.add(element.value) : _isCheckedList.remove(element.value);
                    });
                  },
                ),
              ),
              Text(element.title),
            ],
          ),
        );
      }).toList(),
    );
  }
}
