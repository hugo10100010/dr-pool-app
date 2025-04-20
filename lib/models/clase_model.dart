import 'dart:convert' as d;

class Clase {
  final int id;
  final int idcoach;
  final List<int> idcasillas;
  final String descripcion;

  const Clase({
    required this.id,
    required this.idcoach,
    required this.idcasillas,
    required this.descripcion,
  });

  factory Clase.fromJson(Map<String, dynamic> json) => Clase(
        id: json['id'],
        idcoach: json['idcoach'],
        idcasillas: d.json.decode(json['idcasillas']),
        descripcion: json['descripcion'],
      );
}