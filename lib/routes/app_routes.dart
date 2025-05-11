import 'package:flutter/material.dart';
import 'package:proyecto/screens/admin/pages/usuarios/pages/consultar/detallesusuario.dart';
import 'package:proyecto/screens/admin/pages/usuarios/pages/modificar/detallesusuario.dart';
import 'package:proyecto/screens/cliente/home_screen.dart';
import 'package:proyecto/screens/cliente/pages/drawer/cuenta/cuenta_page.dart';
import '../screens/login_screen.dart';
import '../screens/registro_screen.dart';
import '../screens/admin/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String registrar = '/registrar';
  static const String clientehome = '/home';
  static const String adminhome = '/adminhome';
  static const String placeholder = '/placeholder';
  static const String detallesusuario = '/detallesusuario';
  static const String detallesusuariomodif = '/detallesusuariomodif';
  static const String cuentacliente = '/cuentacliente';

  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) {
    return {
      adminhome: (context) => AdminHomePage(),
      clientehome: (context) => ClienteHomePage(),
      login: (context) => Login(),
      registrar: (context) => RegisterForm(),
      detallesusuario: (context) => Detallesusuario(),
      detallesusuariomodif: (context) => Detallesusuariomodif(),
      cuentacliente: (context) => CuentaPage(),
      placeholder: (context) => Placeholder(),
    };
  }
}
