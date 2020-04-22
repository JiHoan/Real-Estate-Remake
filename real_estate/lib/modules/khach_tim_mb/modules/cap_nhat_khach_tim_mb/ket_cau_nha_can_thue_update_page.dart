import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/modules/vi_tri_cau_thang_update_page.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class KetCauNhaCanThueUpdatePage extends StatefulWidget {
  final int id;
  final String dienTich;
  final int soLau;
  final CommonModel lung;
  final CommonModel ham;
  final CommonModel sanThuong;
  final CommonModel sanThuongCaiTao;
  final int soPhong;
  final int soWCR;
  final int soWCC;
  final CommonModel banCong;
  final CommonModel cuaSo;
  final CommonModel viTriThangBo;
  final int soThangThoatHiem;
  final int soThangMay;
  final CommonModel huongNha;

  const KetCauNhaCanThueUpdatePage({
    Key key,
    this.dienTich,
    this.soLau,
    this.lung,
    this.ham,
    this.sanThuong,
    this.sanThuongCaiTao,
    this.soPhong,
    this.soWCR,
    this.soWCC,
    this.banCong,
    this.cuaSo,
    this.viTriThangBo,
    this.soThangThoatHiem,
    this.soThangMay,
    this.huongNha,
    this.id,
  }) : super(key: key);

  @override
  _KetCauNhaCanThueUpdatePageState createState() => _KetCauNhaCanThueUpdatePageState();
}

class _KetCauNhaCanThueUpdatePageState extends State<KetCauNhaCanThueUpdatePage> {
  KhachTimMbBloc _khachTimMbBloc;
  bool _onChanged = false;
  bool _changed = false;

  TextEditingController ctlDienTich = TextEditingController();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      KhachTimMbModel model = KhachTimMbModel(
        dienTich: ctlDienTich.text,
        soLau: valSoLau,
        lung: rdLungValue,
        ham: rdHamValue,
        sanThuong: rdSanThuongValue,
        sanThuongCaiTao: rdSanThuongCaiTaoValue,
        soPhong: valSoPhong,
        soWCR: valWCR,
        soWCC: valWCC,
        banCong: rdBanCongValue,
        cuaSo: rdCuaSoValue,
        thangBo: rdViTriCauThangValue,
        soThangThoatHiem: valSoThangThoatHiem,
        soThangMay: valSoThangMay,
        huongNha: huongNhaSelection,
      );
      _khachTimMbBloc.add(UpdateKetCauNhaCanThue(id: widget.id, model: model));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();

    ctlDienTich.text = widget.dienTich;

    valSoLau = widget.soLau;
    valSoPhong = widget.soPhong;
    valWCR = widget.soWCR;
    valWCC = widget.soWCC;
    valSoThangThoatHiem = widget.soThangThoatHiem;
    valSoThangMay = widget.soThangMay;

    rdLungValue = widget.lung.value;
    rdLungGroup = widget.lung.index;
    rdHamValue = widget.ham.value;
    rdHamGroup = widget.ham.index;
    rdSanThuongValue = widget.sanThuong.value;
    rdSanThuongGroup = widget.sanThuong.index;
    rdSanThuongCaiTaoValue = widget.sanThuongCaiTao.value;
    rdSanThuongCaiTaoGroup = widget.sanThuongCaiTao.index;
    rdBanCongValue = widget.banCong.value;
    rdBanCongGroup = widget.banCong.index;
    rdCuaSoValue = widget.cuaSo.value;
    rdCuaSoGroup = widget.cuaSo.index;
    rdViTriCauThangValue = widget.viTriThangBo.value;
    rdViTriCauThangGroup = widget.viTriThangBo.index;

