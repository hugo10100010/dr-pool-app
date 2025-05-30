import 'package:proyecto/helpers/syncable_interface.dart';

class Paquete implements Syncable{
  double precio;
  int clases;
  bool flexible;
  @override
  String get tablename => 'paquete';
  @override
  int id;
  @override
  int syncStatus;

  Paquete({
    required this.id,
    required this.precio,
    required this.clases,
    required this.flexible,
    required this.syncStatus
  });

  factory Paquete.fromJson(Map<String, dynamic> json) => Paquete(
        id: json['id'],
        precio:  json['precio'] is String ? double.parse(json['precio']) : json['precio'],
        clases: json['clases'] is String ? int.parse(json['clases']) : json['clases'],
        flexible: json['flexible'] is String ? bool.parse(json['flexible']) : json['flexible'],
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "precio": precio,
    "clases": clases,
    "flexible": flexible ? "true" : "false",
    "sync_status": syncStatus,
  };
}
