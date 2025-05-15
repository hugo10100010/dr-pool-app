import 'dart:convert' as d;

import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/models/personales_model.dart';

class Clase {
  int id;
  int idcoach;
  int idcasilla;
  int idcurso;
  Personales coach;
  CasillaHorario casilla;
  Curso curso;

  Clase({
    required this.id,
    required this.idcoach,
    required this.idcasilla,
    required this.idcurso,
    required this.coach,
    required this.casilla,
    required this.curso,
  });

  factory Clase.fromJson(Map<String, dynamic> json) => Clase(
        id: json['id'],
        idcoach: json['idcoach'],
        idcasilla: json['idcasilla'],
        idcurso: json['idcurso'],
        coach: Personales.fromJson(json['coach']['personales']),
        casilla: CasillaHorario.fromJson(json['casillahorario']),
        curso: Curso.fromJson(json['curso']),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idcoach": idcoach,
    "idcasilla": idcasilla,
    "idcurso": idcurso,
  };
}