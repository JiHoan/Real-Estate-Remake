import 'package:equatable/equatable.dart';

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
  @override
  String toString() {
    return 'Authentication Authenticated';
  }
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Authentication Unauthenticated';
  }
}