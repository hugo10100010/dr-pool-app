import 'dart:convert';
import 'package:proyecto/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  Future<Usuario> getUsuario(int idusuario) async {
    final response = await http.get(Uri.parse("http://127.0.0.1:5000/api/usuario/get/${idusuario}"));
    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load usuario');
    }
  }

  Future<void> agregarUsuario(Map<String, dynamic> usuariodatos) async {
    final response = await http.post(Uri.parse("http://127.0.0.1:5000/api/usuario/agregar"),body: usuariodatos);

    if(response.statusCode==201) {
      print("Usuario creado exitosamente.");
    }
    else {
      print("El usuario no pudo ser creado.");
    }
  }

  Future<void> modificarUsuario(Map<String,dynamic> usuariodatos) async {
    final response = await http.put(Uri.parse("http://127.0.0.1:5000/api/usuario/modificar"),body: usuariodatos);

    if(response.statusCode==200) {
      print("La información del usuario fue actualizada con éxito");
    } else {
      print("No se actualizó la información");
    }
  }

  Future<void> eliminarUsuario(int idusuario) async {
    final response = await http.delete(Uri.parse("http://127.0.0.1:5000/api/usuario/eliminar/${idusuario}"));

    if(response.statusCode==200) {
      print("El usuario ha sido eliminado exitosamente.");
    } else {
      print("No se pudo eliminar el usuario");
    }
  }
}