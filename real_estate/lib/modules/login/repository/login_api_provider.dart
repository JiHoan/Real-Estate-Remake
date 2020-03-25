import 'package:flutter/cupertino.dart';
import 'package:real_estate/api/api_provider.dart';
import 'package:real_estate/models/user_model.dart';

class LoginApiProvider extends ApiProvider {
  Future<UserModel> login({@required String username, @required String password}) async {
    Map<String, String> _requestBody = {'username': username, 'password': password};
    Response _resp = await httpClient.post('auth/login', data: _requestBody);

    if(_resp.statusCode == 200 && _resp.data['success']){
      return UserModel.fromJson(_resp.data['data']);
    } else {
      throw _resp.data['message'];
    }
  }
}
