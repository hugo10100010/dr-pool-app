import 'package:proyecto/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/horario_model.dart';
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';

class HorarioService {
  final String uriString = "http://127.0.0.1:5000";

  Future<Horario> getHorario(int idusuario) async {
    final response =
        await http.get(Uri.parse("${uriString}/api/horario/get/${idusuario}"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar el horario.");
    }
  }

  Future<bool> agregarUsuario(Map<String, dynamic> horariodatos) async {

    try {
      final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/horario/agregar"),
        body: jsonEncode(horariodatos),
        method: "POST",
      );

      if (response.statusCode == 200) {
        final serverResponse = jsonDecode(response.body);
        final usuariocreadojson = serverResponse['data'];
        return true;
      }
    } catch (_) {
      // Offline fallback
    }
    return false;
  }

  Future<void> modificarHorario(Horario horario) async {
    final response = await http
        .put(Uri.parse("${uriString}/api/horario/modificar"), body: horario);

    if (response.statusCode == 200) {
      print("Se ha modificado el horario con éxito.");
    } else {
      print("Algo falló al modificar el horario.");
    }
  }

  Future<bool> eliminarHorario(int idhorario) async {
    final response = await http
        .delete(Uri.parse("${uriString}/api/horario/eliminar/${idhorario}"));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
