import 'package:dio/dio.dart';
export 'package:dio/dio.dart';

abstract class ApiProvider {
  static const String apiBaseUrl = 'http://nhadat.imark.vn/';
  static const String apiPath = 'api';

  static final _dio = Dio(
    BaseOptions(
      baseUrl: '$apiBaseUrl/$apiPath/',
      connectTimeout: 60000,
      receiveTimeout: 60000,
      responseType: ResponseType.json,
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    ),
  );

  static void setBearerAuth(String token) {
    _dio.options.headers.addAll({'Authorization': ' Bearer $token'});
  }

  static void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  static void setValidateStatus(ValidateStatus validateStatus) {
    _dio.options.validateStatus = validateStatus;
  }

  final Dio httpClient;

  ApiProvider() : httpClient = _dio {
    if (_dio.interceptors.isEmpty) {
      _dio.interceptors.add(LogInterceptor(error: true, requestBody: true, responseBody: true));
    }
  }
}