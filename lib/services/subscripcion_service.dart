import 'package:proyecto/models/subscripcion_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubscripcionService {
  final String uriString = "http://127.0.0.1:5000";

  Future<Subscripcion> getSubscripcion(int idsubscripcion) async {
    final response = await http.get(Uri.parse("${uriString}/api/subscripcion/get/${idsubscripcion}"));
    
    if(response.statusCode==200) {
      return (json.decode(response.body));
    } else {
      throw Exception("Fallo al cargar la subscripcion");
    }
  }

  Future<void> agregarSubscripcion(Subscripcion subscripcion) async {
    final response = await http.post(Uri.parse("${uriString}/api/subscripcion/agregar"),body: subscripcion);

    if(response.statusCode==201) {
      print("Se ha agregado la subscripcion con éxito");
    } else {
      print("Algo falló al agregar el subscripción.");
    }
  }

  Future<void> modificarSubscripcion(Subscripcion subscripcion) async {
    final response = await http.put(Uri.parse("${uriString}/api/subscripcion/modificar"),body: subscripcion);

    if(response.statusCode==200) {
      print("Se ha modificado la subscripcion con éxito");
    } else {
      print("Algo falló al modificar la subscripción.");
    }
  }

  Future<void> eliminarSubscripcion(int idsubscripcion) async {
    final response = await http.delete(Uri.parse("${uriString}/api/subscripcion/eliminar/${idsubscripcion}"));

    if(response.statusCode==200) {
      print("Se ha eliminado la subscripción con éxito.");
    } else {
      print("Algo falló al eliminar la subscripción.");
    }
  }
}