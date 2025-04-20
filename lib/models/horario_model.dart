class Horario {
  final int id;
  final int idusuario;
  final String rutina;

  const Horario({
    required this.id,
    required this.idusuario,
    required this.rutina,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json['id'],
        idusuario: json['idusuario'],
        rutina: json['rutina'],
      );
}
