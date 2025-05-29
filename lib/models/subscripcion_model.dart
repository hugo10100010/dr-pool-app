import 'package:proyecto/models/paquete_model.dart';

class Subscripcion {
  int id;
  int idusuario;
  int? idpaquete;
  String estado;
  DateTime fechaini;
  DateTime fechafin;
  bool renovarauto;
  Paquete? paquete;

  Subscripcion({
    required this.id,
    required this.idusuario,
    this.idpaquete,
    required this.estado,
    required this.fechaini,
    required this.fechafin,
    required this.renovarauto,
    this.paquete,
  });

  factory Subscripcion.fromJson(Map<String, dynamic> json) => Subscripcion(
        id: json['id'],
        idusuario: json['idusuario'],
        idpaquete: json['idpaquete'],
        estado: json['estado'],
        fechaini: DateTime.parse(json['fechaini']),
        fechafin: DateTime.parse(json['fechafin']),
        renovarauto: json['renovarauto'],
        paquete: json['paquete'] == null ? null : Paquete.fromJson(json['paquete']),
      );
}
