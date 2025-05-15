class Paquete {
  int id;
  double precio;
  int clases;
  bool flexible;

  Paquete({
    required this.id,
    required this.precio,
    required this.clases,
    required this.flexible,
  });

  factory Paquete.fromJson(Map<String, dynamic> json) => Paquete(
        id: json['id'],
        precio: double.parse(json['precio']),
        clases: int.parse(json['clases'].toString()),
        flexible: bool.parse(json['flexible'].toString()),
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "precio": precio,
    "clases": clases,
    "flexible": flexible,
  };
}
