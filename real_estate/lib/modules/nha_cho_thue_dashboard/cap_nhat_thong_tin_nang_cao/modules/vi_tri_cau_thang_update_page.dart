import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class ViTriCauThangUpdatePage extends StatefulWidget {
  final int id;
  final CommonModel viTriThangBo;
  final int soThangThoatHiem;
  final int soThangMay;
  final CommonModel nhaHuongGi;

  const ViTriCauThangUpdatePage({Key key,@required this.id, @required this.viTriThangBo,@required  this.soThangThoatHiem,@required  this.soThangMay,@required  this.nhaHuongGi}) : super(key: key);

  @override
  _ViTriCauThangUpdatePageState createState() => _ViTriCauThangUpdatePageState();
}

class _ViTriCauThangUpdatePageState extends State<ViTriCauThangUpdatePage> {
  int valThangThoatHiem = 0;
  int valThangMay = 0;

  String rdViTriCauThangValue;
  int rdViTriCauThangGroup;

  List<MyRadioList> rdViTriCauThangList = [
    MyRadioList(
      index: 1,
      title: 'Không có',
      value: 'KHONG_CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Trước',
      value: 'TRUOC',
    ),
    MyRadioList(
      index: 3,
      title: '2/3',
      value: '2/3',
    ),
    MyRadioList(
      index: 4,
      title: 'Giữa nhà',
      value: 'GIUA_NHA',
    ),
    MyRadioList(
      index: 5,
      title: 'Cuối nhà',
      value: 'CUOI_NHA',
    ),
  ];

  List<HuongNha> listHuongNha = [
    HuongNha(
      index: 1,
      title: 'Đông',
      value: 'DONG',
    ),
    HuongNha(
      index: 2,
      title: 'Tây',
      value: 'TAY',
    ),
    HuongNha(
      index: 3,
      title: 'Nam',
      value: 'NAM',
    ),
    HuongNha(
      index: 3,
      title: 'Bắc',
      value: 'BAC',
    ),
    HuongNha(
      index: 3,
      title: 'Đông Nam',
      value: 'DONG_NAM',
    ),
    HuongNha(
      index: 3,
      title: 'Tây Nam',
      value: 'TAY_NAM',
    ),
    HuongNha(
      index: 3,
      title: 'Đông Bắc',
      value: 'DONG_BAC',
    ),
    HuongNha(
      index: 3,
      title: 'Tây Bắc',
      value: 'TAY_BAC',
    ),
  ];

  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;

  String _huongNhaSelection;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(UpdateViTriThangBo(id: widget.id, viTriThangBo: rdViTriCauThangValue, bnThangThoatHiem: valThangThoatHiem, bnThangMay: valThangMay, nhaHuongGi: _huongNhaSelection));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();

    valThangThoatHiem = widget.soThangThoatHiem;
    valThangMay = widget.soThangMay;

    if (widget.viTriThangBo.value == 'KHONG_XAC_DINH') {
      rdViTriCauThangGroup = 1;
      rdViTriCauThangValue = rdViTriCauThangList[0].value;
    } else {
      rdViTriCauThangValue = widget.viTriThangBo.value;
      rdViTriCauThangGroup = widget.viTriThangBo.index;
    }

    if(widget.nhaHuongGi.value != 'KHONG_XAC_DINH'){
      _huongNhaSelection = widget.nhaHuongGi.value;
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
        title: Text('Vị trí cầu thang'),
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
                MyTopTitle(text: 'Vị trí thang bộ'),
                buildRowStairPosition(),
                const SizedBox(height: 20),
                buildRowStairNumber(),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Hướng nhà'),
                buildHuongNha(),
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
                    _handleSubmit(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHuongNha() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        style: TextStyle(color: Colors.black87),
        underline: SizedBox(),
        onChanged: (newVal) {
          setState(() {
            _huongNhaSelection = newVal;

            _onChanged = true;
          });
        },
        value: _huongNhaSelection,
        items: listHuongNha.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value.toString(),
          );
        }).toList(),
      ),
    );
  }

  Wrap buildRowStairPosition() {
    return Wrap(
      spacing: 50,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdViTriCauThangList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 90,
              ),
              child: GestureDetector(
                onTap: (){
                  setState(
                        () {
                      rdViTriCauThangValue = data.value;
                      rdViTriCauThangGroup = data.index;
                      _onChanged = true;
                    },
                  );
                },
                child: Wrap(
                  spacing: 7,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Radio(
                        groupValue: rdViTriCauThangGroup,
                        value: data.index,
                        activeColor: Color(0xff3FBF55),
                        onChanged: (val) {
                          setState(
                            () {
                              rdViTriCauThangValue = data.value;
                              rdViTriCauThangGroup = data.index;
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
            ),
          )
          .toList(),
    );
  }

  Row buildRowStairNumber() {
    return Row(
      children: <Widget>[
        Wrap(
          spacing: 50,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyTopTitle(text: 'Số thang thoát hiểm'),
                Row(
                  children: <Widget>[
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (valThangThoatHiem > 0) {
                              valThangThoatHiem--;
                              _onChanged = true;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(valThangThoatHiem.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valThangThoatHiem++;
                            _onChanged = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyTopTitle(text: 'Số thang máy'),
                Row(
                  children: <Widget>[
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (valThangMay > 0) {
                              valThangMay--;
                              _onChanged = true;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(valThangMay.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valThangMay++;
                            _onChanged = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class HuongNha {
  final index;
  final title;
  final value;

  HuongNha({this.index, this.title, this.value});
}
