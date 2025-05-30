import 'package:proyecto/helpers/syncable_interface.dart';

class Metricas implements Syncable {
  double? estatura;
  double? peso;
  double? maxcardio;
  int? maxpulso;
  int? frecuenciasemanal;
  @override
  String get tablename => 'metricas';
  @override
  int id;
  @override
  int syncStatus;

  Metricas({
    required this.id,
    this.estatura,
    this.peso,
    this.maxcardio,
    this.maxpulso,
    this.frecuenciasemanal,
    required this.syncStatus,
  });

  factory Metricas.fromJson(Map<String, dynamic> json) => Metricas(
        id: json['id'],
        estatura: json['estatura'] == null ? null : json['estatura'] is String ? double.parse(json['estatura']) : json['estatura'],
        peso: json['peso'] == null ? null : json['peso'] is String ? double.parse(json['peso']) : json['peso'],
        maxcardio: json['maxcardio'] == null ? null : json['maxcardio'] is String ? double.parse(json['maxcardio']) : json['maxcardio'],
        maxpulso: json['maxpulso'] == null ? null : json['maxpulso'],
        frecuenciasemanal: json['frecuenciasemanal'] == null ? null : json['frecuenciasemanal'],
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estatura": estatura,
    "peso": peso,
    "maxcardio": maxcardio,
    "maxpulso": maxpulso,
    "frecuenciasemanal": frecuenciasemanal,
    "sync_status": syncStatus,
  };
}
