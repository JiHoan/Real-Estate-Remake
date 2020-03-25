import 'package:flutter/cupertino.dart';
import 'package:real_estate/models/user_model.dart';
import 'package:real_estate/modules/login/repository/login_api_provider.dart';

class LoginRepository {
  final LoginApiProvider _loginApiProvider = LoginApiProvider();

  Future<UserModel> login({@required String username, @required String password}) async {
    return await _loginApiProvider.login(username: username, password: password);
  }
}
