import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/utils/button.dart';
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
                MyTopTitle(text: 'Nội dung ghi chú'),
                Container(
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
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
                        _nhaChoThueDetailBloc
                            .add(UpdateRow(type: 'ghi-chu', obType: 'ghi_chu', id: widget.id, text: ctlGhiChu.text));
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
