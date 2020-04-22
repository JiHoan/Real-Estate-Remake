import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/models/hinh_anh_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_nang_cao/bloc/cap_nhat_ttnc.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';

class HinhAnhNhaChoThueUpdatePage extends StatefulWidget {
  final int id;
  final HinhAnhListModel listHinhAnh;

  const HinhAnhNhaChoThueUpdatePage({Key key, @required this.id, @required this.listHinhAnh}) : super(key: key);

  @override
  _HinhAnhNhaChoThueUpdatePageState createState() => _HinhAnhNhaChoThueUpdatePageState();
}

class _HinhAnhNhaChoThueUpdatePageState extends State<HinhAnhNhaChoThueUpdatePage> {
  CapNhatTtncBloc _capNhatTtncBloc;

  bool _onChanged = false;
  bool _changed = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtncBloc.add(RemoveHinhAnhNha(id: widget.id, hinhAnhId: _listHinhAnhId));
    } catch (error) {
      print(error);
    }
  }

  HinhAnhListModel _hinhAnhListModel = HinhAnhListModel.fromJson([]);
  List<int> _listHinhAnhId = List<int>();

  _viewThumb(String url, int index, int idHinh) {
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
                      _onChanged = true;
                      _hinhAnhListModel.removeAt(index);
                      _listHinhAnhId.add(idHinh);
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

  @override
  void initState() {
    super.initState();

    _capNhatTtncBloc = CapNhatTtncBloc();

    _hinhAnhListModel.addAll(widget.listHinhAnh);
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
        title: Text('Hình ảnh nhà'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              children: _hinhAnhListModel.map((element) {
                String url = element.url;
                return GestureDetector(
                  onTap: (){
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
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
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
                Dialogs.showRemoveSuccessToast();
              }
              if (state is UpdateFailure) {
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
//                  _capNhatTtncBloc.add(UploadHinhAnhNha(id: widget.id, hinhAnh: _listImg));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
