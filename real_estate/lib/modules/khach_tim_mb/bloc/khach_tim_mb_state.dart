import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/modules/khach_tim_mb/model/detail_ktmb_model.dart';
import 'package:real_estate/modules/khach_tim_mb/model/khach_tim_mb_model.dart';

class KhachTimMbState extends Equatable {
  @override
  List<Object> get props => null;
}

class KhachTimMbInitial extends KhachTimMbState {}

class KhachTimMbLoading extends KhachTimMbState {}

class KhachTimMbLoaded extends KhachTimMbState {
  final KhachTimMbListModel khachTimMbListModel;
  final bool hasReachedMax;
  final int page;

  KhachTimMbLoaded({@required this.khachTimMbListModel, this.hasReachedMax, this.page});

  KhachTimMbLoaded copyWith({
    KhachTimMbListModel khachTimMbListModel,
    bool hasReachedMax,
  }) {
    return KhachTimMbLoaded(
      khachTimMbListModel: khachTimMbListModel ?? this.khachTimMbListModel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [khachTimMbListModel, hasReachedMax, page];
}

class KhachTimMbEmpty extends KhachTimMbState {}

class KhachTimMbSuccess extends KhachTimMbState {}

class KhachTimMbFailure extends KhachTimMbState {
  final error;

  KhachTimMbFailure({this.error});

  @override
  List<Object> get props => error;
}

class DetailKhachTimMbLoaded extends KhachTimMbState{
  final DetailKtmbModel model;

  DetailKhachTimMbLoaded({@required this.model});

  @override
  List<Object> get props => [model];
}
