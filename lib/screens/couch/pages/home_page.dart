import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';

class CoucheHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    if (usuario == null) {
      return Center(child: Text("Cerrando sesión...")); // or a loading spinner
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Bienvenido, ${usuario.personales.nombre}!")),
      ],
    );
  }
}
