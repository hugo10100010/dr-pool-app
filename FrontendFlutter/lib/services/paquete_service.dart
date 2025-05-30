import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/helpers/sanitizeforsqlite.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'dart:convert';
import 'package:proyecto/services/auth_service.dart';
import 'package:proyecto/services/localidgen.dart';

class PaqueteService {
  final String uriString = "http://127.0.0.1:5000";
  Future<Paquete> getPaquete(int idpaquete) async {
    final response =
        await http.get(Uri.parse("${baseUrl}/api/paquete/get/${idpaquete}"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar paquete.");
    }
  }

  Future<List<Paquete>> getPaquetes() async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/paquete/getall"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final paquetes = data.map((json) => Paquete.fromJson(json)).toList();

        // Update local DB cache
        for (final paquete in paquetes) {
          await AppDatabase.insert<Paquete>(paquete);
        }
        return paquetes;
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      // Fallback to local cache if offline or failed
      print('Fetching paquetes from local DB due to: $e');
      return await AppDatabase.getAll<Paquete>(
        tableName: 'paquete',
        fromJson: (json) => Paquete.fromJson(json),
      );
    }
  }

  Future<bool> agregarPaquete(Map<String, dynamic> paquetedatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/paquete/agregar"),
        body: jsonEncode(paquetedatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        final serverResponse = jsonDecode(response.body);
        final serverId = serverResponse['id'];
        paquetedatos['id'] = serverId;
        await AppDatabase.insert(Paquete.fromJson(paquetedatos));
        return true;
      }
    } catch (_) {
      // Offline fallback
    }

    // No server ID, generate a temporary local ID
    final tempId = await LocalIdGenerator.generate('paquete');
    paquetedatos['id'] = tempId;
    paquetedatos['sync_status'] = 1;
    await AppDatabase.insert(Paquete.fromJson(paquetedatos));
    return true;
  }

  Future<bool> modificarPaquete(Map<String, dynamic> paquetedatos) async {
    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/paquete/modificar/${paquetedatos['id']}"),
        body: jsonEncode(paquetedatos),
        method: "PUT",
      );

      if (response.statusCode == 200) {
        // Server update successful, reflect in local DB
        final id = paquetedatos['id'];
        if (paquetedatos.containsKey('flexible')) {
          paquetedatos['flexible'] = paquetedatos['flexible'].toString();
        }
        final updateData = Map<String, dynamic>.from(paquetedatos)
          ..remove('id');
        await AppDatabase.updatePartial(
            'paquete', id, sanitizeForSqlite(updateData));
        return true;
      }
    } catch (_) {
      // Fall through to mark as dirty for sync
    }

    // If failed or offline, update locally and mark for sync
    paquetedatos['sync_status'] = 1;
    final id = paquetedatos['id'];
    if (paquetedatos.containsKey('flexible')) {
      paquetedatos['flexible'] = paquetedatos['flexible'].toString();
    }
    final updateData = Map<String, dynamic>.from(paquetedatos)..remove('id');
    await AppDatabase.updatePartial(
        'paquete', id, sanitizeForSqlite(updateData));
    return true;
  }

  Future<bool> eliminarPaquete(int idpaquete) async {
    try {
      final response = await AuthService.authorizedRequest(
          Uri.parse("$baseUrl/api/paquete/eliminar/$idpaquete"),
          method: 'DELETE');

      if (response.statusCode == 200) {
        await AppDatabase.delete('paquete', idpaquete);
        return json.decode(response.body)['success'];
      }
    } catch (_) {
      await AppDatabase.updatePartial('paquete', idpaquete, {
        "sync_status": 2,
      });
    }
    return false;
  }
}
