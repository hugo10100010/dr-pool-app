import 'package:proyecto/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HorarioService {
  final String uriString = "http://127.0.0.1:5000";

  Future<Horario> getHorario(int idusuario) async {
    final response = await http.get(Uri.parse("${uriString}/api/horario/get/${idusuario}"));

    if(response.statusCode==200) {
      return json.decode(response.body);
    } else {
      throw Exception("Fallo al cargar el horario.");
    }
  }

  Future<void> agregarHorario(Horario horario) async {
    final response = await http.post(Uri.parse("${uriString}/api/horario/agregar"),body: horario);

    if(response.statusCode==201) {
      print("Se ha agregado el horario con éxito.");
    } else {
      print("Algo falló al agregar el horario.");
    }
  }

  Future<void> modificarHorario(Horario horario) async {
    final response = await http.put(Uri.parse("${uriString}/api/horario/modificar"),body: horario);

    if(response.statusCode==200) {
      print("Se ha modificado el horario con éxito.");
    } else {
      print("Algo falló al modificar el horario.");
    }
  }

  Future<void> eliminarHorario(int idhorario) async {
    final response = await http.delete(Uri.parse("${uriString}/api/horario/eliminar/${idhorario}"));

    if(response.statusCode==200) {
      print("Se ha eliminado el horario con éxito.");
    } else {
      print("Algo falló al eliminar el horario.");
    }
  }
}