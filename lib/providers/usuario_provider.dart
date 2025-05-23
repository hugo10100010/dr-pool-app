import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../models/usuario_model.dart';

class UsuarioProvider extends ChangeNotifier{
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void actualizarAvatar(Uint8List nuevoAvatar) {
    if(usuario != null) {
      _usuario!.cuenta.avatar = nuevoAvatar;
      notifyListeners();
    }
  }

  void logout() {
    _usuario = null;
    notifyListeners();
  }
}