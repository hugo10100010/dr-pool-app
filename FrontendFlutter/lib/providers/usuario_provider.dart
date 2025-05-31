import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:proyecto/services/clase_servicio.dart';
import '../models/usuario_model.dart';

class UsuarioProvider extends ChangeNotifier{
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void actualizarCuenta(String? nombreusu, Uint8List? nuevoAvatar) {
    if(usuario != null) {
      nombreusu == null ? true : _usuario!.cuenta?.nombreusu = nombreusu;
      //nuevoAvatar == null ? true : _usuario!.cuenta?.avatar = nuevoAvatar;
      notifyListeners();
    }
  }

  void actualizarPersonales(String? nombre, String? apellidop, String? apellidom, String? email, String? telefono) {
    if(usuario != null) {
      nombre == null ? true : _usuario!.personales?.nombre =nombre;
      apellidop == null ? true : _usuario!.personales?.apellidop = apellidop;
      apellidom == null ? true : _usuario!.personales?.apellidom = apellidom;
      email == null ? true : _usuario!.personales?.email = email;
      telefono == null ? true : _usuario!.personales?.telefono = telefono;
      notifyListeners();
    }
  }

  void actualizarDomicilio(String? calle, int? numext, int? numint, String? asentamiento, int? codigop) {
    if(usuario != null) {
      calle == null ? true : _usuario!.domicilio?.calle = calle;
      numext == null ? true : _usuario!.domicilio?.numext = numext;
      numint == null ? true : _usuario!.domicilio?.numint = numint;
      asentamiento == null ? true : _usuario!.domicilio?.asentamiento = asentamiento;
      codigop == null ? true : _usuario!.domicilio?.codigop = codigop;
      notifyListeners();
    }
  }

  void actualizarMetricas(double? estatura, double? peso, double? maxcardio, int? maxpulso, int? frecuenciasemanal) {
    if (_usuario != null) {
      estatura == null ? true : _usuario!.metricas?.estatura = estatura;
      peso == null ? true : _usuario!.metricas?.peso = peso;
      maxcardio == null ? true : _usuario!.metricas?.maxcardio = maxcardio;
      maxpulso == null ? true : _usuario!.metricas?.maxpulso = maxpulso;
      frecuenciasemanal == null ? true : _usuario!.metricas?.frecuenciasemanal = frecuenciasemanal;
      notifyListeners();
    }
  }

  Future<void> actualizarClases() async {
    if(_usuario != null) {
      _usuario!.clases = await ClaseServicio().getClases();
      notifyListeners();
    }
  }

  void logout() {
    _usuario = null;
    notifyListeners();
  }
}