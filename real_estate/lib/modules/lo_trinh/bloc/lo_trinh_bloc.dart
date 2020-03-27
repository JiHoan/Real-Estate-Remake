import 'package:bloc/bloc.dart';
import 'package:real_estate/modules/lo_trinh/repository/lo_trinh_repository.dart';
import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';
import 'lo_trinh.dart';

class LoTrinhBloc extends Bloc<LoTrinhEvent, LoTrinhState> {
  LoTrinhRepository _repository = LoTrinhRepository();

  @override
  LoTrinhState get initialState => LoTrinhInitial();

  @override
  Stream<LoTrinhState> mapEventToState(LoTrinhEvent event) async* {
    if(event is ThemLoTrinh){
      yield LoTrinhLoading();

      try{
        bool isSuccess = await _repository.themVaoLoTrinh(id: event.id);

        if(isSuccess == true){
          yield LoTrinhSuccess();
        } else {
          yield LoTrinhFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield LoTrinhFailure(error: e);
      }
    }

    if(event is FetchDsLoTrinhHomNay){
      yield LoTrinhLoading();

      try{
        final danhSach = await _repository.getDsLoTrinhHomNay();

        if(danhSach.isNotEmpty){
          yield LoTrinhSuccess(listModel: danhSach);
        } else {
          yield LoTrinhEmpty();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield LoTrinhFailure(error: e);
      }
    }

    if(event is XoaLoTrinh){
      try{
        bool isSuccess = await _repository.xoaLoTrinh(id: event.id);

        if(isSuccess == true){
          final danhSach = await _repository.getDsLoTrinhHomNay();

          if(danhSach.isNotEmpty){
            yield LoTrinhSuccess(listModel: danhSach);
          } else {
            yield LoTrinhEmpty();
          }
        } else {
          yield LoTrinhFailure();
        }
      }catch(e, s){
        print(e);
        print(s);
        yield LoTrinhFailure(error: e);
      }
    }
  }
}