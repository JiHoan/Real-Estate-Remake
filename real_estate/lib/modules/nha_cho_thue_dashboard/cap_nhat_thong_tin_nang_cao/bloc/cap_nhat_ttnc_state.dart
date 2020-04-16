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

// DOWNLOAD
class DownloadLoading extends CapNhatTtncState {}

class DownloadSuccess extends CapNhatTtncState {
  final String url;

  DownloadSuccess({this.url});
}

class DownloadFailure extends CapNhatTtncState {
  final String error;

  DownloadFailure({this.error});

  @override
  List<Object> get props => [error];
}