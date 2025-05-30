import 'dart:convert';

import 'package:proyecto/helpers/syncable_interface.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/cuenta_model.dart';
import 'package:proyecto/models/domicilio_model.dart';
import 'package:proyecto/models/historial_model.dart';
import 'package:proyecto/models/metricas_model.dart';
import 'package:proyecto/models/personales_model.dart';
import 'package:proyecto/models/horario_model.dart';
import 'package:proyecto/models/subscripcion_model.dart';

class Usuario implements Syncable {
  int? idpersonales;
  int? iddomicilio;
  int? idcuenta;
  int? idmetricas;
  int? tipousuario;
  Personales? personales;
  Cuenta? cuenta;
  Metricas? metricas;
  Domicilio? domicilio;
  Subscripcion? subscripcion;
  List<Horario>? horario;
  List<Clase>? clases;
  List<Historial>? historial;
  @override
  String get tablename => "usuario";
  @override
  int id;
  @override
  int syncStatus;

  Usuario({
    required this.id,
    required this.idpersonales,
    required this.iddomicilio,
    required this.idcuenta,
    required this.idmetricas,
    required this.tipousuario,
    required this.personales,
    required this.cuenta,
    required this.metricas,
    required this.domicilio,
    this.subscripcion,
    this.horario,
    this.clases,
    this.historial,
    required this.syncStatus,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        idpersonales: json['idpersonales'],
        iddomicilio: json['iddomicilio'],
        idcuenta: json['idcuenta'],
        idmetricas: json['idmetricas'],
        tipousuario: json['tipousuario'],
        personales: (json['personales'] == null ||
                json['personales'] == '' ||
                json['personales'] == 'null')
            ? null
            : json['personales'] is String
                ? Personales.fromJson(jsonDecode(json['personales']))
                : Personales.fromJson(json['personales']),
        cuenta: (json['cuenta'] == null ||
                json['cuenta'] == '' ||
                json['cuenta'] == 'null')
            ? null
            : json['cuenta'] is String
                ? Cuenta.fromJson(jsonDecode(json['cuenta']))
                : Cuenta.fromJson(json['cuenta']),
        metricas: (json['metricas'] == null ||
                json['metricas'] == '' ||
                json['metricas'] == 'null')
            ? null
            : json['metricas'] is String
                ? Metricas.fromJson(jsonDecode(json['metricas']))
                : Metricas.fromJson(json['metricas']),
        domicilio: (json['domicilio'] == null ||
                json['domicilio'] == '' ||
                json['domicilio'] == 'null')
            ? null
            : json['domicilio'] is String
                ? Domicilio.fromJson(jsonDecode(json['domicilio']))
                : Domicilio.fromJson(json['domicilio']),
        subscripcion: (json['subscripcion'] == null ||
                json['subscripcion'] == '' ||
                json['subscripcion'] == 'null')
            ? null
            : json['subscripcion'] is String
                ? Subscripcion.fromJson(jsonDecode(json['subscripcion']))
                : Subscripcion.fromJson(json['subscripcion']),
        horario: (() {
          final raw = json['horario'];

          if (raw == null || raw == '' || raw == "null") return null;
          final list = raw is String ? jsonDecode(raw) as List : raw as List;

          return list
              .map((e) => Horario.fromJson(
                  e is String ? jsonDecode(e) : e as Map<String, dynamic>))
              .toList();
        })(),
        clases: (() {
          final raw = json['clases'];

          if (raw == null || raw == '' || raw == "null") return null;

          final list = raw is String ? jsonDecode(raw) as List : raw as List;

          return list
              .map((e) => Clase.fromJson(
                  e is String ? jsonDecode(e) : e as Map<String, dynamic>))
              .toList();
        })(),
        historial: (() {
          final raw = json['historial'];

          if (raw == null || raw == '' || raw == "null") return null;

          final list = raw is String ? jsonDecode(raw) as List : raw as List;

          return list
              .map((e) => Historial.fromJson(
                  e is String ? jsonDecode(e) : e as Map<String, dynamic>))
              .toList();
        })(),
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'idpersonales': idpersonales,
        'iddomicilio': iddomicilio,
        'idcuenta': idcuenta,
        'idmetricas': idmetricas,
        'tipousuario': tipousuario,
        'personales': jsonEncode(personales?.toJson()),
        'cuenta': jsonEncode(cuenta?.toJson()),
        'metricas': jsonEncode(metricas?.toJson()),
        'domicilio': jsonEncode(domicilio?.toJson()),
        'subscripcion': jsonEncode(subscripcion?.toJson()),
        'horario': jsonEncode(horario),
        'clases': jsonEncode(clases),
        'historial': jsonEncode(historial),
        "sync_status": syncStatus,
      };
}
