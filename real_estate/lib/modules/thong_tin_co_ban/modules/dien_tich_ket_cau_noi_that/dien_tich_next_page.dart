import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:real_estate/modules/thong_tin_co_ban/modules/vat/vat_next_page.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

class DienTichNextPage extends StatefulWidget {
  final String type;
  final String sdtNguoiNhan;
  final String tenNguoiNhan;
  final String tinhTpId;
  final String quanHuyenId;
  final String phuongXaId;
  final String soNha;
  final String tenDuong;

  const DienTichNextPage(
      {Key key,
      @required this.type,
      @required this.sdtNguoiNhan,
      @required this.tenNguoiNhan,
      @required this.tinhTpId,
      @required this.quanHuyenId,
      @required this.phuongXaId,
      @required this.soNha,
      @required this.tenDuong})
      : super(key: key);

  @override
  _DienTichNextPageState createState() => _DienTichNextPageState();
}

class _DienTichNextPageState extends State<DienTichNextPage> {
  int valRoomNum = 0;
  int valWcrNum = 0;
  int valWccNum = 0;
  int valFloorNum = 0;
  int mezzanineNum = 0;

  String basementValue;
  String terraceValue;
  String terraceUpgratedValue;
  String mezzanineValue;
  String balconyValue;
  String windowValue;

  int basementGroup = 2;
  int terraceGroup = 2;
  int terraceUpgratedGroup = 2;
  int mezzanineGroup = 1;
  int balconyGroup = 2;
  int windowGroup = 2;


