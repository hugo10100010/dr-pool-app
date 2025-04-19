class Metricas {
  final int id;
  final double estatura;
  final double peso;
  final double maxcardio;
  final int maxpulso;
  final int frecuenciasemanal;

  const Metricas({
    required this.id,
    required this.estatura,
    required this.peso,
    required this.maxcardio,
    required this.maxpulso,
    required this.frecuenciasemanal,
  });

  factory Metricas.fromJson(Map<String, dynamic> json) => Metricas(
        id: json['id'],
        estatura: json['estatura'],
        peso: json['peso'],
        maxcardio: json['maxcardio'],
        maxpulso: json['maxpulso'],
        frecuenciasemanal: json['frecuenciasemanal'],
      );
}
