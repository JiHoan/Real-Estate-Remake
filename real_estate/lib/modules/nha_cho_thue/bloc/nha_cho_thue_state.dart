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
  final int count;

  NhaChoThueLoaded({@required this.nhaChoThueListModel, @required this.hasReachedMax, this.count});

  NhaChoThueLoaded copyWith({
    NhaChoThueListModel nhaChoThueListModel,
    bool hasReachedMax,
  }) {
    return NhaChoThueLoaded(
      nhaChoThueListModel: nhaChoThueListModel ?? this.nhaChoThueListModel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      count: count ?? this.count,
    );
  }

  @override
  List<Object> get props => [nhaChoThueListModel, hasReachedMax, count];
}

class NhaChoThueSuccess extends NhaChoThueState {}

class NhaChoThueEmpty extends NhaChoThueState {}

class NhaChoThueFailure extends NhaChoThueState {
  final error;

  NhaChoThueFailure({this.error});

  @override
  List<Object> get props => error;
}
