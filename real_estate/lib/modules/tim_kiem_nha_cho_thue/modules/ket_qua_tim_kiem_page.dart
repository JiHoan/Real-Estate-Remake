import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/nha_cho_thue/bloc/nha_cho_thue.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/nha_cho_thue_dashboard_page.dart';
import 'package:real_estate/utils/style.dart';

class KetQuaTimKiemPage extends StatefulWidget {
  final NhaChoThueListModel list;

  const KetQuaTimKiemPage({Key key, @required this.list}) : super(key: key);

  @override
  _KetQuaTimKiemPageState createState() => _KetQuaTimKiemPageState();
}

class _KetQuaTimKiemPageState extends State<KetQuaTimKiemPage> {
  NhaChoThueBloc _nhaChoThueBloc;
  final f = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _nhaChoThueBloc = NhaChoThueBloc();
  }

  @override
  void dispose() {
    _nhaChoThueBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm'),
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
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, bottom: 10, top: 10),
            child: Row(
              children: <Widget>[
                Text('Kết quả: '),
                widget.list == null ? Text('0') : Text(widget.list.length.toString()),
              ],
            ),
          ),
          Expanded(
            child: widget.list == null ? Center(child: Text('Không có dữ liệu phù hợp.')) : buildListNhaChoThue(widget.list),
          ),
        ],
      ),
    );
  }

  ListView buildListNhaChoThue(NhaChoThueListModel list) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8,
        );
      },
      itemBuilder: (context, index) {
        return Material(
          color: Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NhaChoThueDashboardPage(
                    nhaChoThueModelId: list[index].id,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(7),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    list[index].diaChi,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    list[index].ketCau,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Text('Note: ', style: TextStyle(fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text(
                          list[index].ghiChu,
                          style: TextStyle(color: Colors.green),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(list[index].gia.toString(), style: MyAppStyle.price),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
//                      Text(f.format(state.nhaChoThueListModel[index].createdAt)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FilterList {
  String name;
  int index;
  String type;

  FilterList({this.name, this.index, this.type});
}
