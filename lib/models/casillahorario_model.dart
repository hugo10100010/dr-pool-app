class CasillaHorario {
  int id;
  String horaini;
  String horafin;
  int dia;

  CasillaHorario({
    required this.id,
    required this.horaini,
    required this.horafin,
    required this.dia,
  });

  factory CasillaHorario.fromJson(Map<String, dynamic> json) =>
      CasillaHorario(
        id: json['id'],
        horaini: json['horaini'],
        horafin: json['horafin'],
        dia: json['dia'],
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "horaini": horaini,
    "horafin": horafin,
    "dia": dia,
  };
}
