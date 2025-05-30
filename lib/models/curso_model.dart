
import 'package:proyecto/helpers/syncable_interface.dart';

class Curso implements Syncable{
  String curso;
  String descripcion;

  @override
  String get tablename => 'curso';
  @override
  int id;
  @override
  int syncStatus;

  Curso({
    required this.id,
    required this.curso,
    required this.descripcion,
    required this.syncStatus,
  });

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json['id'],
        curso: json['curso'],
        descripcion: json['descripcion'],
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "curso": curso,
    "descripcion": descripcion,
    "sync_status": syncStatus,
  };
}