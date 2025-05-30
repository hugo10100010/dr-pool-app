import 'package:proyecto/helpers/syncable_interface.dart';

class Domicilio implements Syncable{
  String? calle;
  int? numext;
  int? numint;
  String? asentamiento;
  int? codigop;
  @override
  String get tablename => 'domicilio';
  @override
  int id;
  @override
  int syncStatus;

  Domicilio({
    required this.id,
    required this.calle,
    required this.numext,
    required this.numint,
    required this.asentamiento,
    required this.codigop,
    required this.syncStatus,
  });

  factory Domicilio.fromJson(Map<String, dynamic> json) => Domicilio(
        id: json['id'],
        calle: json['calle'],
        numext: json['numext'],
        numint: json['numint'],
        asentamiento: json['asentamiento'],
        codigop: json['codigop'] is String ? int.parse(json['codigop']) : json['codigop'],
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "calle": calle,
    "numext": numext,
    "numint": numint,
    "asentamiento": asentamiento,
    "codigop": codigop,
    "sync_status": syncStatus,
  };
}
