import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/models/user_model.dart';
import 'package:real_estate/shared_pref.dart';

import 'home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  // TODO: implement initialState
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    SharedPref sharedPref = SharedPref();

    if (event is HomeStart) {
      yield HomeLoading();

      try {
        UserModel user = UserModel.fromJson(await sharedPref.read("userSave"));

        yield HomeSuccess(userModel: user);
      } catch (e) {
        print(e);
      }
    }
  }
}
