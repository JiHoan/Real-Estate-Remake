import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_text.dart';

class VATUpdatePage extends StatefulWidget {
  final int id;
  final int gia;
  final int hoaHong;
  final int vat;

  const VATUpdatePage({
    Key key,
    @required this.id,
    @required this.gia,
    @required this.hoaHong,
    @required this.vat,
  }) : super(key: key);

  @override
  _VATUpdatePageState createState() => _VATUpdatePageState();
}

class _VATUpdatePageState extends State<VATUpdatePage> {
  /*var ctlGia = new MoneyMaskedTextController(decimalSeparator: '', thousandSeparator: ',', precision: 0);
  var ctlVAT = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var ctlHoaHong = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');*/

  /*var ctlGia = new MaskedTextController(mask: '000000000000');
  var ctlVAT = new MaskedTextController(mask: '000000000000');
  var ctlHoaHong = new MaskedTextController(mask: '000000000000');*/
  CapNhatTtcbBloc _nhaChoThueDetailBloc;

  bool _onChanged = false;
  bool _changed = false;

  TextEditingController ctlGia = TextEditingController();
  TextEditingController ctlVAT = TextEditingController();
  TextEditingController ctlHoaHong = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nhaChoThueDetailBloc = CapNhatTtcbBloc();

    ctlGia.text = widget.gia.toString();
    ctlVAT.text = widget.vat.toString();
    ctlHoaHong.text = widget.hoaHong.toString();
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _nhaChoThueDetailBloc.add(
        UpdateVAT(
          model: NhaChoThueDetailModel(
            gia: int.tryParse(ctlGia.text) ?? 0,
            hoaHong: int.tryParse(ctlHoaHong.text) ?? 0,
            vat: int.tryParse(ctlVAT.text) ?? 0,
          ),
          id: widget.id,
        ),
      );
    } catch (error) {
      print(error);
    }
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
        title: Text('Giá, hoa hồng, VAT'),
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
                MyTopTitle(text: 'Giá'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlGia,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Hoa hồng'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlHoaHong,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'VAT'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlVAT,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
              ],
            ),
          ),
          // bottom
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
                  bloc: _nhaChoThueDetailBloc,
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
                          if (ctlGia.text != '' && ctlHoaHong.text != '' && ctlVAT.text != '') {
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