    huongNhaSelection = widget.huongNha.value;
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
        title: Text('Kết cấu nhà cần thuê'),
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
          // body
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: <Widget>[
                MyTopTitle(text: 'Diện tích'),
                MyInput(
                  hintText: '',
                  color: Color(0xffEBEBEB),
                  lines: 1,
                  controller: ctlDienTich,
                  type: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _onChanged = true;
                    });
                  },
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà bao nhiêu lầu?'),
                buildLau(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà bao nhiêu lửng?'),
                buildLung(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà có hầm hay không?'),
                buildHam(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà có sân thượng hay không?'),
                buildSanThuong(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Sân thượng có cải tạo được không?'),
                buildSanThuongCaiTao(),
                SizedBox(height: 20),
                buildSoPhongWCRWCC(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Phòng có ban công không?'),
                buildBanCong(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Phòng có cửa sổ không?'),
                buildCuaSo(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Vị trí thang bộ'),
                buildViTriThangBo(),
                const SizedBox(height: 20),
                buildSoThang(),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Hướng nhà'),
                buildHuongNha(),
              ],
            ),
          ), // bottom
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
                    if (state is KhachTimMbFailure) {
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

  Row buildLau() {
    return Row(
      children: <Widget>[
        Material(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: () {
              setState(() {
                if (valSoLau > 0) {
                  valSoLau--;
                  _onChanged = true;
                }
              });
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: const Icon(Icons.remove, size: 20, color: Colors.black54,),
            ),
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(valSoLau.toString()),
        ),
        Material(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: () {
              setState(() {
                valSoLau++;
                _onChanged = true;
              });
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: const Icon(Icons.add, size: 20, color: Colors.black54,),
            ),
          ),
        ),
      ],
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
            huongNhaSelection = newVal;
            _onChanged = true;
          });
        },
        value: huongNhaSelection,
        items: listHuongNha.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.title),
            value: item.value.toString(),
          );
        }).toList(),
      ),
    );
  }

  Widget buildHam() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: basementList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdHamGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdHamValue = data.value;
                          rdHamGroup = data.index;
                          _onChanged = true;
                        },
                      );
                    },
                  ),
                ),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildSanThuong() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: terraceList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdSanThuongGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdSanThuongValue = data.value;
                          rdSanThuongGroup = data.index;
                          _onChanged = true;
                        },
                      );
                    },
                  ),
                ),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildSanThuongCaiTao() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: terraceUpgratedList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdSanThuongCaiTaoGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdSanThuongCaiTaoValue = data.value;
                          rdSanThuongCaiTaoGroup = data.index;
                          _onChanged = true;
                        },
                      );
                    },
                  ),
                ),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildLung() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: mezzanineList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdLungGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdLungValue = data.value;
                          rdLungGroup = data.index;
                          _onChanged = true;
                        },
                      );
                    },
                  ),
                ),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildBanCong() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: balconyList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdBanCongGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdBanCongValue = data.value;
                          rdBanCongGroup = data.index;
                          _onChanged = true;
                        },
                      );
                    },
                  ),
                ),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildCuaSo() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: windowList
          .map(
            (data) => Wrap(
              spacing: 7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    groupValue: rdCuaSoGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          rdCuaSoValue = data.value;
                          rdCuaSoGroup = data.index;
                          _onChanged = true;
                        },
                      );
                    },
                  ),
                ),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Row buildSoPhongWCRWCC() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyTopTitle(text: 'Số phòng'),
            Row(
              children: <Widget>[
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (valSoPhong > 0) {
                          valSoPhong--;
                          _onChanged = true;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: const Icon(Icons.remove, size: 20, color: Colors.black54,),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text(valSoPhong.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valSoPhong++;
                        _onChanged = true;
                      });
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: const Icon(Icons.add, size: 20, color: Colors.black54,),
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
            MyTopTitle(text: 'Số WCR'),
            Row(
              children: <Widget>[
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (valWCR > 0) {
                          valWCR--;
                          _onChanged = true;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: const Icon(Icons.remove, size: 20, color: Colors.black54,),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text(valWCR.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valWCR++;
                        _onChanged = true;
                      });
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: const Icon(Icons.add, size: 20, color: Colors.black54,),
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
            MyTopTitle(text: 'Số WCC'),
            Row(
              children: <Widget>[
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (valWCC > 0) {
                          _onChanged = true;
                          valWCC--;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: const Icon(Icons.remove, size: 20, color: Colors.black54,),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text(valWCC.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valWCC++;
                        _onChanged = true;
                      });
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: const Icon(Icons.add, size: 20, color: Colors.black54,),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildViTriThangBo() {
    return Wrap(
      spacing: 51,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdViTriCauThangList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 120,
              ),
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
          )
          .toList(),
    );
  }

  Row buildSoThang() {
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
                            if (valSoThangThoatHiem > 0) {
                              valSoThangThoatHiem--;
                              _onChanged = true;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: const Icon(Icons.remove, size: 20, color: Colors.black54,),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(valSoThangThoatHiem.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valSoThangThoatHiem++;
                            _onChanged = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: const Icon(Icons.add, size: 20, color: Colors.black54,),
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
                            if (valSoThangMay > 0) {
                              valSoThangMay--;
                              _onChanged = true;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: const Icon(Icons.remove, size: 20, color: Colors.black54,),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(valSoThangMay.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valSoThangMay++;
                            _onChanged = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: const Icon(Icons.add, size: 20, color: Colors.black54,),
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

  int valSoPhong;
  int valWCR;
  int valWCC;
  int valSoLau;
  int valSoThangThoatHiem;
  int valSoThangMay;

  String rdHamValue;
  String rdSanThuongValue;
  String rdSanThuongCaiTaoValue;
  String rdLungValue;
  String rdBanCongValue;
  String rdCuaSoValue;
  String rdViTriCauThangValue;

  int rdHamGroup;
  int rdSanThuongGroup;
  int rdSanThuongCaiTaoGroup;
  int rdLungGroup;
  int rdBanCongGroup;
  int rdCuaSoGroup;
  int rdViTriCauThangGroup;

  List<MyRadioList> basementList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 3,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> terraceList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 3,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> terraceUpgratedList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 3,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];
  List<MyRadioList> mezzanineList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 3,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> balconyList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 3,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];
  List<MyRadioList> windowList = [
    MyRadioList(
      index: 1,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 2,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 3,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

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
    MyRadioList(
      index: 6,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  String huongNhaSelection;
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
      index: 4,
      title: 'Bắc',
      value: 'BAC',
    ),
    HuongNha(
      index: 5,
      title: 'Đông Nam',
      value: 'DONG_NAM',
    ),
    HuongNha(
      index: 6,
      title: 'Tây Nam',
      value: 'TAY_NAM',
    ),
    HuongNha(
      index: 7,
      title: 'Đông Bắc',
      value: 'DONG_BAC',
    ),
    HuongNha(
      index: 8,
      title: 'Tây Bắc',
      value: 'TAY_BAC',
    ),
  ];
}
