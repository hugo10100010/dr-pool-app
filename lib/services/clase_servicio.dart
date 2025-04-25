import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';

class ClaseServicio {
  final String uriString = "http://127.0.0.1:5000";
  Future<Clase> getClase(int idclase) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("${baseUrl}/api/clase/get/${idclase}")
    );

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar casilla.");
    }
  }

  Future<List<Clase>> getClases() async {
    final response = await AuthService.authorizedRequest(Uri.parse("$baseUrl/api/clase/getall"));
    if(response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Clase.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load casillas');
    }
  }

  Future<bool> agregarClase(Map<String,dynamic> clasedatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/clase/agregar"),
      body: JsonEncoder().convert(clasedatos),
      method: "POST",
    );

    if(response.statusCode==200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> modificarClase(Map<String,dynamic> clasedatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/clase/modificar/${clasedatos['id']}"),
      body: JsonEncoder().convert(clasedatos),
      method: "PUT"
    );

    if(response.statusCode==200) {
      print("Se ha modificado el paquete con éxito");
    } else {
      print("Algo falló al modificar el paquete.");
    }
  }

  Future<String> eliminarClase(int idclase) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/clase/eliminar/$idclase"),
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