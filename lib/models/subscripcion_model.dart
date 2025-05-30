import 'dart:convert';

import 'package:proyecto/helpers/syncable_interface.dart';
import 'package:proyecto/models/paquete_model.dart';

class Subscripcion implements Syncable {
  int idusuario;
  int? idpaquete;
  String estado;
  DateTime fechaini;
  DateTime fechafin;
  bool renovarauto;
  Paquete? paquete;
  @override
  String get tablename => 'subscripcion';
  @override
  int id;
  @override
  int syncStatus;

  Subscripcion({
    required this.id,
    required this.idusuario,
    this.idpaquete,
    required this.estado,
    required this.fechaini,
    required this.fechafin,
    required this.renovarauto,
    this.paquete,
    required this.syncStatus,
  });

  factory Subscripcion.fromJson(Map<String, dynamic> json) => Subscripcion(
        id: json['id'],
        idusuario: json['idusuario'],
        idpaquete: json['idpaquete'],
        estado: json['estado'],
        fechaini: DateTime.parse(json['fechaini']),
        fechafin: DateTime.parse(json['fechafin']),
        renovarauto: json['renovarauto'] is String ? bool.parse(json['renovarauto']) : json['renovarauto'],
        paquete:
            json['paquete'] == null ? null : json['paquete'] is String
          ? Paquete.fromJson(jsonDecode(json['paquete']))
          : Paquete.fromJson(json['paquete']),
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idusuario": idusuario,
        "idpaquete": idpaquete,
        "estado": estado,
        "fechaini": fechaini.toIso8601String(),
        "fechafin": fechafin.toIso8601String(),
        "renovarauto": renovarauto ? "true" : "false",
        "paquete": paquete == null ? null : jsonEncode(paquete?.toJson()),
        "sync_status": syncStatus,
      };
}
