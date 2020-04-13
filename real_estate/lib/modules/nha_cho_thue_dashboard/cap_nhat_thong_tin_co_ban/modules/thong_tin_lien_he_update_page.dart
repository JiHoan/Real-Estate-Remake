import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/modules/kiem_tra_lien_lac_page.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_text.dart';

class ThongTinLienHeUpdatePage extends StatefulWidget {
  final ThongTinLienHeModel thongTinLienHe;
  final int id;

  const ThongTinLienHeUpdatePage({Key key, @required this.id,  @required  this.thongTinLienHe})
      : super(key: key);

  @override
  _ThongTinLienHeUpdatePageState createState() => _ThongTinLienHeUpdatePageState();
}

class _ThongTinLienHeUpdatePageState extends State<ThongTinLienHeUpdatePage> {
  CapNhatTtcbBloc _nhaChoThueDetailBloc;

  var ctlSdtNguoiNhan = new MaskedTextController(mask: '0000000000');
  TextEditingController ctlTenNguoiNhan = TextEditingController();

  bool _onChanged = false;
  bool _changed = false;

  @override
  void initState() {
    super.initState();

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();

    if(widget.thongTinLienHe != null){
      ctlSdtNguoiNhan.text = widget.thongTinLienHe.phone;
      ctlTenNguoiNhan.text = widget.thongTinLienHe.name;
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
        title: Text('Thông tin liên hệ'),
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
                // body
                MyTopTitle(text: 'Số điện thoại'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                          controller: ctlSdtNguoiNhan,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _onChanged = true;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                            filled: true,
                            fillColor: Color(0xffEBEBEB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), topLeft: Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
                      child: InkWell(
                        onTap: () {
                        },
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
                        child: Container(
                          width: 45,
                          height: 45,
                          child: Image.asset('assets/phone.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Người nhận'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlTenNguoiNhan,
                  onChanged: (value) {
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
                      Navigator.pop(context, _changed);
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
                          if (ctlSdtNguoiNhan.text != '' && ctlTenNguoiNhan.text != '') {
                            _changed = true;
                            ThongTinLienHeModel _model =
                                ThongTinLienHeModel(name: ctlTenNguoiNhan.text, phone: ctlSdtNguoiNhan.text);

                            _nhaChoThueDetailBloc.add(UpdateThongTinLienHe(model: _model, id: widget.id));
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
