import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/tim_kiem_nha_cho_thue/repository/tim_nha_cho_thue_repository.dart';
import 'tim_nha_cho_thue.dart';

class TimNhaChoThueBloc extends Bloc<TimNhaChoThueEvent, TimNhaChoThueState> {
  TimNhaChoThueRepository _timNhaChoThueRepository = TimNhaChoThueRepository();

  @override
  TimNhaChoThueState get initialState => TimNhaChoThueInitial();

  @override
  Stream<TimNhaChoThueState> mapEventToState(TimNhaChoThueEvent event) async* {
    if (event is TimNhaChoThue) {
      yield TimNhaChoThueLoading();

      print(event.giaMin);
      try {
        final danhSach = await _timNhaChoThueRepository.timNhaChoThue(
          quan: event.quan,
          phuong: event.phuong,
          duong: event.duong,
          dienTich: event.dienTich,
          min: event.giaMin,
          max: event.giaMax,
          thanhPho: event.thanhPho,
          soLau: event.soLau,
          lung: event.lung,
          ham: event.ham,
          sanThuong: event.sanThuong,
          soPhong: event.soPhong,
          soWCR: event.soWCR,
          soWCC: event.soWCC,
          thangMay: event.thangMay,
          thoatHiem: event.thoatHiem,
          huongNha: event.huongNha,
        );

        if (danhSach.isNotEmpty) {
          yield TimNhaChoThueLoaded(list: danhSach);
        } else {
          yield TimNhaChoThueEmpty();
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield TimNhaChoThueFailure();
      }
    }
  }
}
