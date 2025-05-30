import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:proyecto/helpers/sanitizeforsqlite.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';
import 'package:proyecto/services/localidgen.dart';

class CasillahorarioService {
  final String uriString = "http://127.0.0.1:5000";
  Future<CasillaHorario> getCasilla(int idcasilla) async {
    final response =
        await http.get(Uri.parse("${baseUrl}/api/casilla/get/${idcasilla}"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar casilla.");
    }
  }

  Future<List<CasillaHorario>> getCasillas() async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/casilla/getall"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final casillas =
            data.map((json) => CasillaHorario.fromJson(json)).toList();

        // Update local DB cache
        for (final casilla in casillas) {
          await AppDatabase.insert<CasillaHorario>(casilla);
        }

        return casillas;
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      // Fallback to local cache if offline or failed
      print('Fetching casillas from local DB due to: $e');
      return await AppDatabase.getAll<CasillaHorario>(
        tableName: 'casillahorario',
        fromJson: (json) => CasillaHorario.fromJson(json),
      );
    }
  }

  Future<bool> agregarCasilla(Map<String, dynamic> casilladatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/casilla/agregar"),
        body: jsonEncode(casilladatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        final serverResponse = jsonDecode(response.body);
        final serverId = serverResponse['id'];
        casilladatos['id'] = serverId;
        await AppDatabase.insert(CasillaHorario.fromJson(casilladatos));
        return true;
      }
    } catch (_) {
      // Offline fallback
    }

    // No server ID, generate a temporary local ID
    final tempId = await LocalIdGenerator.generate('casillahorario');
    casilladatos['id'] = tempId;
    casilladatos['sync_status'] = 1;
    await AppDatabase.insert(CasillaHorario.fromJson(casilladatos));
    return true;
  }

  Future<bool> modificarCasilla(Map<String, dynamic> casilladatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/casilla/modificar/${casilladatos['id']}"),
        body: jsonEncode(casilladatos),
        method: "PUT",
      );

      if (response.statusCode == 200) {
        // Server update successful, reflect in local DB
        final id = casilladatos['id'];
        final updateData = Map<String, dynamic>.from(casilladatos)
          ..remove('id');
        await AppDatabase.updatePartial(
            'casillahorario', id, sanitizeForSqlite(updateData));
        return true;
      }
    } catch (_) {
      // Fall through to mark as dirty for sync
    }

    // If failed or offline, update locally and mark for sync
    casilladatos['sync_status'] = 1;
    final id = casilladatos['id'];
    final updateData = Map<String, dynamic>.from(casilladatos)..remove('id');
    await AppDatabase.updatePartial(
        'casillahorario', id, sanitizeForSqlite(updateData));
    return true;
  }

  Future<bool> eliminarCasilla(int idcasilla) async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/casilla/eliminar/$idcasilla"),
          method: 'DELETE');

      if (response.statusCode == 200) {
        await AppDatabase.delete('casillahorario', idcasilla);
        return json.decode(response.body)['success'];
      }
    } catch (_) {
      await AppDatabase.updatePartial('casillahorario', idcasilla, {
        "sync_status": 2,
      });
    }
    return false;
  }
}
