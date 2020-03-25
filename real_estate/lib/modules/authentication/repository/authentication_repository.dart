import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository {
  final storage = new FlutterSecureStorage();
  final String _tokenSecureStorage = 'token';

  Future<String> getToken() async {
    return await storage.read(key: _tokenSecureStorage);
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: _tokenSecureStorage, value: token);
    print( await storage.read(key: _tokenSecureStorage));
  }

  Future<void> deleteToken() async {
    await storage.delete(key: _tokenSecureStorage);
  }
}
