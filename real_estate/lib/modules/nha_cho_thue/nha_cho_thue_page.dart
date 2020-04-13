import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/nha_cho_thue/bloc/nha_cho_thue.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/nha_cho_thue_dashboard_page.dart';
import 'package:real_estate/utils/bottom_loading.dart';
import 'package:real_estate/utils/style.dart';

class NhaChoThuePage extends StatefulWidget {
  @override
  _NhaChoThuePageState createState() => _NhaChoThuePageState();
}

class _NhaChoThuePageState extends State<NhaChoThuePage> {
  String radioItem = 'Chưa có thông tin nâng cao';
  int id = 1;
  String type = 'KHONG_CO_THONG_TIN_NANG_CAO';
  List<FilterList> fList = [
    FilterList(
      index: 1,
      name: "Chưa có thông tin nâng cao",
      type: 'KHONG_CO_THONG_TIN_NANG_CAO',
    ),
    FilterList(
      index: 2,
      name: "Chưa thuê",
      type: 'CHUA_THUE',
    ),
    FilterList(
      index: 3,
      name: "Đã thuê",
      type: 'DA_THUE',
    ),
    FilterList(
      index: 4,
      name: "7 ngày chưa liên hệ",
      type: 'CHUA_CALL',
    ),
  ];

  NhaChoThueBloc _nhaChoThueBloc;

  final f = DateFormat('dd/MM/yyyy');

  final _scrollController = ScrollController();
  final _scrollThreshold = 0.0;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: fList
                .map((data) => GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            radioItem = data.name;
                            id = data.index;
                            type = data.type;

                            if (data.name == 'Chưa có thông tin nâng cao') {
                              _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: 'KHONG_CO_THONG_TIN_NANG_CAO'));
                            } else if (data.name == 'Chưa thuê') {
                              _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: 'CHUA_THUE'));
                            } else if (data.name == 'Đã thuê') {
                              _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: 'DA_THUE'));
                            } else {
                              _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: 'CHUA_CALL'));
                            }
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Wrap(
                        spacing: 7,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            width: 20,
                            child: Radio(
                              groupValue: id,
                              value: data.index,
                              onChanged: (val) {
                                setState(() {
                                  radioItem = data.name;
                                  id = data.index;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Text(data.name),
                        ],
                      ),
                    ))
                .toList(),
          ),
          actions: <Widget>[
            Material(
              color: Color(0xff3FBF55),
              borderRadius: BorderRadius.circular(7),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  child: Text(
                    'Hủy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _nhaChoThueBloc.add(LoadMoreDanhSachNhaChoThue(type: type));
    }
  }

  @override
  void initState() {
    super.initState();
    _nhaChoThueBloc = NhaChoThueBloc();
    _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: type));

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _nhaChoThueBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nhà cho thuê'),
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
                BlocBuilder(
                  bloc: _nhaChoThueBloc,
                  builder: (context, state){
                    if(state is NhaChoThueLoaded){
                      final length = state.nhaChoThueListModel.length;
                      return Text('Kết quả: $length');
                    }
                    return Text('Kết quả: 0');
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _showDialog();
                  },
                  child: Text(radioItem),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    _showDialog();
                  },
                  child: Image.asset('assets/filter.png'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder(
              bloc: _nhaChoThueBloc,
              builder: (BuildContext context, NhaChoThueState state) {
                print(state);
                if (state is NhaChoThueLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is NhaChoThueEmpty){
                  return Center(
                    child: Text('Chưa có dữ liệu.'),
                  );
                }
                if (state is NhaChoThueLoaded) {
                  return buildListNhaChoThue(state);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView buildListNhaChoThue(NhaChoThueLoaded state) {
    return ListView.separated(
      // 1 phân trang return 10 dòng, nếu trả ít hơn 11 thì k còn dữ liệu nên tắt scroll hạn chế spam event LoadMore
      controller: state.nhaChoThueListModel.length < 11 ? null : _scrollController,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: state.hasReachedMax ? state.nhaChoThueListModel.length : state.nhaChoThueListModel.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8,
        );
      },
      itemBuilder: (context, index) {
        return index >= state.nhaChoThueListModel.length
            ? BottomLoader()
            : Material(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(7),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NhaChoThueDashboardPage(
                          nhaChoThueModelId: state.nhaChoThueListModel[index].id,
                        ),
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: type));
                        }
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.nhaChoThueListModel[index].diaChi,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          state.nhaChoThueListModel[index].ketCau,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: <Widget>[
                            Text('Note: ', style: TextStyle(fontWeight: FontWeight.w600)),
                            Expanded(
                              child: Text(
                                state.nhaChoThueListModel[index].ghiChu,
                                style: TextStyle(color: Colors.green),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(state.nhaChoThueListModel[index].gia.toString(), style: MyAppStyle.price),
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
