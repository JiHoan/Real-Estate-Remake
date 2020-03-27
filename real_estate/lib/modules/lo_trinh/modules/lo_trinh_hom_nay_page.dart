import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/lo_trinh/bloc/lo_trinh.dart';
import 'package:real_estate/modules/lo_trinh/model/lo_trinh_model.dart';
import 'package:real_estate/modules/lo_trinh/modules/lich_su_lo_trinh_page.dart';
import 'package:real_estate/utils/style.dart';

class LoTrinhHomNayPage extends StatefulWidget {
  @override
  _LoTrinhHomNayPageState createState() => _LoTrinhHomNayPageState();
}

class _LoTrinhHomNayPageState extends State<LoTrinhHomNayPage> {
  LoTrinhBloc _loTrinhBloc;
  final f = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _loTrinhBloc = LoTrinhBloc();
    _loTrinhBloc.add(FetchDsLoTrinhHomNay());
  }

  @override
  void dispose() {
    super.dispose();
    _loTrinhBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Lộ trình hôm nay'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LichSuLoTrinh()));
              },
              borderRadius: BorderRadius.circular(5),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Lịch sử'.toUpperCase(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  _loTrinhBloc.add(XoaLoTrinh(id: 'ALL'));
                  _loTrinhBloc.add(FetchDsLoTrinhHomNay());
                },
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 25,
                  width: 75,
                  alignment: Alignment.center,
                  child: Text('Xóa hết'),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder(
              bloc: _loTrinhBloc,
              builder: (context, state) {
                print(state);
                if (state is LoTrinhLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is LoTrinhEmpty) {
                  return Center(
                    child: Text('Chưa có thông tin lộ trình hôm nay.'),
                  );
                }
                if (state is LoTrinhSuccess) {
                  LoTrinhListModel list = state.listModel;

                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableBehindActionPane(),
                        actionExtentRatio: 0.25,
                        actions: <Widget>[
                          list[index].status == 'NOT_GO'
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: IconSlideAction(
                                    caption: 'Đã xong',
                                    color: Colors.green,
                                    icon: Icons.check,
                                    onTap: () {
                                      _loTrinhBloc.add(CheckInLoTrinh(id: list[index].info.id.toString(), type: 'ADD'));
                                    },
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: IconSlideAction(
                                    caption: 'Hủy check',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {
                                      _loTrinhBloc.add(CheckInLoTrinh(id: list[index].info.id.toString(), type: 'REMOVE'));
                                    },
                                  ),
                                ),
                        ],
                        secondaryActions: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: IconSlideAction(
                              caption: 'Xóa',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                _loTrinhBloc.add(XoaLoTrinh(id: list[index].info.id.toString()));
                              },
                            ),
                          ),
                        ],
                        child: _buildItem(list[index]),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: list.length,
                  );
                }
                return Center(
                  child: Text('Chưa có thông tin lộ trình hôm nay.'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Material _buildItem(LoTrinhModel element) {
    return Material(
      color: Color(0xffEDEDED),
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          element.info.diaChi,
                          style: TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          element.info.ketCau,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      Text(
                        'Note: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          element.info.ghiChu,
                          style: TextStyle(color: Color(0xff259B39)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 70),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    element.info.gia.toString(),
                    style: MyAppStyle.price,
                  ),
                ],
              ),
            ),
            element.status == 'WENT'
                ? Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        _loTrinhBloc.add(XoaLoTrinh(id: element.info.id.toString()));
                        _loTrinhBloc.add(FetchDsLoTrinhHomNay());
                      },
                      child: Image.asset(
                        'assets/tick.png',
                        width: 20,
                      ),
                    ),
                  )
                : Positioned(
                    top: 10,
                    right: 10,
                    child: SizedBox(),
                  ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Text(f.format(DateTime.now())),
            ),
          ],
        ),
      ),
    );
  }
}
