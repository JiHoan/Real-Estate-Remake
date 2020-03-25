import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';
import 'package:real_estate/modules/nha_cho_thue/repository/nha_cho_thue_repository.dart';
import 'nha_cho_thue.dart';
import 'package:rxdart/rxdart.dart';

class NhaChoThueBloc extends Bloc<NhaChoThueEvent, NhaChoThueState> {
  NhaChoThueRepository _nhaChoThueApiProvider = NhaChoThueRepository();
  int temp = 1;

  @override
  Stream<NhaChoThueState> transformEvents(
      Stream<NhaChoThueEvent> events,
      Stream<NhaChoThueState> Function(NhaChoThueEvent event) next,
      ) {
    if(state is LoadMoreDanhSachNhaChoThue){
      return super.transformEvents(
        events.debounceTime(
          Duration(milliseconds: 500),
        ),
        next,
      );
    }
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 0),
      ),
      next,
    );
  }

  @override
  NhaChoThueState get initialState => NhaChoThueInitial();

  @override
  Stream<NhaChoThueState> mapEventToState(NhaChoThueEvent event) async* {
    final currentState = state;

    if (event is FetchDanhSachNhaChoThue) {
      yield NhaChoThueLoading();
      temp = 1;

      try {
        final _listNhaKhongXacDinh = await _nhaChoThueApiProvider.getNhaKhongXacDinh(type: event.type, page: temp);

        if (_listNhaKhongXacDinh.isNotEmpty) {
          yield NhaChoThueLoaded(
              nhaChoThueListModel: _listNhaKhongXacDinh, hasReachedMax: _reachedMax(_listNhaKhongXacDinh.length));
        } else {
          yield NhaChoThueEmpty();
        }
      } catch (e, s) {
        print(e);
        print(s);

        yield NhaChoThueFailure(error: e.toString());
      }
    }

    bool _hasReachedMax(NhaChoThueState state) => state is NhaChoThueLoaded && state.hasReachedMax;

    if (event is LoadMoreDanhSachNhaChoThue && _hasReachedMax(state)) {
      try {
        if (currentState is NhaChoThueInitial) {
          final _listNhaKhongXacDinh = await _nhaChoThueApiProvider.getNhaKhongXacDinh(type: event.type, page: 1);

          yield NhaChoThueLoaded(nhaChoThueListModel: _listNhaKhongXacDinh, hasReachedMax: false);
          return;
        }

        if (currentState is NhaChoThueLoaded) {
          temp++;
          final _listNhaKhongXacDinh = await _nhaChoThueApiProvider.getNhaKhongXacDinh(type: event.type, page: temp);

          final copyListNhaKhongXacDinh = NhaChoThueListModel.fromJson(currentState.nhaChoThueListModel.toJson());

          print(copyListNhaKhongXacDinh);

          yield _listNhaKhongXacDinh.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : NhaChoThueLoaded(
                  nhaChoThueListModel: copyListNhaKhongXacDinh..addAll(_listNhaKhongXacDinh),
                  hasReachedMax: true,
                );
        }
      } catch (e, s) {
        print(e);
        print(s);
        yield NhaChoThueFailure(error: e.toString());
      }
    }
  }

  bool _reachedMax(int length) {
    print('length: $length');
    return length < 11 ? true : false;
  }
}
