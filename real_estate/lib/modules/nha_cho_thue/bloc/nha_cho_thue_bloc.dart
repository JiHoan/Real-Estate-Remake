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
        final _listNhaKhongXacDinh = await _nhaChoThueApiProvider.getNhaChoThue(type: event.type, page: temp);

        if (_listNhaKhongXacDinh.nhaChoThueListModel.isNotEmpty) {
          yield NhaChoThueLoaded(
              nhaChoThueListModel: _listNhaKhongXacDinh.nhaChoThueListModel, hasReachedMax: _reachedMax(_listNhaKhongXacDinh.nhaChoThueListModel.length), count: _listNhaKhongXacDinh.count);
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

    if (event is LoadMoreDanhSachNhaChoThue && !_hasReachedMax(state)) {
      try {
        if (currentState is NhaChoThueInitial) {
          final _listNhaKhongXacDinh = await _nhaChoThueApiProvider.getNhaChoThue(type: event.type, page: 1);

          yield NhaChoThueLoaded(nhaChoThueListModel: _listNhaKhongXacDinh.nhaChoThueListModel, hasReachedMax: false, count: _listNhaKhongXacDinh.count);
          return;
        }

        if (currentState is NhaChoThueLoaded) {
          temp++;
          final _listNhaKhongXacDinh = await _nhaChoThueApiProvider.getNhaChoThue(type: event.type, page: temp);

          final copyListNhaKhongXacDinh = NhaChoThueListModel.fromJson(currentState.nhaChoThueListModel.toJson());

          yield _listNhaKhongXacDinh.nhaChoThueListModel.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : NhaChoThueLoaded(
                  nhaChoThueListModel: copyListNhaKhongXacDinh..addAll(_listNhaKhongXacDinh.nhaChoThueListModel),
                  hasReachedMax: true,
                  count: _listNhaKhongXacDinh.count,
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
    return length < 10 ? true : false;
  }
}
