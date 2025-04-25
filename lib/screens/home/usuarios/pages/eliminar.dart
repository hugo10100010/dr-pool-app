import 'package:flutter/material.dart';
import 'package:proyecto/services/usuario_service.dart';
import '../../../../../../../models/usuario_model.dart'; // Asegúrate de importar tu modelo

class Eliminar extends StatefulWidget {
  @override
  State<Eliminar> createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
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
              return DataRow(
                cells: [
                  DataCell(Text(usuario.personales.nombre ?? '')),
                  DataCell(Text(usuario.personales.apellidop ?? '')),
                  DataCell(Text(usuario.personales.apellidom ?? '')),
                  DataCell(Text(usuario.personales.email ?? '')),
                  DataCell(Text(usuario.personales.telefono ?? '')),
                  DataCell(Text(usuario.personales.tipodocumento ?? '')),
                  DataCell(Text(usuario.personales.documento ?? '')),
                ],
                onLongPress: () async {
                  final result = await showDialog<Map<String,dynamic>>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Eliminar un usuario."),
                      content: Text(
                          "¿Está seguro de que desea eliminar este usuario?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context,{"action":false}),
                          child: Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final service = UsuarioService();
                            final result = await service.eliminarUsuario(usuario.id);
                            Navigator.pop(context,{"action":true, "message":result});
                          },
                          child: Text("Confirmar"),
                        ),
                      ],
                    ),
                  );
                  if(result!['action']==true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
