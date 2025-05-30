import 'dart:convert';

import 'package:proyecto/helpers/syncable_interface.dart';
import 'package:proyecto/models/paquete_model.dart';

class Historial implements Syncable {
  int idusuario;
  int idpaquete;
  DateTime fechaini;
  DateTime fechafin;
  String metodo;
  Paquete paquete;
  @override
  String get tablename => 'historial';
  @override
  int id;
  @override
  int syncStatus;

  Historial({
    required this.id,
    required this.idusuario,
    required this.idpaquete,
    required this.fechaini,
    required this.fechafin,
    required this.metodo,
    required this.paquete,
    required this.syncStatus,
  });

  factory Historial.fromJson(Map<String, dynamic> json) => Historial(
        id: json['id'],
        idusuario: json['idusuario'],
        idpaquete: json['idpaquete'],
        fechaini: DateTime.parse(json['fechaini']),
        fechafin: DateTime.parse(json['fechafin']),
        metodo: json['metodo'],
        paquete: json['paquete'] is String
            ? Paquete.fromJson(jsonDecode(json['paquete']))
            : Paquete.fromJson(json['paquete']),
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idusuario": idusuario,
        "idpaquete": idpaquete,
        "fechaini": fechaini.toIso8601String(),
        "fechafin": fechafin.toIso8601String(),
        "metodo": metodo,
        "paquete": jsonEncode(paquete.toJson()),
        "sync_status": syncStatus,
      };
}
