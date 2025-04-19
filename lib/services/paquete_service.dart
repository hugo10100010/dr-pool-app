import 'dart:convert';
import 'package:proyecto/models/paquete_model.dart';
import 'package:http/http.dart' as http;

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

  Future<void> agregarPaquete(Paquete paquete) async {
    final response = await http.post(Uri.parse("${uriString}/api/paquete/agregar"),body: paquete);

    if(response.statusCode==201) {
      print("Se ha agregado el paquete con éxito");
    } else {
      print("Algo falló al agregar el paquete.");
    }
  }

  Future<void> modificarPaquete(Paquete paquete) async {
    final response = await http.put(Uri.parse("${uriString}/api/paquete/modificar"),body: paquete);

    if(response.statusCode==200) {
      print("Se ha modificado el paquete con éxito");
    } else {
      print("Algo falló al modificar el paquete.");
    }
  }

  Future<void> eliminarPaquete(int idpaquete) async {
    final response = await http.delete(Uri.parse("${uriString}/api/paquete/eliminar/${idpaquete}"));

    if(response.statusCode==200) {
      print("Se ha eliminado el paquete con éxito");
    } else {
      print("Algo falló al eliminar el paquete.");
    }
  }
}