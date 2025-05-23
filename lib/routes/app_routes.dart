import 'package:flutter/material.dart';
import 'package:proyecto/screens/admin/pages/usuarios/pages/consultar/detallesusuario.dart';
import 'package:proyecto/screens/admin/pages/usuarios/pages/modificar/detallesusuario.dart';
import 'package:proyecto/screens/cliente/home_screen.dart';
import 'package:proyecto/screens/cliente/pages/drawer/domicilio/domicilio_page.dart';
import 'package:proyecto/screens/cliente/pages/drawer/personales/personales_page.dart';
import 'package:proyecto/screens/cliente/pages/drawer/subscripcion/horarios.dart';
import 'package:proyecto/screens/cliente/pages/drawer/subscripcion/subscripcion_page.dart';
import 'package:proyecto/screens/couch/home_screen.dart';
import 'package:proyecto/screens/cliente/pages/drawer/cuenta/cuenta_page.dart';
import '../screens/login_screen.dart';
import '../screens/registro_screen.dart';
import '../screens/admin/home_screen.dart';
import '../screens/cliente/pages/drawer/subscripcion/contratar.dart';
import '../screens/cliente/pages/drawer/subscripcion/carrito.dart';

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
  static const String contratar = '/contratar';
  static const String horarios = '/horarios';
  static const String carrito = '/carrito';

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
      personalescliente: (context) => personalesclientePage(),
      metricascliente: (context) => Placeholder(),
      domiciliocliente: (context) => DomicilioPage(),
      subscripcioncliente: (context) => SubscripcionPage(),
      placeholder: (context) => Placeholder(),
      contratar: (context) => ContratarPage(),
      horarios: (context) => HorariosPage(),
      carrito: (context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

  final horarios = args?['horarios'] as List<String>? ?? [];
  final paquete = args?['paquete'] as Map<String, dynamic>?;

  return CarritoPage(
    horarios: horarios,
    paquete: paquete,
  );
},

    };
  }
}
