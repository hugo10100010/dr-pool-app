import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/helpers/isonline_func.dart';
import 'package:proyecto/helpers/session_manager.dart';
import 'package:proyecto/helpers/sync_funcs.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/services/connectivity_service.dart';
import '../services/usuario_service.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final service = UsuarioService();
  late Future<List<dynamic>> futureUsuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Ingrese para continuar",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Container(
                width: 225,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(45.0),
                ),
                padding: EdgeInsets.fromLTRB(20, 50, 20, 80),
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  spacing: 20,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UI(),
                            ));*/
                        var result = await service.login({
                          "username": _usernameController.text,
                          "password": _passwordController.text
                        });
                        if (result["success"]) {
                          Provider.of<UsuarioProvider>(context, listen: false)
                              .setUsuario(result['usuario']);

                          await SessionManager().loadToken();

                          final token = await FlutterSecureStorage()
                              .read(key: 'proyectom_access_token');
                          if (token != null) {
                            Map<String, dynamic> decodedToken =
                                JwtDecoder.decode(token);
                            int rol = decodedToken['rol'];
                            if (rol == 1) {
                              Navigator.pushNamed(context, AppRoutes.adminhome);
                            } else if (rol == 2) {
                              Navigator.pushNamed(
                                  context, AppRoutes.clientehome);
                            } else if (rol == 3) {
                              Navigator.pushNamed(context, AppRoutes.couchhome);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Rol no reconocido")));
                            }
                          } else {
                            print("No token");
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login no válido")));
                        }
                      },
                      child: Text('Ingresar'),
                    ),
                    Column(
                      spacing: 2.0,
                      children: [
                        Text(
                          "¿Tiene una cuenta?",
                        ),
                        GestureDetector(
                          onTap: () async {
                            final resultado = await Navigator.pushNamed(
                                context, '/registrar');
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$resultado')));
                          },
                          child: Text(
                            "Registrarse",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
