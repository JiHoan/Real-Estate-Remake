import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object> get props => null;
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'Authentication Uninitialized';
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;

  AuthenticationAuthenticated({@required this.token});

  @override
  String toString() {
    return 'Authentication Authenticated';
  }
}

class AuthenticationUnauthenticated extends AuthenticationState {
  // default type = 0 ? Logout : ShutDown
  final int type;

  AuthenticationUnauthenticated({this.type = 0});

  @override
  String toString() {
    return 'Authentication Unauthenticated';
  }
}