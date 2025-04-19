class Domicilio {
  final int id;
  final String calle;
  final int numext;
  final int numint;
  final String asentamiento;
  final int codigop;

  const Domicilio({
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
}
