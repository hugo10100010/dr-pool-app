import 'package:flutter/material.dart';
import 'package:proyecto/screens/admin/pages/generic/consultar/consultar_form.dart';
import 'package:proyecto/services/usuario_service.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/routes/app_routes.dart';

class Consultar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericConsultar<Usuario>(
      futureItems: UsuarioService().getUsuarios(),
      buildColumns: () => const [
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Apellido P.')),
        DataColumn(label: Text('Apellido M.')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Telefono')),
        DataColumn(label: Text('Tipo doc.')),
        DataColumn(label: Text('Documento')),
      ],
      buildRow: (usuario) => DataRow(cells: [
        DataCell(Text(usuario.personales.nombre ?? '')),
        DataCell(Text(usuario.personales.apellidop ?? '')),
        DataCell(Text(usuario.personales.apellidom ?? '')),
        DataCell(Text(usuario.personales.email ?? '')),
        DataCell(Text(usuario.personales.telefono ?? '')),
        DataCell(Text(usuario.personales.tipodocumento ?? '')),
        DataCell(Text(usuario.personales.documento ?? '')),
      ]),
      onRowTap: (usuario) {
        Navigator.pushNamed(context, AppRoutes.detallesusuario, arguments: {'usuario': usuario});
      },
    );
  }
}
