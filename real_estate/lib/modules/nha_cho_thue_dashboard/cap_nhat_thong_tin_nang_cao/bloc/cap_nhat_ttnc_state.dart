import 'package:equatable/equatable.dart';

class CapNhatTtncState extends Equatable {
  @override
  List<Object> get props => null;
}

class CapNhatTtncInitial extends CapNhatTtncState {}

// UPDATE
class UpdateLoading extends CapNhatTtncState {}

class UpdateSuccess extends CapNhatTtncState {}

class UpdateFailure extends CapNhatTtncState {
  final String error;

  UpdateFailure({this.error});

  @override
  List<Object> get props => [error];
}