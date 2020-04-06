import 'package:flutter/material.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/modules/vi_tri_cau_thang_update_page.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'gia_can_thue_next_page.dart';

class KetCauNhaCanThueNextPage extends StatefulWidget {
  final String moTa;
  final String sdt;
  final String ten;
  final String mucDich;
  final String thanhPho;
  final String quan;
  final String phuong;
  final String tenDuong;

  const KetCauNhaCanThueNextPage(
      {Key key, this.moTa, this.sdt, this.ten, this.mucDich, this.thanhPho, this.quan, this.phuong, this.tenDuong})
      : super(key: key);

  @override
  _KetCauNhaCanThueNextPageState createState() => _KetCauNhaCanThueNextPageState();
}

class _KetCauNhaCanThueNextPageState extends State<KetCauNhaCanThueNextPage> {
  TextEditingController ctlDienTich = TextEditingController();

  int valRoomNum = 0;
  int valWCR = 0;
  int valWCC = 0;
  int valFloorNum = 0;
  int valExitStairNum = 0;
  int valElevatorNum = 0;

  String basementValue;
  String terraceValue;
  String terraceUpgratedValue;
  String mezzanineValue;
  String balconyValue;
  String windowValue;
  String rdViTriCauThangValue;

  int basementGroup = 2;
  int terraceGroup = 2;
  int terraceUpgratedGroup = 2;
  int mezzanineGroup = 2;
  int balconyGroup = 2;
  int windowGroup = 2;
  int rdViTriCauThangGroup = 5;

