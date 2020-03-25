import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => null;
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({@required this.token});

  @override
  String toString() => 'LoginInitial';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({this.error});

  @override
  String toString() => 'LoginInitial';
}
