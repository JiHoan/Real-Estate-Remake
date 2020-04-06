import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/modules/authentication/bloc/authentication.dart';
import 'package:real_estate/modules/authentication/repository/authentication_repository.dart';
import 'package:real_estate/modules/home/home_page.dart';
import 'package:real_estate/modules/login/login_page.dart';

class MyApplication extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;

  const MyApplication({Key key, @required this.authenticationRepository}) : super(key: key);

  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  AuthenticationBloc _authenticationBloc;
  AuthenticationRepository get _authenticationRepository => widget.authenticationRepository;

  ApiProvider apiProvider;

  @override
  void initState() {
    super.initState();

    ApiProvider.addInterceptor(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              print('connected');
            }
          } on SocketException catch (_) {
            print('not connected');
          }
        },
        onResponse: (Response resp) {
          if (resp.statusCode == 401) {
            print('Shut down: 401');
            _authenticationBloc.add(ShutDown());
          }
        },
      ),
    );

    _authenticationBloc = AuthenticationBloc(authenticationRepository: _authenticationRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _authenticationBloc,
      child: MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'HelveticaNeue',
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Color(0xffF8A200)),
            textTheme: TextTheme(
              title: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        home: BlocListener(
          bloc: _authenticationBloc,
          listener: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUnauthenticated) {
              /*Navigator.popUntil(context, ModalRoute.withName('/'));*/
              // type != 0 ? ShutDown :
              if(state.type != 0){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Thông báo'),
                        content: Text('Phiên đăng nhập đã kết thúc. Vui lòng đăng nhập lại !'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.popUntil(context, ModalRoute.withName('/'));
                            },
                            child: Text('Đồng ý'),
                          )
                        ],
                      );
                    }).then((_) {
                  if (mounted) {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                });
              }
            }
          },
          child: BlocBuilder(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              print(state);
              if (state is AuthenticationUnauthenticated) {
                return LoginPage();
              }
              if (state is AuthenticationAuthenticated) {
                ApiProvider.setBearerAuth(state.token);
                return HomePage();
              }
              return Container(//todo
                  );
            },
          ),
        ),
      ),
    );
  }
}
