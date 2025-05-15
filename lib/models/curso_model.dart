import 'dart:convert' as d;

class Curso {
  int id;
  String curso;
  String descripcion;

  Curso({
    required this.id,
    required this.curso,
    required this.descripcion,
  });

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json['id'],
        curso: json['curso'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idcoach": curso,
    "descripcion": descripcion
  };
}