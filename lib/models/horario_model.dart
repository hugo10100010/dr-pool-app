import 'dart:convert';

import 'package:proyecto/helpers/syncable_interface.dart';
import 'package:proyecto/models/clase_model.dart';

class Horario implements Syncable {
  int idusuario;
  int idclase;
  Clase clase;
  @override
  String get tablename => 'horario';
  @override
  int id;
  @override
  int syncStatus;

  Horario({
    required this.id,
    required this.idusuario,
    required this.idclase,
    required this.clase,
    required this.syncStatus,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json['id'],
        idusuario: json['idusuario'],
        idclase: json['idclase'],
        clase: json['clase'] is String
                ? Clase.fromJson(jsonDecode(json['clase']))
                : Clase.fromJson(json['clase']),
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idusuario": idusuario,
        "idclase": idclase,
        "clase": jsonEncode(clase.toJson()),
        "sync_status": syncStatus,
      };
}
