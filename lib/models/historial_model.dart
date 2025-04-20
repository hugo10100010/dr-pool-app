class Historial {
  final int id;
  final int idusuario;
  final int idpaquete;
  final DateTime fechaini;
  final DateTime fechafin;
  final String metodo;

  const Historial({
    required this.id,
    required this.idusuario,
    required this.idpaquete,
    required this.fechaini,
    required this.fechafin,
    required this.metodo,
  });

  factory Historial.fromJson(Map<String, dynamic> json) => Historial(
        id: json['id'],
        idusuario: json['idusuario'],
        idpaquete: json['idpaquete'],
        fechaini: json['fechaini'],
        fechafin: json['fechafin'],
        metodo: json['metodo'],
      );
}
