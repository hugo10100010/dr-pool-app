import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:proyecto/helpers/sanitizeforsqlite.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/clase_model.dart';
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';
import 'package:proyecto/services/localidgen.dart';

class ClaseServicio {
  final String uriString = "http://127.0.0.1:5000";
  Future<CasillaHorario> getCasilla(int idcasilla) async {
    final response =
        await http.get(Uri.parse("${baseUrl}/api/casilla/get/${idcasilla}"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar clase.");
    }
  }

  Future<List<Clase>> getClases() async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/clase/getall"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final clases = data.map((json) => Clase.fromJson(json)).toList();

        // Update local DB cache
        for (final clase in clases) {
          await AppDatabase.insert<Clase>(clase);
        }

        return clases;
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      // Fallback to local cache if offline or failed
      print('Fetching clases from local DB due to: $e');
      return await AppDatabase.getAll<Clase>(
        tableName: 'clase',
        fromJson: (json) => Clase.fromJson(json),
      );
    }
  }

  Future<bool> agregarClase(Map<String, dynamic> clasedatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/clase/agregar"),
        body: jsonEncode(clasedatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        final serverResponse = jsonDecode(response.body);
        final serverId = serverResponse['id'];
        clasedatos['id'] = serverId;
        await AppDatabase.insert(Clase.fromJson(clasedatos));
        return true;
      }
    } catch (_) {
      // Offline fallback
    }

    // No server ID, generate a temporary local ID
    final tempId = await LocalIdGenerator.generate('clase');
    clasedatos['id'] = tempId;
    clasedatos['sync_status'] = 1;
    await AppDatabase.insert(Clase.fromJson(clasedatos));
    return true;
  }

  Future<bool> modificarClase(Map<String, dynamic> clasedatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/clase/modificar/${clasedatos['id']}"),
        body: jsonEncode(clasedatos),
        method: "PUT",
      );

      if (response.statusCode == 200) {
        // Server update successful, reflect in local DB
        final id = clasedatos['id'];
        final updateData = Map<String, dynamic>.from(clasedatos)..remove('id');
        await AppDatabase.updatePartial(
            'clase', id, sanitizeForSqlite(updateData));
        return true;
      }
    } catch (_) {
      // Fall through to mark as dirty for sync
    }

    // If failed or offline, update locally and mark for sync
    clasedatos['sync_status'] = 1;
    final id = clasedatos['id'];
    final updateData = Map<String, dynamic>.from(clasedatos)..remove('id');
    await AppDatabase.updatePartial('clase', id, sanitizeForSqlite(updateData));
    return true;
  }

  Future<bool> eliminarClase(int idclase) async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/clase/eliminar/$idclase"),
          method: 'DELETE');

      if (response.statusCode == 200) {
        await AppDatabase.delete('clase', idclase);
        return json.decode(response.body)['success'];
      }
    } catch (_) {
      await AppDatabase.updatePartial('clase', idclase, {
        "sync_status": 2,
      });
    }
    return false;
  }
}
