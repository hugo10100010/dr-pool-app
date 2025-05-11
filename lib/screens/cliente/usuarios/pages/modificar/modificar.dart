import 'package:flutter/material.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/services/usuario_service.dart';
import '../../../../../../models/usuario_model.dart'; // Asegúrate de importar tu modelo

class Modificar extends StatefulWidget {
  @override
  State<Modificar> createState() => _ModificarState();
}

class _ModificarState extends State<Modificar> {
  late Future<List<Usuario>> usuarios;
  final service = UsuarioService();

  @override
  void initState() {
    super.initState();
    usuarios = service.getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: usuarios,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final usuariosList = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Apellido P.')),
              DataColumn(label: Text('Apellido M.')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Telefono')),
              DataColumn(label: Text('Tipo doc.')),
              DataColumn(label: Text('Documento')),
            ],
            rows: usuariosList.map((usuario) {
              final nombreController =
                  TextEditingController(text: usuario.personales.nombre);
              final apellidopController =
                  TextEditingController(text: usuario.personales.apellidop);
              final apellidomController =
                  TextEditingController(text: usuario.personales.apellidom);
              final emailController =
                  TextEditingController(text: usuario.personales.email);
              final telefonoController =
                  TextEditingController(text: usuario.personales.telefono);
              final tipoDocController =
                  TextEditingController(text: usuario.personales.tipodocumento);
              final documentoController =
                  TextEditingController(text: usuario.personales.documento);

              return DataRow(cells: [
                DataCell(TextField(
                  controller: nombreController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.nombre = value;
                    service.modificarUsuario(usuario.toJson());
                    // Optionally: call update API here
                  },
                )),
                DataCell(TextField(
                  controller: apellidopController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.apellidop = value;
                    service.modificarUsuario(usuario.toJson());
                  },
                )),
                DataCell(TextField(
                  controller: apellidomController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.apellidom = value;
                    service.modificarUsuario(usuario.toJson());
                  },
                )),
                DataCell(TextField(
                  controller: emailController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.email = value;
                    service.modificarUsuario(usuario.toJson());
                  },
                )),
                DataCell(TextField(
                  controller: telefonoController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.telefono = value;
                    service.modificarUsuario(usuario.toJson());
                  },
                )),
                DataCell(TextField(
                  controller: tipoDocController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.tipodocumento = value;
                    service.modificarUsuario(usuario.toJson());
                  },
                )),
                DataCell(TextField(
                  controller: documentoController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    usuario.personales.documento = value;
                    service.modificarUsuario(usuario.toJson());
                  },
                )),
              ],onLongPress: () {
                Navigator.pushNamed(context, AppRoutes.detallesusuariomodif, arguments: {"usuario": usuario});
              },);
            }).toList(),
          ),
        );
      },
    );
  }
}
