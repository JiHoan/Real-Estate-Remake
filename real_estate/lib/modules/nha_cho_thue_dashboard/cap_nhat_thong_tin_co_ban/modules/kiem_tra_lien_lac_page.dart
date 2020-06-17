import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/call_logs.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/bloc/cap_nhat_ttcb.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/call_model.dart';
import 'package:real_estate/utils/button.dart';
import 'package:real_estate/utils/my_dialog.dart';
import 'package:real_estate/utils/my_radio_button.dart';
import 'package:real_estate/utils/my_text.dart';
import 'package:real_estate/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';

class KiemTraLienLac extends StatefulWidget {
  final int id;
  final String phone;

  const KiemTraLienLac({Key key,@required this.id,@required this.phone}) : super(key: key);

  @override
  _KiemTraLienLacState createState() => _KiemTraLienLacState();
}

class _KiemTraLienLacState extends State<KiemTraLienLac> {
  TextEditingController ctlGhiChu = TextEditingController();
  String rdValue;
  int rdGroup;
  List<MyRadioList> list = [
    MyRadioList(index: 0, title: 'Không liên lạc được', value: 'KHONG_LIEN_LAC_DUOC'),
    MyRadioList(index: 1, title: 'Liên hệ thành công', value: 'DA_LIEN_LAC'),
  ];

  CapNhatTtcbBloc _capNhatTtcbBloc;
  CallLogsBloc _callLogsBloc;
  bool _changed = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showProgressDialog(context, _keyLoader);
      _capNhatTtcbBloc.add(CapNhaCall(id: widget.id, note: ctlGhiChu.text, status: rdValue));
    } catch (error) {
      print(error);
    }
  }

  String phoneNumber;

  @override
  void initState() {
    super.initState();
    _capNhatTtcbBloc = CapNhatTtcbBloc();
    _callLogsBloc = CallLogsBloc();
    _callLogsBloc.add(GetCallLogs(id: widget.id));

    rdValue = list[0].value;
    rdGroup = 0;

    phoneNumber = widget.phone;
  }

  @override
  void dispose() {
    super.dispose();
    _capNhatTtcbBloc.close();
    _callLogsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Liên hệ'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            FloatingActionButton(
              onPressed: () {
                launch("tel:$phoneNumber");
//              launch("tel:$phoneNumber");
              },
              elevation: 0.0,
              backgroundColor: Colors.white,
              child: Image.asset('assets/phone.png', height: 20),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyTopTitle(text: 'Mô tả'),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: list.map((element){
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                        child: Radio(
                          groupValue: rdGroup,
                          value: element.index,
                          activeColor: Color(0xff3FBF55),
                          onChanged: (val) {
                            setState(
                                  () {
//                              _onChanged = true;
                                rdValue = element.value;
                                rdGroup = element.index;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 7),
                      Expanded(child: Text(element.title, overflow: TextOverflow.ellipsis)),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              MyTopTitle(text: 'Ghi chú'),
              TextFormField(
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                maxLines: 2,
                controller: ctlGhiChu,
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
              BlocListener(
                bloc: _capNhatTtcbBloc,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
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
              Divider(
                color: Colors.black12,
              ),
              SizedBox(height: 10),
              Text('Lịch sử liên lạc'.toUpperCase(), style: MyAppStyle.price),
              SizedBox(height: 15),
              Expanded(
                child: BlocBuilder(
                  bloc: _callLogsBloc,
                  builder: (context, state){
                    if(state is FetchLoading){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(state is FetchEmpty){
                      return Center(
                        child: Text('Chưa có lịch sử cuộc gọi.'),
                      );
                    }
                    if(state is CallLogsLoaded){
                      final listModel = state.callLogsListModel;
                      return Center(
                        child: danhSachLichSuCuocGoi(listModel),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView danhSachLichSuCuocGoi(CallLogsListModel listModel){
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: listModel.length,
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemBuilder: (context, index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(listModel[index].status, style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text(DateFormat("dd/MM/yyyy hh:mm").format(listModel[index].createdAt)),
                ],
              ),
              Text(listModel[index].note),
            ],
          );
        },
    );
  }
}
