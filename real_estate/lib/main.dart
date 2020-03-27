import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:real_estate/my_application.dart';
import 'package:real_estate/modules/authentication/repository/authentication_repository.dart';

void main(){
//  Intl.defaultLocale = 'vi_VN';
//  initializeDateFormatting('vi_VN');
  return runApp(MyApplication(authenticationRepository: AuthenticationRepository()));
}
