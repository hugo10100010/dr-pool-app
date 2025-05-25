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

  void actualizarPersonales(String nombre, String apellidop, String apellidom, String email, String telefono) {
    if(usuario != null) {
      _usuario!.personales.nombre =nombre;
      _usuario!.personales.apellidop = apellidop;
      _usuario!.personales.apellidom = apellidom;
      _usuario!.personales.email = email;
      _usuario!.personales.telefono = telefono;
      notifyListeners();
    }
  }

  void actualizarDomicilio(String calle, int numext, int numint, String asentamiento, int codigop) {
    if(usuario != null) {
      _usuario!.domicilio.calle = calle;
      _usuario!.domicilio.numext = numext;
      _usuario!.domicilio.numint = numint;
      _usuario!.domicilio.asentamiento = asentamiento;
      _usuario!.domicilio.codigop = codigop;
    }
  }

  void logout() {
    _usuario = null;
    notifyListeners();
  }
}