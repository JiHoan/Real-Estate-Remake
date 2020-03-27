import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/lo_trinh/bloc/lo_trinh.dart';
import 'package:real_estate/modules/lo_trinh/model/lo_trinh_model.dart';
import 'package:real_estate/utils/my_text.dart';
import 'package:real_estate/utils/style.dart';
import 'package:timezone/standalone.dart';

class LichSuLoTrinh extends StatefulWidget {
  @override
  _LichSuLoTrinhState createState() => _LichSuLoTrinhState();
}

class _LichSuLoTrinhState extends State<LichSuLoTrinh> {
  DateTime selectedDate = DateTime.now();
  final f = DateFormat('dd/MM/yyyy');

//  var format = DateFormat.yMd('vi');

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    print(selectedDate);
//    print(format.format(selectedDate));
    print(selectedDate.toUtc().millisecondsSinceEpoch ~/ 1000);
  }

  LoTrinhBloc _loTrinhBloc;

  @override
  void initState() {
    super.initState();
    _loTrinhBloc = LoTrinhBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _loTrinhBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử lộ trình'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: MyTopTitle(text: 'Chọn ngày'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 7),
                    child: Material(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(7),
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          height: 45,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(f.format(selectedDate)),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Material(
                      color: Color(0xff3FBF55),
                      borderRadius: BorderRadius.circular(7),
                      child: InkWell(
                        onTap: () {
                          _loTrinhBloc.add(FetchDsLichSuLoTrinh(date: selectedDate));
                        },
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          child: Text(
                            'Tìm',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //
            Expanded(
              child: BlocBuilder(
                bloc: _loTrinhBloc,
                builder: (context, state) {
                  if (state is LoTrinhLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is LoTrinhEmpty) {
                    return Center(
                      child: Text('Ngày được chọn không có lộ trình.'),
                    );
                  }
                  if (state is LoTrinhSuccess) {
                    return Center(
                      child: _buildList(state.listModel),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildList(LoTrinhListModel list) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      itemBuilder: (context, index) {
        final element = list[index];
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
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: list.length,
    );
  }
}
