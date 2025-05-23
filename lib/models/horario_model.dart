class Horario {
  int id;
  int idusuario;
  int idclase;

  Horario({
    required this.id,
    required this.idusuario,
    required this.idclase,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json['id'],
        idusuario: json['idusuario'],
        idclase: json['idclase'],
      );
}
