import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class AuthService {
  static final _storage = FlutterSecureStorage();

  static Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: 'proyectom_access_token');
    } catch (e) {
      print('Error al leer access token: $e');

      // Opcional: eliminar todo el almacenamiento si está corrupto
      await _storage.deleteAll();

      return null;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: 'proyectom_refresh_token');
    } catch (e) {
      print('Error al leer refresh token: $e');

      // Opcional: eliminar todo el almacenamiento si está corrupto
      await _storage.deleteAll();

      return null;
    }
  }

  static Future<bool> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse("$baseUrl/api/refresh"),
      headers: {"Authorization": "Bearer $refreshToken"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['data']['access_token'];
      await _storage.write(
          key: 'proyectom_access_token', value: newAccessToken);
      return true;
    }

    return false;
  }

  static Future<http.Response> authorizedRequest(
    Uri url, {
    String method = 'GET',
    Map<String, String>? headers,
    Object? body,
  }) async {
    String? token = await getAccessToken();
    headers ??= {};
    headers['Authorization'] = 'Bearer $token';
    headers['Content-Type'] = 'application/json';

    late http.Response response;

    switch (method.toUpperCase()) {
      case 'POST':
        response = await http.post(url, headers: headers, body: body);
        break;
      case 'PUT':
        response = await http.put(url, headers: headers, body: body);
        break;
      case 'DELETE':
        response = await http.delete(url, headers: headers, body: body);
        break;
      default:
        response = await http.get(url, headers: headers);
    }

    if (response.statusCode == 401) {
      final refreshed = await refreshToken();
      if (refreshed) {
        token = await getAccessToken();
        headers['Authorization'] = 'Bearer $token';

        switch (method.toUpperCase()) {
          case 'POST':
            response = await http.post(url, headers: headers, body: body);
            break;
          case 'PUT':
            response = await http.put(url, headers: headers, body: body);
            break;
          case 'DELETE':
            response = await http.delete(url, headers: headers, body: body);
            break;
          default:
            response = await http.get(url, headers: headers);
        }
      }
    }

    return response;
  }
}
