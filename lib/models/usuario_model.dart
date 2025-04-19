class Usuario {
  final int id;
  final int idpersonales;
  final int iddomicilio;
  final int idcuenta;
  final int idmetricas;
  final int tipousuario;

  const Usuario(
      {required this.id,
      required this.idpersonales,
      required this.iddomicilio,
      required this.idcuenta,
      required this.idmetricas,
      required this.tipousuario});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        idpersonales: json['idpersonales'],
        iddomicilio: json['iddomicilio'],
        idcuenta: json['idcuenta'],
        idmetricas: json['idmetricas'],
        tipousuario: json['tipousuario'],
      );
  
}
