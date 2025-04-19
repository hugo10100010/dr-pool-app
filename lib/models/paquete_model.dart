class Paquete {
  final int id;
  final double precio;
  final String beneficios;

  const Paquete({
    required this.id,
    required this.precio,
    required this.beneficios,
  });

  factory Paquete.fromJson(Map<String, dynamic> json) => Paquete(
        id: json['id'],
        precio: json['precio'],
        beneficios: json['beneficios'],
      );
}
