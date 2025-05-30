import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/helpers/sanitizeforsqlite.dart';
import 'package:proyecto/models/curso_model.dart';
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';
import 'package:proyecto/services/localidgen.dart';

class CursoServicio {
  final String uriString = "http://127.0.0.1:5000";
  Future<Curso> getCurso(int idcurso) async {
    final response =
        await http.get(Uri.parse("${baseUrl}/api/curso/get/${idcurso}"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar casilla.");
    }
  }

  Future<List<Curso>> getCursos() async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/curso/getall"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final cursos = data.map((json) => Curso.fromJson(json)).toList();

        // Update local DB cache
        for (final curso in cursos) {
          await AppDatabase.insert<Curso>(curso);
        }

        return cursos;
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      // Fallback to local cache if offline or failed
      print('Fetching cursos from local DB due to: $e');
      return await AppDatabase.getAll<Curso>(
        tableName: 'curso',
        fromJson: (json) => Curso.fromJson(json),
      );
    }
  }

  Future<bool> agregarCurso(Map<String, dynamic> cursodatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/curso/agregar"),
        body: jsonEncode(cursodatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        final serverResponse = jsonDecode(response.body);
        final serverId = serverResponse['id'];
        cursodatos['id'] = serverId;
        await AppDatabase.insert(Curso.fromJson(cursodatos));
        return true;
      }
    } catch (_) {
      // Offline fallback
    }

    // No server ID, generate a temporary local ID
    final tempId = await LocalIdGenerator.generate('curso');
    cursodatos['id'] = tempId;
    cursodatos['sync_status'] = 1;
    await AppDatabase.insert(Curso.fromJson(cursodatos));
    return true;
  }

  Future<bool> modificarCurso(Map<String, dynamic> cursodatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/curso/modificar/${cursodatos['id']}"),
        body: jsonEncode(cursodatos),
        method: "PUT",
      );

      if (response.statusCode == 200) {
        // Server update successful, reflect in local DB
        final id = cursodatos['id'];
        final updateData = Map<String, dynamic>.from(cursodatos)..remove('id');
        await AppDatabase.updatePartial(
            'curso', id, sanitizeForSqlite(updateData));
        return true;
      }
    } catch (_) {
      // Fall through to mark as dirty for sync
    }

    // If failed or offline, update locally and mark for sync
    cursodatos['sync_status'] = 1;
    final id = cursodatos['id'];
    final updateData = Map<String, dynamic>.from(cursodatos)..remove('id');
    await AppDatabase.updatePartial('curso', id, sanitizeForSqlite(updateData));
    return true;
  }

  Future<bool> eliminarCurso(int idcurso) async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/curso/eliminar/$idcurso"),
          method: 'DELETE');

      if (response.statusCode == 200) {
        await AppDatabase.delete('curso', idcurso);
        return json.decode(response.body)['success'];
      }
    } catch (_) {
      await AppDatabase.updatePartial('curso', idcurso, {
        "sync_status": 2,
      });
    }
    return false;
  }
}
