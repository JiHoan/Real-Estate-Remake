import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AuthenticationEvent extends Equatable{
  @override
  List<Object> get props => null;
}

class AppStarted extends AuthenticationEvent{
  @override
  String toString() {
    return 'AppStarted';
  }
}
class LoggedIn extends AuthenticationEvent{
  final String token;

  LoggedIn({@required this.token});

  @override
  String toString() => 'LoggedIn: token $token';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}