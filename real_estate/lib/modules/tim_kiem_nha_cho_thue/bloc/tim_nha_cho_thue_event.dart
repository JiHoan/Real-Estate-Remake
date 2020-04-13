import 'package:equatable/equatable.dart';

class TimNhaChoThueEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class TimNhaChoThue extends TimNhaChoThueEvent {
  // ttcb
  final String quan;
  final String phuong;
  final String duong;
  final double dienTich;
  final int giaMin;
  final int giaMax;
  final String thanhPho;
  // ttnc
  final String soLau;
  final String lung;
  final String ham;
  final String sanThuong;
  final String soPhong;
  final String soWCR;
  final String soWCC;
  final String thangMay;
  final String thoatHiem;
  final String huongNha;

  TimNhaChoThue({this.quan, this.phuong, this.duong, this.dienTich, this.giaMin, this.giaMax, this.thanhPho, this.soLau, this.lung, this.ham, this.sanThuong, this.soPhong, this.soWCR, this.soWCC, this.thangMay, this.thoatHiem, this.huongNha});

  @override
  List<Object> get props => [quan, phuong, duong, dienTich, giaMin, giaMax, thanhPho, soLau, lung, ham, sanThuong, soPhong, soWCR, soWCC, thangMay, thoatHiem, huongNha];
}
