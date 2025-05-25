class Domicilio {
  int id;
  String? calle;
  int? numext;
  int? numint;
  String? asentamiento;
  int? codigop;

  Domicilio({
    required this.id,
    required this.calle,
    required this.numext,
    required this.numint,
    required this.asentamiento,
    required this.codigop,
  });

  factory Domicilio.fromJson(Map<String, dynamic> json) => Domicilio(
        id: json['id'],
        calle: json['calle'],
        numext: json['numext'],
        numint: json['numint'],
        asentamiento: json['asentamiento'],
        codigop: json['codigop'],
      );

  Map<String,dynamic> toJson() => {
    "id": id,
    "calle": calle,
    "numext": numext,
    "numint": numint,
    "asentamiento": asentamiento,
    "codigop": codigop,
  };
}
