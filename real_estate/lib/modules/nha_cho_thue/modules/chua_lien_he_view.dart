import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/modules/nha_cho_thue/bloc/nha_cho_thue.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/nha_cho_thue_dashboard_page.dart';
import 'package:real_estate/utils/bottom_loading.dart';
import 'package:real_estate/utils/style.dart';

class ChuaLienHeView extends StatefulWidget {
  @override
  _ChuaLienHeViewState createState() => _ChuaLienHeViewState();
}

class _ChuaLienHeViewState extends State<ChuaLienHeView> {
  NhaChoThueBloc _nhaChoThueBloc;

  final f = DateFormat('dd/MM/yyyy');

  final _scrollController = ScrollController();
  final _scrollThreshold = 0.0;

  @override
  void initState() {
    super.initState();

    _nhaChoThueBloc = NhaChoThueBloc();
    _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: 'CHUA_LIEN_HE'));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _nhaChoThueBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _nhaChoThueBloc.add(LoadMoreDanhSachNhaChoThue(type: 'CHUA_LIEN_HE'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _nhaChoThueBloc,
      builder: (BuildContext context, NhaChoThueState state) {
        print(state);
        if (state is NhaChoThueLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NhaChoThueLoaded) {
          if (state.nhaChoThueListModel.isEmpty) {
            return Center(
              child: Text('Không có dữ liệu !'),
            );
          }
          return buildListNhaChoThue(state);
        }
        return Container();
      },
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
                          _nhaChoThueBloc.add(FetchDanhSachNhaChoThue(type: 'CHUA_LIEN_HE'));
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
                            Text(f.format(state.nhaChoThueListModel[index].createdAt)),
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
