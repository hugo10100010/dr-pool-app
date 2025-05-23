import 'dart:ffi';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:typed_data';

class Cuenta {
  int id;
  String nombreusu;
  Uint8List? avatar;

  Cuenta({
    required this.id,
    required this.nombreusu,
    this.avatar,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
        id: json['id'],
        nombreusu: json['nombreusu'],
        avatar: json['avatar'] != null ? base64Decode(json['avatar']) : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreusu': nombreusu,
    };
  }
}
