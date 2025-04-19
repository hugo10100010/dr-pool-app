import 'package:flutter/material.dart';
import 'package:proyecto/models/usuario_model.dart';

class AuthProvider with ChangeNotifier{
  Usuario? _usuario;
  Usuario? get usuario => _usuario;

  Future<void> login() {
    
  }
}