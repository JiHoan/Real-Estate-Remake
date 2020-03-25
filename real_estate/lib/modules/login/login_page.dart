import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/authentication/bloc/authentication.dart';
import 'package:real_estate/modules/login/bloc/login.dart';
import 'package:real_estate/modules/login/repository/login_repository.dart';
import 'package:real_estate/utils/input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  LoginRepository _loginRepository = LoginRepository();
  AuthenticationBloc _authenticationBloc;

  TextEditingController _ctlUsername = TextEditingController();
  TextEditingController _ctlPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(loginRepository: _loginRepository);

    _ctlUsername.text = 'admin';
    _ctlPassword.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener(
          bloc: _loginBloc,
          listener: (BuildContext context, LoginState state) {
            print(state);
            if (state is LoginSuccess) {
              //TODO
              _authenticationBloc.add(LoggedIn(token: state.token));
            }
            if (state is LoginFailure) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xffF8A200),
              image: DecorationImage(
                image: AssetImage("assets/1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(),
                ),
                MyInput(
                  hintText: 'Tài khoản',
                  color: Color(0xffFCE0AB),
                  lines: 1,
                  controller: _ctlUsername,
                ),
                SizedBox(height: 5),
                Container(
                  height: 45,
                  child: TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                    controller: _ctlPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      filled: true,
                      fillColor: Color(0xffFCE0AB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  child: InkWell(
                    onTap: () {
                      _loginBloc.add(
                        Login(username: _ctlUsername.text, password: _ctlPassword.text),
                      );
                    },
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: BlocBuilder(
                        bloc: _loginBloc,
                        builder: (BuildContext context, LoginState state) {
                          if (state is LoginLoading) {
                            return CircularProgressIndicator();
                          }
                          return Text('Đăng nhập');
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Design by Imark',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
