import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estate/models/user_model.dart';
import 'package:real_estate/modules/login/repository/login_repository.dart';
import 'package:real_estate/shared_pref.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({@required this.loginRepository});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    SharedPref sharedPref = SharedPref();

    if (event is Login) {
      yield LoginLoading();

      try {
        final UserModel userModel = await loginRepository.login(username: event.username, password: event.password);

        if (userModel != null) {
          sharedPref.save("userSave", userModel);
        }

        yield LoginSuccess(token: userModel.token);
      } catch (e) {
        yield LoginFailure(error: e);
        print(e);
      }
    }
  }
}
