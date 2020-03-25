import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/models/user_model.dart';

class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  UserModel userModel;

  HomeSuccess({@required this.userModel});
}
