import 'dart:convert';
import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/services/auth_service.dart';

class PaqueteService {
  final String uriString = "http://127.0.0.1:5000";
  Future<Paquete> getPaquete(int idpaquete) async {
    final response = await http.get(Uri.parse("${uriString}/api/paquete/get/${idpaquete}"));

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar paquete.");
    }
  }

  Future<List<Paquete>> getPaquetes() async {
    final response = await AuthService.authorizedRequest(Uri.parse("$baseUrl/api/paquete/getall"));
    if(response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Paquete.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load paquetes');
    }
  }

  Future<bool> agregarPaquete(Map<String,dynamic> paquetedatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/paquete/agregar"),
      body: JsonEncoder().convert(paquetedatos),
      method: "POST",
    );

    if(response.statusCode==200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> modificarPaquete(Map<String,dynamic> paquetedatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/paquete/modificar/${paquetedatos['id']}"),
      body: JsonEncoder().convert(paquetedatos),
      method: "PUT"
    );

    if(response.statusCode==200) {
      print("Se ha modificado el paquete con éxito");
    } else {
      print("Algo falló al modificar el paquete.");
    }
  }

  Future<String> eliminarPaquete(int idpaquete) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/paquete/eliminar/$idpaquete"),
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