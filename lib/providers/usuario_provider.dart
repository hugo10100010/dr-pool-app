import 'package:flutter/material.dart';
import '../models/usuario_model.dart';

class UsuarioProvider extends ChangeNotifier{
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void logout() {
    _usuario = null;
    notifyListeners();
  }
}