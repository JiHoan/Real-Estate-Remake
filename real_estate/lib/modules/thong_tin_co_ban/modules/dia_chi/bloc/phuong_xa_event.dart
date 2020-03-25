import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PhuongXaEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PhuongXaFetch extends PhuongXaEvent {
  final String id;

  PhuongXaFetch({@required this.id});

  @override
  List<Object> get props => [id];
}
