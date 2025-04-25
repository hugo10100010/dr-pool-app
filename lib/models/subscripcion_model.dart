class Subscripcion {
  int id;
  int idusuario;
  int idpaquete;
  String estado;
  DateTime fechaini;
  DateTime fechafin;
  bool renovarauto;

  Subscripcion({
    required this.id,
    required this.idusuario,
    required this.idpaquete,
    required this.estado,
    required this.fechaini,
    required this.fechafin,
    required this.renovarauto,
  });

  factory Subscripcion.fromJson(Map<String, dynamic> json) => Subscripcion(
        id: json['id'],
        idusuario: json['idusuario'],
        idpaquete: json['idpaquete'],
        estado: json['estado'],
        fechaini: json['fechaini'],
        fechafin: json['fechafin'],
        renovarauto: json['renovarauto'],
      );
}
