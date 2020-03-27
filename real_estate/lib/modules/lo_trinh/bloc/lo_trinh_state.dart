import 'package:equatable/equatable.dart';
import 'package:real_estate/modules/lo_trinh/model/lo_trinh_model.dart';

class LoTrinhState extends Equatable {
  @override
  List<Object> get props => null;
}

class LoTrinhInitial extends LoTrinhState {}

class LoTrinhLoading extends LoTrinhState {}

class LoTrinhEmpty extends LoTrinhState {
}

class LoTrinhFailure extends LoTrinhState {
  final String error;

  LoTrinhFailure({this.error});

  @override
  List<Object> get props => [error];
}

class LoTrinhSuccess extends LoTrinhState {
  final LoTrinhListModel listModel;

  LoTrinhSuccess({this.listModel});

  @override
  List<Object> get props => [listModel];
}