  var ctlNgang = new MaskedTextController(mask: '0000');
  var ctlDai = new MaskedTextController(mask: '0000');

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
  ];

  List<MyRadioList> mezzanineList = [
    MyRadioList(
      index: 1,
      title: '0 lửng',
      value: '0_LUNG',
    ),
    MyRadioList(
      index: 2,
      title: '1 lửng',
      value: '1_LUNG',
    ),
    MyRadioList(
      index: 3,
      title: '2 lửng',
      value: '2_LUNG',
    ),
    MyRadioList(
      index: 4,
      title: '3 lửng',
      value: '3_LUNG',
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
  ];

  @override
  void initState() {
    super.initState();

    basementValue = basementList[1].value;
    terraceValue = terraceList[1].value;
    terraceUpgratedValue = terraceUpgratedList[1].value;
    mezzanineValue = mezzanineList[0].value;
    balconyValue = balconyList[1].value;
    windowValue = windowList[1].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Diện tích, kết cấu, nội thất'),
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
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTopTitle(text: 'Diện tích'),
                          MyInput(
                            hintText: 'Ngang',
                            color: Color(0xffEBEBEB),
                            lines: 1,
                            controller: ctlNgang,
                            type: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTopTitle(text: ''),
                          MyInput(
                            hintText: 'Dài',
                            color: Color(0xffEBEBEB),
                            lines: 1,
                            controller: ctlDai,
                            type: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ],
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
                MyTopTitle(text: 'Nhà có hầm hay không?'),
                buildBasementRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà có sân thượng hay không?'),
                buildTerraceRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Sân thượng có cải tạo được không?'),
                buildTerraceUpgratedRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Nhà bao nhiêu lửng?'),
                buildMezzanineRow(),
                SizedBox(height: 20),
                buildRoomNumberRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Phòng có ban công không?'),
                buildBalconyRow(),
                SizedBox(height: 20),
                MyTopTitle(text: 'Phòng có cửa sổ không?'),
                buildWindowRow(),
                widget.type == 'NHA_CHO_THUE' ? SizedBox() : buildBanVe(),
              ],
            ),
          ),
          // bottom
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: MyButton(
                color: Color(0xff3FBF55),
                text: Text(
                  'Tiếp tục',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                event: () {
                  if (ctlNgang.text != '' && ctlDai.text != '') {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VATNextPage(
                          sdtNguoiNhan: widget.sdtNguoiNhan,
                          tenNguoiNhan: widget.tenNguoiNhan,
                          tinhTpId: widget.tinhTpId,
                          quanHuyenId: widget.quanHuyenId,
                          phuongXaId: widget.phuongXaId,
                          soNha: widget.soNha,
                          tenDuong: widget.tenDuong,
                          ngang: double.parse(ctlNgang.text),
                          dai: double.parse(ctlDai.text),
                          floorNumber: valFloorNum,
                          basement: basementValue,
                          terrace: terraceValue,
                          terraceUpgrated: terraceUpgratedValue,
                          mezzanine: mezzanineNum - 1,
                          roomNumber: valRoomNum,
                          wcrNumber: valWcrNum,
                          wccNumber: valWccNum,
                          balcony: balconyValue,
                          window: windowValue,
                        ),
                      ),
                    );
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
        ],
      ),
    );
  }

  Column buildBanVe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        MyTopTitle(text: 'Bản vẽ'),
        Row(
          children: <Widget>[
            Material(
              color: Color(0xffEDEDED),
              borderRadius: BorderRadius.circular(7),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  height: 60,
                  child: Image.asset('assets/camera1.png'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBasementRow() {
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 100,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 20,
                child: Radio(
                  groupValue: basementGroup,
                  value: basementList[index].index,
                  activeColor: Color(0xff3FBF55),
                  onChanged: (val) {
                    setState(
                      () {
                        basementValue = basementList[index].value;
                        basementGroup = basementList[index].index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 7),
              Text(basementList[index].title),
            ],
          );
        },
      ),
    );
  }

  Widget buildTerraceRow() {
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 100,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 20,
                child: Radio(
                  groupValue: terraceGroup,
                  value: terraceList[index].index,
                  activeColor: Color(0xff3FBF55),
                  onChanged: (val) {
                    setState(
                      () {
                        terraceValue = terraceList[index].value;
                        terraceGroup = terraceList[index].index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 7),
              Text(terraceList[index].title),
            ],
          );
        },
      ),
    );
  }

  Widget buildTerraceUpgratedRow() {
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 100,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 20,
                child: Radio(
                  groupValue: terraceUpgratedGroup,
                  value: terraceUpgratedList[index].index,
                  activeColor: Color(0xff3FBF55),
                  onChanged: (val) {
                    setState(
                      () {
                        terraceUpgratedValue = terraceUpgratedList[index].value;
                        terraceUpgratedGroup = terraceUpgratedList[index].index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 7),
              Text(terraceUpgratedList[index].title),
            ],
          );
        },
      ),
    );
  }

  Widget buildMezzanineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: mezzanineList
          .map(
            (data) => Row(
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
                          mezzanineNum = data.index;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 7),
                Text(data.title),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildBalconyRow() {
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 100,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 20,
                child: Radio(
                  groupValue: balconyGroup,
                  value: balconyList[index].index,
                  activeColor: Color(0xff3FBF55),
                  onChanged: (val) {
                    setState(
                      () {
                        balconyValue = balconyList[index].value;
                        balconyGroup = balconyList[index].index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 7),
              Text(balconyList[index].title),
            ],
          );
        },
      ),
    );
  }

  Widget buildWindowRow() {
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 100,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 20,
                child: Radio(
                  groupValue: windowGroup,
                  value: windowList[index].index,
                  activeColor: Color(0xff3FBF55),
                  onChanged: (val) {
                    setState(
                      () {
                        windowValue = windowList[index].value;
                        windowGroup = windowList[index].index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 7),
              Text(windowList[index].title),
            ],
          );
        },
      ),
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
                      setState(
                        () {
                          if (valRoomNum > 0) {
                            valRoomNum--;
                          }
                        },
                      );
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
                      setState(
                        () {
                          valRoomNum++;
                        },
                      );
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
                      setState(
                        () {
                          if (valWcrNum > 0) {
                            valWcrNum--;
                          }
                        },
                      );
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
                  child: Text(valWcrNum.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(
                        () {
                          valWcrNum++;
                        },
                      );
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
                        if (valWccNum > 0) {
                          valWccNum--;
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
                  child: Text(valWccNum.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valWccNum++;
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
}
