class Cuenta {
  final int id;
  final String nombreusu;
  final String password;
  final String avatar;

  const Cuenta({
    required this.id,
    required this.nombreusu,
    required this.password,
    required this.avatar,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
        id: json['id'],
        nombreusu: json['nombreusu'],
        password: json['password'],
        avatar: json['avatar'],
      );
}
