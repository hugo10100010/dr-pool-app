import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';

class CasillahorarioService {
  final String uriString = "http://127.0.0.1:5000";
  Future<CasillaHorario> getCasilla(int idcasilla) async {
    final response = await http.get(Uri.parse("${baseUrl}/api/casilla/get/${idcasilla}"));

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar casilla.");
    }
  }

  Future<List<CasillaHorario>> getCasillas() async {
    final response = await AuthService.authorizedRequest(Uri.parse("$baseUrl/api/casilla/getall"));
    if(response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => CasillaHorario.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load casillas');
    }
  }

  Future<bool> agregarCasilla(Map<String,dynamic> casilladatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/casilla/agregar"),
      body: JsonEncoder().convert(casilladatos),
      method: "POST",
    );

    if(response.statusCode==200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> modificarCasilla(Map<String,dynamic> casilladatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/casilla/modificar/${casilladatos['id']}"),
      body: JsonEncoder().convert(casilladatos),
      method: "PUT"
    );

    if(response.statusCode==200) {
      print("Se ha modificado el paquete con éxito");
    } else {
      print("Algo falló al modificar el paquete.");
    }
  }

  Future<String> eliminarCasilla(int idcasilla) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/casilla/eliminar/$idcasilla"),
      method: 'DELETE'
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      return "No se pudo eliminar";
    }
  }
}