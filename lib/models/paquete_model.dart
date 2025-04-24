class Paquete {
  int id;
  double precio;
  String beneficios;

  Paquete({
    required this.id,
    required this.precio,
    required this.beneficios,
  });

  factory Paquete.fromJson(Map<String, dynamic> json) => Paquete(
        id: json['id'],
        precio: double.parse(json['precio']),
        beneficios: json['beneficios'],
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "precio": precio,
    "beneficios": beneficios
  };
}
