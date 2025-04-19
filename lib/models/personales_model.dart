class Personales {
  final int id;
  final String nombre;
  final String apellidop;
  final String apellidom;
  final String email;
  final String telefono;
  final String tipodocumento;
  final String documento;

  const Personales({
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
}
