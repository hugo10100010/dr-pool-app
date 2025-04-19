class CasillaHorario {
  final int id;
  final String horaini;
  final String horafin;
  final String dia;

  const CasillaHorario({
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
}
