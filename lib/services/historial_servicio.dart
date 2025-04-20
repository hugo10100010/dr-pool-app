import 'package:proyecto/models/historial_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistorialServicio {
  final String uriString = "http://127.0.0.1:5000";

  Future<Historial> getHistorial(int idhistorial) async {
    final response = await http.get(Uri.parse("${uriString}/api/historial/get/${idhistorial}"));

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar el historial");
    }
  }

  Future<void> agregarHistorial(Historial historial) async {
    final response = await http.post(Uri.parse("${uriString}/api/historial/agregar"),body: historial);

    if(response.statusCode==201) {
      print("Se ha agregado el historial con éxito.");
    } else {
      print("Algo falló al agregar el historial.");
    }
  }

  Future<void> modificarHistorial(Historial historial) async {
    final response = await http.put(Uri.parse("${uriString}/api/historial/modificar"),body: historial);

    if(response.statusCode==200) {
      print("Se ha modificado el historial con éxito.");
    } else {
      print("Algo falló al modificar el historial.");
    }
  }

  Future<void> eliminarHistorial(int idhistorial) async {
    final response = await http.delete(Uri.parse("${uriString}/api/historial/eliminar/${idhistorial}"));

    if(response.statusCode==200) {
      print("Se ha eliminado el historial con éxito.");
    } else {
      print("Algo falló al eliminar el historial");
    }
  }
}