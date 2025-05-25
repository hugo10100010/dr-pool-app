import 'package:proyecto/models/clase_model.dart';

class Horario {
  int id;
  int idusuario;
  int idclase;
  Clase clase;

  Horario({
    required this.id,
    required this.idusuario,
    required this.idclase,
    required this.clase,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json['id'],
        idusuario: json['idusuario'],
        idclase: json['idclase'],
        clase: Clase.fromJson(json['clase']),
      );
}
