import 'package:proyecto/models/clase_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaseServicio {
  final String uriString = "http://127.0.0.1:5000";

  Future<Clase> getClase(int idclase) async {
    final response = await http.get(Uri.parse("${uriString}/api/clase/get/${idclase}"));

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar la clase.");
    }
  }

  Future<void> agregarClase(Clase clase) async {
    final response = await http.post(Uri.parse("${uriString}/api/clase/agregar"),body: clase);

    if(response.statusCode==201) {
      print("Se ha agregado la clase con éxito.");
    } else {
      print("Fallo al agregar la clase.");
    }
  }

  Future<void> modificarClase(Clase clase) async {
    final response = await http.put(Uri.parse("${uriString}/api/clase/modificar"),body: clase);

    if(response.statusCode==200) {
      print("Se ha modificado la clase con éxito.");
    } else {
      print("Fallo al modificar la clase.");
    }
  }

  Future<void> eliminarClase(int idclase) async {
    final response = await http.delete(Uri.parse("${uriString}/api/clase/eliminar/${idclase}"));

    if(response.statusCode==200) {
      print("Se ha eliminado la clase con éxito.");
    } else {
      print("Fallo al eliminar la clase.");
    }
  }
}