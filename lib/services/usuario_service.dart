import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto/constants/api_constants.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proyecto/services/auth_service.dart';

class UsuarioService {
  Future<Map<String,dynamic>> login(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("$baseUrl/api/login"),
        body: JsonEncoder().convert(json),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['data']['access_token'];
      final refreshToken = data['data']['refresh_token'];

      final storage = FlutterSecureStorage();
      await storage.write(key: 'proyectom_access_token', value: accessToken);
      await storage.write(key: "proyectom_refresh_token", value: refreshToken);
      final usuario = Usuario.fromJson(data['data']['data']);
      return {
        "success":true,
        "rol":data['data']['data']['tipousuario'],
        "usuario": usuario,
      };
    } else {
      return {
        "success":false
      };
    }
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
    final response = await AuthService.authorizedRequest(Uri.parse("$baseUrl/api/usuario/getall"));
    if(response.statusCode==200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load usuarios');
    }
  }

  Future<bool> agregarUsuario(Map<String, dynamic> usuariodatos) async {
    final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/usuario/agregar"),
        method: "POST",
        body: JsonEncoder().convert(usuariodatos));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> modificarUsuario(Map<String, dynamic> usuariodatos) async {
    final response = await AuthService.authorizedRequest(
        Uri.parse("$baseUrl/api/usuario/modificar/${usuariodatos['id']}"),
        method: "PUT",
        body: JsonEncoder().convert(usuariodatos));

    if (response.statusCode == 200) {
      print("La información del usuario fue actualizada con éxito");
    } else {
      print("No se actualizó la información");
    }
  }

  Future<String> eliminarUsuario(int idusuario) async {
    final response = await AuthService.authorizedRequest(
      Uri.parse("$baseUrl/api/usuario/eliminar/$idusuario"),
      method: "DELETE",
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      return "No se pudo eliminar";
    }
  }
}
