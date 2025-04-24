class Horario {
  int id;
  int idusuario;
  String rutina;

  Horario({
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
