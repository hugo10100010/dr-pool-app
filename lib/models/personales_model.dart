class Personales {
  int id;
  String nombre;
  String apellidop;
  String apellidom;
  String email;
  String telefono;
  String tipodocumento;
  String documento;

  Personales({
    required this.id,
    required this.nombre,
    required this.apellidop,
    required this.apellidom,
    required this.email,
    required this.telefono,
    required this.tipodocumento,
    required this.documento,
  });

  factory Personales.fromJson(Map<String, dynamic> json) => Personales(
        id: json['id'],
        nombre: json['nombre'],
        apellidop: json['apellidop'],
        apellidom: json['apellidom'],
        email: json['email'],
        telefono: json['telefono'],
        tipodocumento: json['tipodocumento'],
        documento: json['documento'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellidop': apellidop,
        'apellidom': apellidom,
        'email': email,
        'telefono': telefono,
        'tipodocumento': tipodocumento,
        'documento': documento,
      };
}
