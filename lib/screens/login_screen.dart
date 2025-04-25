import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import '../services/usuario_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

Future<List<dynamic>> fetchUsuarios() async {
  final response = await http.get(Uri.parse("http://127.0.0.1:5000/usuario/"));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load usuario');
  }
}

class _LoginState extends State<Login> {
  final service = UsuarioService();
  late Future<List<dynamic>> futureUsuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUsuario = fetchUsuarios();
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
                          Provider.of<UsuarioProvider>(context,listen: false).setUsuario(result['usuario']);
                          if (result['rol'] == 1) {
                            Navigator.pushNamed(context, '/adminhome');
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login no válido")));
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
                        Container(
                          height: 100,
                          child: FutureBuilder<List<dynamic>>(
                            future: futureUsuario,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          snapshot.data![index]["nombre"],
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
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
