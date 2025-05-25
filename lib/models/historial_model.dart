import 'package:proyecto/models/paquete_model.dart';

class Historial {
  int id;
  int idusuario;
  int idpaquete;
  DateTime fechaini;
  DateTime fechafin;
  String metodo;
  Paquete paquete;

  Historial({
    required this.id,
    required this.idusuario,
    required this.idpaquete,
    required this.fechaini,
    required this.fechafin,
    required this.metodo,
    required this.paquete,
  });

  factory Historial.fromJson(Map<String, dynamic> json) => Historial(
        id: json['id'],
        idusuario: json['idusuario'],
        idpaquete: json['idpaquete'],
        fechaini: DateTime.parse(json['fechaini']),
        fechafin: DateTime.parse(json['fechafin']),
        metodo: json['metodo'],
        paquete: Paquete.fromJson(json['paquete']),
      );
}
