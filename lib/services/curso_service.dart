import 'package:proyecto/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/curso_model.dart';
import 'dart:convert';

import 'package:proyecto/services/auth_service.dart';

class CursoServicio {
  final String uriString = "http://127.0.0.1:5000";
  Future<Curso> getCurso(int idcurso) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("${baseUrl}/api/curso/get/${idcurso}")
    );

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar curso.");
    }
  }

  Future<List<Curso>> getCursos() async {
    final response = await AuthService.authorizedRequest(Uri.parse("$baseUrl/api/curso/getall"));
    if(response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Curso.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cursos');
    }
  }

  Future<bool> agregarCurso(Map<String,dynamic> cursodatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/curso/agregar"),
      body: JsonEncoder().convert(cursodatos),
      method: "POST",
    );

    if(response.statusCode==200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> modificarCurso(Map<String,dynamic> cursodatos) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/curso/modificar/${cursodatos['id']}"),
      body: JsonEncoder().convert(cursodatos),
      method: "PUT"
    );

    if(response.statusCode==200) {
      print("Se ha modificado el curso con éxito");
    } else {
      print("Algo falló al modificar el curso.");
    }
  }

  Future<String> eliminarCurso(int idcurso) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/curso/eliminar/$idcurso"),
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