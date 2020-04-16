import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dia_chi.dart';
import 'model/tinh_thanh_pho_model.dart';

class TimTinhTpPage extends StatefulWidget {
  @override
  _TimTinhTpPageState createState() => _TimTinhTpPageState();
}

class _TimTinhTpPageState extends State<TimTinhTpPage> {
  TinhThanhPhoBloc _tinhThanhPhoBloc;
  TextEditingController ctlSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tinhThanhPhoBloc = TinhThanhPhoBloc();
    _tinhThanhPhoBloc.add(TinhThanhPhoFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder(
          bloc: _tinhThanhPhoBloc,
          builder: (BuildContext context, TinhThanhPhoState state) {
            print(state);
            if (state is TinhThanhPhoLoading) {
              return buildMainPage(context, null, 'loading');
            }
            if (state is TinhThanhPhoSuccess) {
              return buildMainPage(context, state.tinhThanhPhoListModel, 'success');
            }
            if (state is TinhThanhPhoAutocomplete) {
              return buildMainPage(context, state.tinhThanhPhoListModel, 'autocomplete');
            }
            return Center(
              child: Text('Bloc failure!!!'.toUpperCase()),
            );
          },
        ),
      ),
    );
  }

  /*Column buildSuccess(BuildContext context, TinhThanhPhoListModel listModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 15, top: 15, bottom: 20),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Color(0xffF8A200),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 45,
                  child: TextFormField(
                    onChanged: (value) {
                      _tinhThanhPhoBloc.add(TinhThanhPhoSearch(tinhThanhPhoListModel: listModel, value: value));
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Nhập tên Tỉnh cần tìm',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      filled: true,
                      fillColor: Color(0xffEDEDED),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildAutocomplete(BuildContext context, TinhThanhPhoListModel listModel) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 15, top: 15, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Color(0xffF8A200),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 45,
                  child: TextFormField(
                    onChanged: (value) {
                      _tinhThanhPhoBloc.add(TinhThanhPhoSearch(tinhThanhPhoListModel: listModel, value: value));
                    },
                    controller: ctlSearch,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Nhập tên Tỉnh cần tìm',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      filled: true,
                      fillColor: Color(0xffEDEDED),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listModel.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (context, index) {
              return Material(
                color: Colors.white,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context, listModel[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(listModel[index].name),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }*/
  Column buildMainPage(BuildContext context, TinhThanhPhoListModel listModel, String state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 15, top: 15, bottom: 20),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Color(0xffF8A200),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 45,
                  child: TextFormField(
                    enabled: state == 'loading' ? false : true,
                    style: TextStyle(color: Colors.black87),
                    onChanged: (value) {
                      _tinhThanhPhoBloc.add(TinhThanhPhoSearch(tinhThanhPhoListModel: listModel, value: value));
                    },
                    decoration: InputDecoration(
                      hintText: 'Nhập tên Tỉnh cần tìm',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      filled: true,
                      fillColor: Color(0xffEDEDED),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        state == 'loading'
            ? Text('Đang tải dữ liệu...')
            : state == 'success'
                ? SizedBox()
                : Expanded(
                    child: ListView.builder(
                      itemCount: listModel.length,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, listModel[index]);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(listModel[index].name),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ],
    );
  }
}
