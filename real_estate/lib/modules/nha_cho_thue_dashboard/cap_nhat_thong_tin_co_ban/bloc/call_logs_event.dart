import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CallLogsEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class GetCallLogs extends CallLogsEvent {
  final int id;

  GetCallLogs({@required this.id});

  @override
  List<Object> get props => [id];
}