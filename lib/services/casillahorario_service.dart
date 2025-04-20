import 'package:proyecto/models/casillahorario_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CasillahorarioService {
  final String uriString = "http://127.0.0.1:5000";

  Future<CasillaHorario> getCasilla(int idcasilla) async {
    final response = await http.get(Uri.parse("${uriString}/api/casilla/get/${idcasilla}"));

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar la casilla.");
    }
  }

  Future<void> agregarCasilla(CasillaHorario casilla) async {
    final response = await http.post(Uri.parse("${uriString}/api/casilla/agregar"),body: casilla);

    if(response.statusCode==201) {
      print("Se ha agregado la casilla con éxito.");
    } else {
      print("Algo falló al agregar la casilla.");
    }
  }

  Future<void> modificarCasilla(CasillaHorario casilla) async {
    final response = await http.put(Uri.parse("${uriString}/api/casilla/modificar"),body: casilla);

    if(response.statusCode==200) {
      print("Se ha modificado la casilla con éxito.");
    } else {
      print("Algo falló al modificar la casilla.");
    }
  }

  Future<void> eliminarCasilla(int idcasilla) async {
    final response = await http.delete(Uri.parse("${uriString}/api/casilla/eliminar/${idcasilla}"));

    if(response.statusCode==200) {
      print("Se ha eliminado la casilla con éxito.");
    } else {
      print("Algo falló al eliminar la casilla.");
    }
  }
}