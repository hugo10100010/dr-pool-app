import 'package:proyecto/helpers/syncable_interface.dart';

class Personales implements Syncable{
  String nombre;
  String apellidop;
  String apellidom;
  String email;
  String telefono;
  String tipodocumento;
  String documento;
  @override
  String get tablename => 'personales';
  @override
  int id;
  @override
  int syncStatus;

  Personales({
    required this.id,
    required this.nombre,
    required this.apellidop,
    required this.apellidom,
    required this.email,
    required this.telefono,
    required this.tipodocumento,
    required this.documento,
    required this.syncStatus,
  });

  factory Personales.fromJson(Map<String, dynamic> json) => Personales(
        id: json['id'],
        nombre: json['nombre'],
        apellidop: json['apellidop'],
        apellidom: json['apellidom'],
        email: json['email'],
        telefono: json['telefono'],
        tipodocumento: json['tipodocumento'],
        documento: json['documento'],
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellidop': apellidop,
        'apellidom': apellidom,
        'email': email,
        'telefono': telefono,
        'tipodocumento': tipodocumento,
        'documento': documento,
        "sync_status": syncStatus,
      };
}
