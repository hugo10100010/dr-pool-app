import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  String? accessToken;

  Future<void> loadToken() async {
    final storage = FlutterSecureStorage();
    accessToken = await storage.read(key: 'proyectom_access_token');
  }
}
