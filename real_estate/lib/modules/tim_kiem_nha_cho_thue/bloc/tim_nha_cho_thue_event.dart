import 'package:equatable/equatable.dart';

class TimNhaChoThueEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class TimNhaChoThueCoBan extends TimNhaChoThueEvent {
  final String quan;
  final String phuong;
  final String duong;
  final double dienTich;
  final int giaMin;
  final int giaMax;
  final String thanhPho;

  TimNhaChoThueCoBan({this.quan, this.phuong, this.duong, this.dienTich, this.giaMin, this.giaMax, this.thanhPho});

  @override
  List<Object> get props => [quan, phuong, duong, dienTich, giaMin, giaMax, thanhPho];
}
