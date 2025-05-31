import 'dart:convert';
import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proyecto/services/auth_service.dart';
import 'package:proyecto/services/localidgen.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:proyecto/helpers/sanitizeforsqlite.dart';

class UsuarioService {
  Future<Map<String, dynamic>> login(Map<String, dynamic> json) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/login"),
        body: JsonEncoder().convert(json),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['data']['access_token'];
        final refreshToken = data['data']['refresh_token'];

        final storage = FlutterSecureStorage();
        await storage.write(key: 'proyectom_access_token', value: accessToken);
        await storage.write(
            key: "proyectom_refresh_token", value: refreshToken);
        await storage.write(key: 'username', value: json['username']);
        await storage.write(
            key: 'password',
            value: data['data']['data']['cuenta']
                ['password_hashed']); // hash in real use
        await storage.write(
          key: 'cached_user',
          value: jsonEncode(data['data']['data']),
        );

        final usuario = Usuario.fromJson(data['data']['data']);
        await AppDatabase.insert<Usuario>(usuario);
        return {
          "success": true,
          "rol": data['data']['data']['tipousuario'],
          "usuario": usuario,
        };
      }
    } catch (e) {
      print('Login failed online: $e');
    }
    final storage = FlutterSecureStorage();
    final storedUsername = await storage.read(key: 'username');
    final storedPassword = await storage.read(key: 'password');

    if (storedUsername != null && storedPassword != null) {
      if (storedUsername == json['username'] &&
          BCrypt.checkpw(json['password'], storedPassword)) {
        final cachedUserJson = await storage.read(key: 'cached_user');
        if (cachedUserJson != null) {
          final cachedUser = Usuario.fromJson(jsonDecode(cachedUserJson));
          return {
            "success": true,
            "rol": cachedUser.tipousuario,
            "usuario": cachedUser,
          };
        } else {
          print("No user info");
        }
      } else {
        print("Invalid credentials");
      }
    } else {
      print("No credentials");
    }

    return {"success": false};
  }

  Future<Usuario> getUsuario(int idusuario) async {
    final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/usuario/get/$idusuario"));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data']['data'];
    } else {
      throw Exception('Failed to load usuario');
    }
  }

  Future<List<Usuario>> getUsuarios() async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/usuario/getall"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final usuarios = data.map((json) => Usuario.fromJson(json)).toList();

        // Update local DB cache
        for (final usuario in usuarios) {
          await AppDatabase.insert<Usuario>(usuario);
        }

        return usuarios;
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      // Fallback to local cache if offline or failed
      print('Fetching usuarios from local DB due to: $e');
      return await AppDatabase.getAll<Usuario>(
        tableName: 'usuario',
        fromJson: (json) => Usuario.fromJson(json),
      );
    }
  }

  Future<bool> registrarUsuario(Map<String, dynamic> usuariodatos) async {
    if (usuariodatos['personales'] is String) {
      usuariodatos['personales'] = jsonDecode(usuariodatos['personales']);
    }
    if (usuariodatos['cuenta'] is String) {
      usuariodatos['cuenta'] = jsonDecode(usuariodatos['cuenta']);
    }
    if (usuariodatos.containsKey('domicilio')) {
      if (usuariodatos['domicilio'] is String) {
        usuariodatos['domicilio'] = jsonDecode(usuariodatos['domicilio']);
      }
    }
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/usuario/registrar"),
        body: jsonEncode(usuariodatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (_) {
      // Offline fallback
    }
    return false;
  }

  Future<bool> agregarUsuario(Map<String, dynamic> usuariodatos) async {
    if (usuariodatos['personales'] is String) {
      usuariodatos['personales'] = jsonDecode(usuariodatos['personales']);
    }
    if (usuariodatos['cuenta'] is String) {
      usuariodatos['cuenta'] = jsonDecode(usuariodatos['cuenta']);
    }
    if (usuariodatos['domicilio'] is String) {
      usuariodatos['domicilio'] = jsonDecode(usuariodatos['domicilio']);
    }
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/usuario/agregar"),
        body: jsonEncode(usuariodatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        final serverResponse = jsonDecode(response.body);
        final usuariocreadojson = serverResponse['data'];
        await AppDatabase.insert(Usuario.fromJson(usuariocreadojson));
        return true;
      }
    } catch (_) {
      // Offline fallback
    }

    // No server ID, generate a temporary local ID
    final tempId = await LocalIdGenerator.generate('usuario');
    usuariodatos['id'] = tempId;
    usuariodatos['idpersonales'] = tempId;
    usuariodatos['idcuenta'] = tempId;
    usuariodatos['idmetricas'] = tempId;
    usuariodatos['iddomicilio'] = tempId;
    if (usuariodatos['personales'] is String) {
      usuariodatos['personales'] = jsonDecode(usuariodatos['personales']);
    }
    usuariodatos['personales']['id'] = tempId;
    if (usuariodatos['cuenta'] is String) {
      usuariodatos['cuenta'] = jsonDecode(usuariodatos['cuenta']);
    }
    usuariodatos['cuenta']['id'] = tempId;
    usuariodatos['metricas'] = {"id": tempId};
    if (usuariodatos['domicilio'] is String) {
      usuariodatos['domicilio'] = jsonDecode(usuariodatos['domicilio']);
    }
    usuariodatos['domicilio']['id'] = tempId;
    usuariodatos['sync_status'] = 1;
    await AppDatabase.insert(Usuario.fromJson(usuariodatos));
    return true;
  }

  Future<bool> modificarUsuario(Map<String, dynamic> usuariodatos) async {
    if (usuariodatos['personales'] is String) {
      usuariodatos['personales'] = jsonDecode(usuariodatos['personales']);
    }
    if (usuariodatos['cuenta'] is String) {
      usuariodatos['cuenta'] = jsonDecode(usuariodatos['cuenta']);
    }
    if (usuariodatos['domicilio'] is String) {
      usuariodatos['domicilio'] = jsonDecode(usuariodatos['domicilio']);
    }
    if (usuariodatos.containsKey('metricas')) {
      if (usuariodatos['metricas'] is String) {
        usuariodatos['metricas'] = jsonDecode(usuariodatos['metricas']);
      }
    }
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/usuario/modificar/${usuariodatos['id']}"),
        body: jsonEncode(usuariodatos),
        method: "PUT",
      );

      if (response.statusCode == 200) {
        // Server update successful, reflect in local DB
        final id = usuariodatos['id'];
        final updateData = Map<String, dynamic>.from(usuariodatos)
          ..remove('id');
        await AppDatabase.updatePartial(
            'usuario', id, sanitizeForSqlite(updateData));
        return true;
      }
    } catch (_) {
      // Fall through to mark as dirty for sync
    }

    // If failed or offline, update locally and mark for sync
    usuariodatos['sync_status'] = 1;
    final id = usuariodatos['id'];
    final updateData = Map<String, dynamic>.from(usuariodatos)..remove('id');
    await AppDatabase.updatePartial(
        'usuario', id, sanitizeForSqlite(updateData));
    return true;
  }

  Future<bool> eliminarUsuario(int idusuario) async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/usuario/eliminar/$idusuario"),
          method: 'DELETE');

      if (response.statusCode == 200) {
        await AppDatabase.delete('usuario', idusuario);
        return json.decode(response.body)['success'];
      }
    } catch (_) {
      await AppDatabase.updatePartial('usuario', idusuario, {
        "sync_status": 2,
      });
    }
    return false;
  }
}
