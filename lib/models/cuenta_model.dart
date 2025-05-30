import 'dart:typed_data';
import 'dart:convert';
import 'package:proyecto/helpers/syncable_interface.dart';

class Cuenta  implements Syncable{
  String nombreusu;
  String? password;
  Uint8List? avatar;

  @override
  String get tablename => 'cuenta';
  @override
  int id;
  @override
  int syncStatus;

  Cuenta({
    required this.id,
    required this.nombreusu,
    required this.password,
    this.avatar,
    required this.syncStatus,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
        id: json['id'],
        nombreusu: json['nombreusu'],
        password: json['password'],
        avatar: json['avatar'] != null ? base64Decode(json['avatar']) : null,
        syncStatus: json['sync_status'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreusu': nombreusu,
      'password': password,
      'avatar': avatar == null ? null : base64Encode(avatar!),
      'sync_status': syncStatus,
    };
  }
}
