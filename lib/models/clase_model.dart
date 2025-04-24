import 'dart:convert' as d;

class Clase {
  int id;
  int idcoach;
  int idcasilla;
  String descripcion;

  Clase({
    required this.id,
    required this.idcoach,
    required this.idcasilla,
    required this.descripcion,
  });

  factory Clase.fromJson(Map<String, dynamic> json) => Clase(
        id: json['id'],
        idcoach: json['idcoach'],
        idcasilla: json['idcasilla'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idcoach": idcoach,
    "idcasilla": idcasilla,
    "descripcion": descripcion
  };
}