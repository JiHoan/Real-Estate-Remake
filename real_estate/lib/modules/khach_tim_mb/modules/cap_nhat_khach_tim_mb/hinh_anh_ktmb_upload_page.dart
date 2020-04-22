import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';

class HinhAnhKtmbUploadPage extends StatefulWidget {
  final int id;

  const HinhAnhKtmbUploadPage({Key key, @required this.id}) : super(key: key);

  @override
  _HinhAnhKtmbUploadPageState createState() => _HinhAnhKtmbUploadPageState();
}

class _HinhAnhKtmbUploadPageState extends State<HinhAnhKtmbUploadPage> {
  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Máy ảnh'),
                onPressed: () {
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

    setState(() {
      images = resultList;
    });

    addToListImg(images);
  }

  Future addToListImg(List<Asset> list) async {
    File file;
    File compressedFile;

    return list.map((element) async {
      file = await writeByteDataToFile(await element.getByteData(quality: 100));

      compressedFile = await FlutterNativeImage.compressImage(file.path, quality: 100, targetWidth: 600, targetHeight: 600);

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
    return File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  KhachTimMbBloc _khachTimMbBloc;
  bool _changed = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _khachTimMbBloc.add(UploadHinhAnh(id: widget.id, hinhAnh: _listImg));
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
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
        title: Text('Upload hình ảnh'),
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
            child: Material(
              color: Color(0xff41BC00),
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {
                  _showDialog();
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset('assets/camera.png'),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              primary: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              crossAxisCount: 5,
              physics: BouncingScrollPhysics(),
              children: _listImg.map((element) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.file(
                          element,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _listImg.removeAt(_listImg.indexOf(element));
                            });
                          },
                          child: Image.asset('assets/close.png'),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          _listImg.length < 1
              ? MyButtonDisable()
              : BlocListener(
                  bloc: _khachTimMbBloc,
                  listener: (context, state) {
                    if (state is KhachTimMbSuccess) {
                      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop(); // close dialog
                      Navigator.pop(context, _changed); // pop về dashboard
                      Dialogs.showAddSuccessToast();
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
}
