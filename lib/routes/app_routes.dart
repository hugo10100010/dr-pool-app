import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/registro_screen.dart';
import '../screens/admin/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String registrar = '/registrar';
  static const String home = '/home';
  static const String adminhome = '/adminhome';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => Placeholder(),
        );
      case registrar:
        return MaterialPageRoute(
          builder: (_) => Placeholder(),
        );
      case adminhome:
        return MaterialPageRoute(builder: (_) => AdminHomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
