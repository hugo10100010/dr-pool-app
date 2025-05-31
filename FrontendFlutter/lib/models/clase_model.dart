import 'dart:convert';
import 'package:proyecto/helpers/syncable_interface.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/models/personales_model.dart';

class Clase implements Syncable {
  int idcoach;
  int idcasilla;
  int idcurso;
  Personales coach;
  CasillaHorario casilla;
  Curso curso;
  @override
  int id;
  @override
  int syncStatus;

  @override
  String get tablename => 'clase';

  Clase(
      {required this.id,
      required this.idcoach,
      required this.idcasilla,
      required this.idcurso,
      required this.coach,
      required this.casilla,
      required this.curso,
      required this.syncStatus});

  factory Clase.fromJson(Map<String, dynamic> json) {
    return Clase(
      id: json['id'],
      idcoach: json['idcoach'],
      idcasilla: json['idcasilla'],
      idcurso: json['idcurso'],
      coach: (() {
        final coachRaw = json['coach'];
        final coachMap = coachRaw is String ? jsonDecode(coachRaw) : coachRaw;

        final personalesRaw = coachMap['personales'];
        final personales = personalesRaw is String
            ? Personales.fromJson(jsonDecode(personalesRaw))
            : Personales.fromJson(personalesRaw);
        return personales;
      })(),
      casilla: json['casillahorario'] is String
          ? CasillaHorario.fromJson(jsonDecode(json['casillahorario']))
          : CasillaHorario.fromJson(json['casillahorario']),
      curso: json['curso'] is String
          ? Curso.fromJson(jsonDecode(json['curso']))
          : Curso.fromJson(json['curso']),
      syncStatus: json['sync_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "idcoach": idcoach,
        "idcasilla": idcasilla,
        "idcurso": idcurso,
        "coach": jsonEncode({"personales": coach.toJson()}),
        "casillahorario": jsonEncode(casilla.toJson()),
        "curso": jsonEncode(curso.toJson()),
        "sync_status": syncStatus,
      };
}
