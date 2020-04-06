import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:real_estate/models/hinh_anh_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/common_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/input_field.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';

import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

class DienTichUpdatePage extends StatefulWidget {
  final int id;
  final double ngang;
  final double dai;
  final int lau;
  final CommonModel lung;
  final CommonModel ham;
  final CommonModel sanThuong;
  final CommonModel sanThuongCaiTao;
  final int soPhong;
  final int soWcr;
  final int soWcc;
  final CommonModel banCong;
  final CommonModel cuaSo;
  final HinhAnhListModel listHinhAnh;

  const DienTichUpdatePage({
    Key key,
    @required this.id,
    @required this.ngang,
    @required this.dai,
    @required this.lau,
    @required this.lung,
    @required this.ham,
    @required this.sanThuong,
    @required this.sanThuongCaiTao,
    @required this.soPhong,
    @required this.soWcr,
    @required this.soWcc,
    @required this.banCong,
    @required this.cuaSo,
    @required this.listHinhAnh,
  }) : super(key: key);

  @override
  _DienTichUpdatePageState createState() => _DienTichUpdatePageState();
}

class _DienTichUpdatePageState extends State<DienTichUpdatePage> {
  int valRoomNum;
  int valWcrNum;
  int valWccNum;
  int valFloorNum;
  int mezzanineNum = 0;

  String basementValue;
  String terraceValue;
  String terraceUpgratedValue;
  String mezzanineValue;
  String balconyValue;
  String windowValue;

  int basementGroup;
  int terraceGroup;
  int terraceUpgratedGroup;
  int mezzanineGroup;
  int balconyGroup;
  int windowGroup;

  /*var ctlNgang = new MaskedTextController(mask: '0000');
  var ctlDai = new MaskedTextController(mask: '0000');*/

  TextEditingController ctlNgang = TextEditingController();
  TextEditingController ctlDai = TextEditingController();

  bool _onChanged = false;
  bool _onChangedBanVe = false;
  bool _changed = false;

  HinhAnhListModel _hinhAnhListModel = HinhAnhListModel.fromJson([]);

  CapNhatTtcbBloc _nhaChoThueDetailBloc;

