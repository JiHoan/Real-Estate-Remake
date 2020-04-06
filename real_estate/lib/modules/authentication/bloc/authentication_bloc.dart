import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/modules/authentication/repository/authentication_repository.dart';

import 'authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository authenticationRepository;

  AuthenticationBloc({@required this.authenticationRepository});

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      try {
        final token = await authenticationRepository.getToken();

        if (token != null) {
          yield AuthenticationAuthenticated(token: token);
        } else {
          yield AuthenticationUnauthenticated();
        }
      } catch (e, s) {
        print(e);
        print(s);
      }
    }

    if (event is LoggedIn) {
      await authenticationRepository.persistToken(event.token);
      yield AuthenticationAuthenticated(token: event.token);
    }

    if (event is LoggedOut) {
      await authenticationRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }

    if (event is ShutDown) {
      await authenticationRepository.deleteToken();
      yield AuthenticationUnauthenticated(type: 1);
    }
  }
}
