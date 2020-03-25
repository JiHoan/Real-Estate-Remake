import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';

class NhaChoThueState extends Equatable {
  @override
  List<Object> get props => null;
}

class NhaChoThueInitial extends NhaChoThueState {}

class NhaChoThueLoading extends NhaChoThueState {}

class NhaChoThueLoaded extends NhaChoThueState {
  final NhaChoThueListModel nhaChoThueListModel;
  final bool hasReachedMax;

  NhaChoThueLoaded({@required this.nhaChoThueListModel, this.hasReachedMax});

  NhaChoThueLoaded copyWith({
    NhaChoThueListModel nhaChoThueListModel,
    bool hasReachedMax,
  }) {
    return NhaChoThueLoaded(
      nhaChoThueListModel: nhaChoThueListModel ?? this.nhaChoThueListModel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [nhaChoThueListModel, hasReachedMax];
}

class NhaChoThueEmpty extends NhaChoThueState {}

class NhaChoThueFailure extends NhaChoThueState {
  final error;

  NhaChoThueFailure({this.error});

  @override
  List<Object> get props => error;
}