  List<MyRadioList> basementList = [
    MyRadioList(
      index: 0,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> terraceList = [
    MyRadioList(
      index: 0,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> terraceUpgratedList = [
    MyRadioList(
      index: 0,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];
  List<MyRadioList> mezzanineList = [
    MyRadioList(
      index: 0,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> balconyList = [
    MyRadioList(
      index: 0,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];
  List<MyRadioList> windowList = [
    MyRadioList(
      index: 0,
      title: 'Có',
      value: 'CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Không',
      value: 'KHONG',
    ),
    MyRadioList(
      index: 2,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  List<MyRadioList> rdViTriCauThangList = [
    MyRadioList(
      index: 0,
      title: 'Không có',
      value: 'KHONG_CO',
    ),
    MyRadioList(
      index: 1,
      title: 'Trước',
      value: 'TRUOC',
    ),
    MyRadioList(
      index: 2,
      title: '2/3',
      value: '2/3',
    ),
    MyRadioList(
      index: 3,
      title: 'Giữa nhà',
      value: 'GIUA_NHA',
    ),
    MyRadioList(
      index: 4,
      title: 'Cuối nhà',
      value: 'CUOI_NHA',
    ),
    MyRadioList(
      index: 5,
      title: 'Tất cả',
      value: 'TAT_CA',
    ),
  ];

  String _huongNhaSelection;
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

  @override
  void initState() {
    super.initState();

    basementValue = basementList[2].value;
    terraceValue = terraceList[2].value;
    terraceUpgratedValue = terraceUpgratedList[2].value;
    mezzanineValue = mezzanineList[2].value;
    balconyValue = balconyList[2].value;
    windowValue = windowList[2].value;
    rdViTriCauThangValue = rdViTriCauThangList[5].value;
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
                ),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà bao nhiêu lầu?'),
                Row(
                  children: <Widget>[
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (valFloorNum > 0) {
                              valFloorNum--;
                            }
                            print(valFloorNum);
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
                      child: Text(valFloorNum.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valFloorNum++;
                            print(valFloorNum);
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
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà bao nhiêu lửng?'),
                buildMezzanineRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà có hầm hay không?'),
                buildBasementRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà có sân thượng hay không?'),
                buildTerraceRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Sân thượng có cải tạo được không?'),
                buildTerraceUpgratedRow(),
                SizedBox(height: 20),
                buildRoomNumberRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Phòng có ban công không?'),
                buildBalconyRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Phòng có cửa sổ không?'),
                buildWindowRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Vị trí thang bộ'),
                buildStairRow(),
                const SizedBox(height: 20),
                buildRowStairNumber(),
                const SizedBox(height: 20),
                MyTopTitle(text: 'Hướng nhà'),
                buildHuongNha(),
              ],
            ),
          ), // bottom
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: MyButton(
                color: Color(0xff3FBF55),
                text: Text(
                  'Lưu & Tiếp tục',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () {
                  if (ctlDienTich.text != '' && _huongNhaSelection != null) {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GiaCanThueNextPage(
                              moTa: widget.moTa,
                              sdt: widget.sdt,
                              ten: widget.ten,
                              mucDich: widget.mucDich,
                              thanhPho: widget.thanhPho,
                              quan: widget.quan,
                              phuong: widget.phuong,
                              tenDuong: widget.tenDuong,
                              dienTich: ctlDienTich.text,
                              soLau: valFloorNum,
                              lung: mezzanineValue,
                              ham: basementValue,
                              sanThuong: terraceValue,
                              sanThuongCaiTao: terraceUpgratedValue,
                              soPhong: valRoomNum,
                              soWCR: valWCR,
                              soWCC: valWCC,
                              banCong: balconyValue,
                              cuaSo: windowValue,
                              thangBo: rdViTriCauThangValue,
                              soThangThoatHiem: valExitStairNum,
                              soThangMay: valElevatorNum,
                              huongNha: _huongNhaSelection,
                                )));
                  } else {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy nhập đầy đủ thông tin.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
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

  Widget buildBasementRow() {
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
                    groupValue: basementGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          basementValue = data.value;
                          basementGroup = data.index;
                        },
                      );
                      print(basementValue);
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

  Widget buildTerraceRow() {
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
                    groupValue: terraceGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          terraceValue = data.value;
                          terraceGroup = data.index;
                        },
                      );
                      print(terraceValue);
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

  Widget buildTerraceUpgratedRow() {
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
                    groupValue: terraceUpgratedGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          terraceUpgratedValue = data.value;
                          terraceUpgratedGroup = data.index;
                        },
                      );
                      print(terraceUpgratedValue);
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

  Widget buildMezzanineRow() {
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
                    groupValue: mezzanineGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          mezzanineValue = data.value;
                          mezzanineGroup = data.index;
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

  Widget buildBalconyRow() {
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
                    groupValue: balconyGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          balconyValue = data.value;
                          balconyGroup = data.index;
                        },
                      );
                      print(balconyValue);
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

  Widget buildWindowRow() {
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
                    groupValue: windowGroup,
                    value: data.index,
                    activeColor: Color(0xff3FBF55),
                    onChanged: (val) {
                      setState(
                        () {
                          windowValue = data.value;
                          windowGroup = data.index;
                        },
                      );
                      print(windowValue);
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

  Row buildRoomNumberRow() {
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
                        if (valRoomNum > 0) {
                          valRoomNum--;
                        }
                        print(valRoomNum);
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
                  child: Text(valRoomNum.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valRoomNum++;
                        print(valRoomNum);
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
                        }
                        print(valWCR);
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
                  child: Text(valWCR.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valWCR++;
                        print(valWCR);
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
                          valWCC--;
                        }
                        print(valWCC);
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
                  child: Text(valWCC.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valWCC++;
                        print(valWCC);
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
    );
  }

  Widget buildStairRow() {
    return Wrap(
      spacing: 51,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: rdViTriCauThangList
          .map(
            (data) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 89,
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
                          },
                        );
                        print(rdViTriCauThangValue);
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
                            if (valExitStairNum > 0) {
                              valExitStairNum--;
                            }
                            print(valExitStairNum);
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
                      child: Text(valExitStairNum.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valExitStairNum++;
                            print(valExitStairNum);
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
                            if (valElevatorNum > 0) {
                              valElevatorNum--;
                            }
                            print(valElevatorNum);
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
                      child: Text(valElevatorNum.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valElevatorNum++;
                            print(valElevatorNum);
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
