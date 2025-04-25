class Metricas {
  int id;
  double? estatura;
  double? peso;
  double? maxcardio;
  int? maxpulso;
  int? frecuenciasemanal;

  Metricas({
    required this.id,
    this.estatura,
    this.peso,
    this.maxcardio,
    this.maxpulso,
    this.frecuenciasemanal,
  });

  factory Metricas.fromJson(Map<String, dynamic> json) => Metricas(
        id: json['id'],
        estatura: json['estatura'] != null ? double.parse(json['estatura']) : null,
        peso: json['peso'] != null ? double.parse(json['peso']) : null,
        maxcardio: json['maxcardio'] != null ? double.parse(json['maxcardio']) : null,
        maxpulso: json['maxpulso'],
        frecuenciasemanal: json['frecuenciasemanal'],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estatura": estatura,
    "peso": peso,
    "maxcardio": maxcardio,
    "maxpulso": maxpulso,
    "frecuenciasemanal": frecuenciasemanal,
  };
}
