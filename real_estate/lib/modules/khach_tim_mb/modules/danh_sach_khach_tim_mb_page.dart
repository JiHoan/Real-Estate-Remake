import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/khach_tim_mb/bloc/khach_tim_mb.dart';
import 'package:real_estate/utils/bottom_loading.dart';
import 'package:real_estate/utils/style.dart';

import 'khach_tim_mb_dashboard_page.dart';

class DanhSachKhachTimMbPage extends StatefulWidget {
  @override
  _DanhSachKhachTimMbPageState createState() => _DanhSachKhachTimMbPageState();
}

class _DanhSachKhachTimMbPageState extends State<DanhSachKhachTimMbPage> {
  String radioItem = 'Tất cả';
  int id = 1;
  String type = '';
  List<FilterList> fList = [
    FilterList(
      index: 1,
      name: "Tất cả",
      type: '',
    ),
    FilterList(
      index: 2,
      name: "Bình thường",
      type: 'BINH_THUONG',
    ),
    FilterList(
      index: 3,
      name: "Cần gấp",
      type: 'CAN_GAP',
    ),
  ];

  KhachTimMbBloc _khachTimMbBloc;

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

                            if (data.name == 'Tất cả') {
                              _khachTimMbBloc.add(FetchDsKhachTimMb(type: ''));
                            } else if (data.name == 'Bình thường') {
                              _khachTimMbBloc.add(FetchDsKhachTimMb(type: 'BINH_THUONG'));
                            } else {
                              _khachTimMbBloc.add(FetchDsKhachTimMb(type: 'CAN_GAP'));
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
                            height: 32,
                            width: 20,
                            child: Radio(
                              groupValue: id,
                              value: data.index,
                              activeColor: Color(0xff3FBF55),
                              onChanged: (val) {
                                setState(() {
                                  radioItem = data.name;
                                  id = data.index;
                                  type = data.type;

                                  if (data.name == 'Tất cả') {
                                    _khachTimMbBloc.add(FetchDsKhachTimMb(type: ''));
                                  } else if (data.name == 'Bình thường') {
                                    _khachTimMbBloc.add(FetchDsKhachTimMb(type: 'BINH_THUONG'));
                                  } else {
                                    _khachTimMbBloc.add(FetchDsKhachTimMb(type: 'CAN_GAP'));
                                  }
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
        );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _khachTimMbBloc.add(LoadMoreDsKhachTimMb(type: type));
    }
  }

  @override
  void initState() {
    super.initState();
    _khachTimMbBloc = KhachTimMbBloc();
    _khachTimMbBloc.add(FetchDsKhachTimMb(type: type));

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _khachTimMbBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Khách tìm mặt bằng'),
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
                  bloc: _khachTimMbBloc,
                  builder: (context, state) {
                    if (state is KhachTimMbLoaded) {
                      final length = state.count;
                      return Text('Kết quả: $length');
                    }
                    return Text('Kết quả:');
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
                  child: Image.asset('assets/filter.png', height: 15),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder(
              bloc: _khachTimMbBloc,
              builder: (context, state) {
                print(state);
                if (state is KhachTimMbLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is KhachTimMbEmpty) {
                  return Center(
                    child: Text('Chưa có dữ liệu.'),
                  );
                }
                if (state is KhachTimMbLoaded) {
                  return buildDanhSach(state);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView buildDanhSach(KhachTimMbLoaded state) {
    return ListView.separated(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: state.hasReachedMax ? state.khachTimMbListModel.length : state.khachTimMbListModel.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8,
        );
      },
      itemBuilder: (context, index) {
        return index >= state.khachTimMbListModel.length
            ? BottomLoader()
            : Material(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(7),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KhachTimMbDashboardPage(
                          id: state.khachTimMbListModel[index].id,
                        ),
                      ),
                    ).then(
                          (value) {
                        if (value == true) {
                          _khachTimMbBloc.add(FetchDsKhachTimMb(type: type));
                        }
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              state.khachTimMbListModel[index].nguoiNhan,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              state.khachTimMbListModel[index].diaChi,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: <Widget>[
                                Text('${NumberFormat.currency(locale: 'vi', symbol: '').format(state.khachTimMbListModel[index].giaMin)}' , style: MyAppStyle.price1),
                                Text('- ', style: MyAppStyle.price),
                                Text('${NumberFormat.currency(locale: 'vi', symbol: 'vnđ').format(state.khachTimMbListModel[index].giaMax)}' , style: MyAppStyle.price1),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(f.format(state.khachTimMbListModel[index].createdAt)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      state.khachTimMbListModel[index].tinhTrang.value == 'CAN_GAP'
                          ? Positioned(
                              top: 10,
                              right: 15,
                              child: Image.asset('assets/star.png', height: 15),
                            )
                          : SizedBox()
                    ],
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
