import 'dart:convert';

import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/cuenta_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/models/domicilio_model.dart';
import 'package:proyecto/models/historial_model.dart';
import 'package:proyecto/models/metricas_model.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/models/personales_model.dart';
import 'package:proyecto/models/horario_model.dart';
import 'package:proyecto/models/subscripcion_model.dart';

class Usuario {
  int id;
  int idpersonales;
  int iddomicilio;
  int idcuenta;
  int idmetricas;
  int tipousuario;
  Personales personales;
  Cuenta cuenta;
  Metricas metricas;
  Domicilio domicilio;
  Subscripcion? subscripcion;
  List<Horario>? horario;
  List<Clase>? clases;
  List<Historial>? historial;

  Usuario(
      {required this.id,
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
      this.historial});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        idpersonales: json['idpersonales'],
        iddomicilio: json['iddomicilio'],
        idcuenta: json['idcuenta'],
        idmetricas: json['idmetricas'],
        tipousuario: json['tipousuario'],
        personales: Personales.fromJson(json['personales']),
        cuenta: Cuenta.fromJson(json['cuenta']),
        metricas: Metricas.fromJson(json['metricas']),
        domicilio: Domicilio.fromJson(json['domicilio']),
        subscripcion: json['subscripcion'] == null
            ? null
            : Subscripcion.fromJson(json['subscripcion']),
        horario: json['horario'] == null
            ? null
            : List.castFrom(json['horario'])
                .map<Horario>((e) => Horario.fromJson(e))
                .toList(),
        clases: json['clases'] == null
            ? null
            : List.castFrom(json['clases'])
                .map<Clase>((e) => Clase.fromJson(e))
                .toList(),
        historial: json['historial'] == null
            ? null
            : List.castFrom(json['historial'])
                .map<Historial>((e) => Historial.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'idpersonales': idpersonales,
        'iddomicilio': iddomicilio,
        'idcuenta': idcuenta,
        'idmetricas': idmetricas,
        'tipousuario': tipousuario,
        'personales': personales.toJson(),
        'cuenta': cuenta.toJson(),
        'metricas': metricas.toJson(),
        'domicilio': domicilio.toJson(),
        'horario': jsonEncode(horario),
      };
}
