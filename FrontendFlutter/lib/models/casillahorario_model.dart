import 'package:proyecto/helpers/syncable_interface.dart';

class CasillaHorario implements Syncable {
  String horaini;
  String horafin;
  int dia;

  @override
  int id;
  @override
  int syncStatus;


  @override
  String get tablename => 'casillahorario';

  CasillaHorario({
    required this.id,
    required this.horaini,
    required this.horafin,
    required this.dia,
    required this.syncStatus,
  });

  factory CasillaHorario.fromJson(Map<String, dynamic> json) =>
      CasillaHorario(
        id: json['id'],
        horaini: json['horaini'],
        horafin: json['horafin'],
        dia: json['dia'],
        syncStatus: json['sync_status'] ?? 0
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "horaini": horaini,
    "horafin": horafin,
    "dia": dia,
    "sync_status": syncStatus,
  };
}