  List<int> _listIdBanVe = List<int>();

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
      value: '0',
    ),
    MyRadioList(
      index: 2,
      title: '1 lửng',
      value: '1',
    ),
    MyRadioList(
      index: 3,
      title: '2 lửng',
      value: '2',
    ),
    MyRadioList(
      index: 4,
      title: '3 lửng',
      value: '3',
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


  _viewThumb(String url, int index, int idBanVe) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                'http://nhadat.imark.vn/$url',
                height: 500,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 100, left: 100),
              child: Material(
                color: Color(0xff3FBF55),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      _onChangedBanVe = true;
                      _hinhAnhListModel.removeAt(index);
                      _listIdBanVe.add(idBanVe);
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text('Xóa hình', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _showDialog(){
    showDialog(context: context, builder: (context){
      return SimpleDialog(
        children: <Widget>[
          SimpleDialogOption(
            child: Text('Máy ảnh'),
            onPressed: (){
              _getImage();
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Text('Thư viện ảnh'),
            onPressed: () {
              _getMultiImage();
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }

  File _image;
  List<File> _listImg = List<File>();
  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 600);

    if (image != null) {
      setState(() {
        _image = image;
        _listImg.add(_image);
      });
    }

    if (_listImg != []) {
      setState(() {
        _onChanged = true;
      });
    }
  }

  List<Asset> images = List<Asset>();
  Future<void> _getMultiImage() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(()  {
      images = resultList;
      _onChanged = true;
    });

    addToListImg(images);
  }

  Future addToListImg(List<Asset> list) async {
    File file;
    File compressedFile;

    return list.map((element) async {
      file = await writeByteDataToFile(await element.getByteData(quality: 100));

      compressedFile = await FlutterNativeImage.compressImage(file.path, quality: 100,
          targetWidth: 600, targetHeight: 600);

      setState(() {
        _listImg.add(compressedFile);
      });
    }).toList();
  }

  Future<File> writeByteDataToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + randomAlphaNumeric(10);
    print(filePath);
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  void initState() {
    super.initState();

    print('a');
    print(widget.listHinhAnh);

    _nhaChoThueDetailBloc = CapNhatTtcbBloc();

    ctlNgang.text = widget.ngang.toString();
    ctlDai.text = widget.dai.toString();

    valFloorNum = widget.lau;
    valRoomNum = widget.soPhong;
    valWcrNum = widget.soWcr;
    valWccNum = widget.soWcc;

    basementGroup = widget.ham.index;
    basementValue = widget.ham.value;

    terraceGroup = widget.sanThuong.index;
    terraceValue = widget.sanThuong.value;

    terraceUpgratedGroup = widget.sanThuongCaiTao.index;
    terraceUpgratedValue = widget.sanThuongCaiTao.value;

    balconyGroup = widget.banCong.index;
    balconyValue = widget.banCong.value;

    windowGroup = widget.cuaSo.index;
    windowValue = widget.cuaSo.value;

    mezzanineGroup = widget.lung.index + 1;
    mezzanineValue = widget.lung.value;

    _hinhAnhListModel.addAll(widget.listHinhAnh);
    print(_hinhAnhListModel);
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
                            onChanged: (value) {
                              setState(() {
                                _onChanged = true;
                              });
                            },
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
                            onChanged: (value) {
                              setState(() {
                                _onChanged = true;
                              });
                            },
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
                      child: Text(valFloorNum.toString()),
                    ),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            valFloorNum++;
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
                buildBanVe(),
              ],
            ),
          ),

          (_onChanged == false && _onChangedBanVe == false)
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
                    print(state);
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
                          if (ctlNgang.text != '' && ctlDai.text != '') {
                            _changed = true;
                            if(_onChanged == true && _onChangedBanVe == true){
                              /*_nhaChoThueDetailBloc.add(
                                UpdateDienTichKetCauNoiThat(
                                  model: NhaChoThueDetailModel(
                                    ngang: double.parse(ctlNgang.text),
                                    dai: double.parse(ctlDai.text),
                                    lung: CommonModel(value: mezzanineValue, index: mezzanineGroup),
                                    ham: CommonModel(value: basementValue, index: basementGroup),
                                    sanThuong: CommonModel(value: terraceValue, index: terraceUpgratedGroup),
                                    sanThuongCaiTao: CommonModel(value: terraceUpgratedValue, index: terraceUpgratedGroup),
                                    soPhong: valRoomNum,
                                    soWcr: valWcrNum,
                                    soWcc: valWccNum,
                                    banCong: CommonModel(value: balconyValue, index: balconyGroup),
                                    cuaSo: CommonModel(value: windowValue, index: windowGroup),
                                    soLau: valFloorNum,
                                    hinhAnhBanVeUpdate: _listImg,
                                  ),
                                  id: widget.id,
                                ),
                              );
                              _nhaChoThueDetailBloc.add(RemoveHinhAnh(id: widget.id, banVeId: _listIdBanVe));*/

                              _nhaChoThueDetailBloc.add(UpdateAndRemove(
                                model: NhaChoThueDetailModel(
                                  ngang: double.parse(ctlNgang.text),
                                  dai: double.parse(ctlDai.text),
                                  lung: CommonModel(value: mezzanineValue, index: mezzanineGroup),
                                  ham: CommonModel(value: basementValue, index: basementGroup),
                                  sanThuong: CommonModel(value: terraceValue, index: terraceUpgratedGroup),
                                  sanThuongCaiTao: CommonModel(value: terraceUpgratedValue, index: terraceUpgratedGroup),
                                  soPhong: valRoomNum,
                                  soWcr: valWcrNum,
                                  soWcc: valWccNum,
                                  banCong: CommonModel(value: balconyValue, index: balconyGroup),
                                  cuaSo: CommonModel(value: windowValue, index: windowGroup),
                                  soLau: valFloorNum,
                                  hinhAnhBanVeUpdate: _listImg,
                                ),
                                banVeId: _listIdBanVe,
                                id: widget.id,
                              ));
                            }
                            else if(_onChangedBanVe == true){
                              _nhaChoThueDetailBloc.add(RemoveHinhAnh(id: widget.id, banVeId: _listIdBanVe));
                            } else {
                              _nhaChoThueDetailBloc.add(UpdateDienTichKetCauNoiThat(
                                model: NhaChoThueDetailModel(
                                  ngang: double.parse(ctlNgang.text),
                                  dai: double.parse(ctlDai.text),
                                  lung: CommonModel(value: mezzanineValue, index: mezzanineGroup),
                                  ham: CommonModel(value: basementValue, index: basementGroup),
                                  sanThuong: CommonModel(value: terraceValue, index: terraceUpgratedGroup),
                                  sanThuongCaiTao: CommonModel(value: terraceUpgratedValue, index: terraceUpgratedGroup),
                                  soPhong: valRoomNum,
                                  soWcr: valWcrNum,
                                  soWcc: valWccNum,
                                  banCong: CommonModel(value: balconyValue, index: balconyGroup),
                                  cuaSo: CommonModel(value: windowValue, index: windowGroup),
                                  soLau: valFloorNum,
                                  hinhAnhBanVeUpdate: _listImg,
                                ),
                                id: widget.id,
                              ));
                            }
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
                onTap: () {
                  _showDialog();
                },
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  height: 62,
                  width: 62,
                  child: Image.asset('assets/camera1.png'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: _listImg.map((item){
                    return Container(
                      margin: const EdgeInsets.only(left: 7),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.file(item, height: 60, width: 60, fit: BoxFit.cover,),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: _hinhAnhListModel.map(
            (element) {
              String url = element.url;
              return GestureDetector(
                onTap: () {
                  _viewThumb(url, _hinhAnhListModel.indexOf(element), element.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(7),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      'http://nhadat.imark.vn/$url',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
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
                        _onChanged = true;
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
                        _onChanged = true;
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
                        _onChanged = true;
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
                          _onChanged = true;
                          mezzanineValue = data.value;
                          mezzanineGroup = data.index;
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
                        _onChanged = true;
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
                        _onChanged = true;
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
                            _onChanged = true;
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
                          _onChanged = true;
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
                            _onChanged = true;
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
                          _onChanged = true;
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
                  child: Text(valWccNum.toString()),
                ),
                Material(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valWccNum++;
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
    );
  }
}
