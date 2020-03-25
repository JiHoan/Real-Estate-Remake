import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginEvent extends Equatable{
  @override
  List<Object> get props => null;
}

class Login extends LoginEvent{
  final String username;
  final String password;

  Login({@required this.username,@required this.password});

  @override
  String toString() {
    // TODO: implement toString
    return 'login {username: $username, password: $password}';
  }
}