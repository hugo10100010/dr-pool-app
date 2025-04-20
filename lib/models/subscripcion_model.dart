class Subscripcion {
  final int id;
  final int idusuario;
  final int idpaquete;
  final String estado;
  final DateTime fechaini;
  final DateTime fechafin;
  final bool renovarauto;

  const Subscripcion({
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
