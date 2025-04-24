import 'package:proyecto/models/cuenta_model.dart';
import 'package:proyecto/models/domicilio_model.dart';
import 'package:proyecto/models/metricas_model.dart';
import 'package:proyecto/models/personales_model.dart';

class Usuario {
  int id;
  int idpersonales;
  int iddomicilio;
  int idcuenta;
  int idmetricas;
  int tipousuario;
  Personales personales;
  Cuenta cuenta;
  Metricas metricas;
  Domicilio domicilio;

  Usuario({
    required this.id,
    required this.idpersonales,
    required this.iddomicilio,
    required this.idcuenta,
    required this.idmetricas,
    required this.tipousuario,
    required this.personales,
    required this.cuenta,
    required this.metricas,
    required this.domicilio,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json['id'],
      idpersonales: json['idpersonales'],
      iddomicilio: json['iddomicilio'],
      idcuenta: json['idcuenta'],
      idmetricas: json['idmetricas'],
      tipousuario: json['tipousuario'],
      personales: Personales.fromJson(json['personales']),
      cuenta: Cuenta.fromJson(json['cuenta']),
      metricas: Metricas.fromJson(json['metricas']),
      domicilio: Domicilio.fromJson(json['domicilio']),
      );

    Map<String, dynamic> toJson() => {
        'id': id,
        'idpersonales': idpersonales,
        'iddomicilio': iddomicilio,
        'idcuenta': idcuenta,
        'idmetricas': idmetricas,
        'tipousuario': tipousuario,
        'personales': personales.toJson(),
        'cuenta': cuenta.toJson(),
        'metricas': metricas.toJson(),
        'domicilio': domicilio.toJson(),
      };
}
