import 'package:flutter/material.dart';
import 'package:proyecto/screens/admin/pages/usuarios/pages/consultar/detallesusuario.dart';
import 'package:proyecto/screens/admin/pages/usuarios/pages/modificar/detallesusuario.dart';
import 'package:proyecto/screens/cliente/home_screen.dart';
import 'package:proyecto/screens/couch/home_screen.dart';
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
  static const String personalescliente = '/personalescliente';
  static const String metricascliente = '/metricascliente';
  static const String domiciliocliente = '/domiciliocliente';
  static const String subscripcioncliente = '/subscripcioncliente';
  static const String couchhome = '/couchhome';

  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) {
    return {
      adminhome: (context) => AdminHomePage(),
      clientehome: (context) => ClienteHomePage(),
      couchhome: (context) => CouchHomePage(),
      login: (context) => Login(),
      registrar: (context) => RegisterForm(),
      detallesusuario: (context) => Detallesusuario(),
      detallesusuariomodif: (context) => Detallesusuariomodif(),
      cuentacliente: (context) => CuentaPage(),
      personalescliente: (context) => Placeholder(),
      metricascliente: (context) => Placeholder(),
      domiciliocliente: (context) => Placeholder(),
      subscripcioncliente: (context) => Placeholder(),
      placeholder: (context) => Placeholder(),
    };
  }
}
