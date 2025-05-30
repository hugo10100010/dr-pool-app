import 'package:flutter/material.dart';
import 'package:proyecto/screens/admin/pages/generic/eliminar_form.dart';
import 'package:proyecto/services/usuario_service.dart';
import 'package:proyecto/models/usuario_model.dart';

class Eliminar extends StatelessWidget {
  final service = UsuarioService();

  @override
  Widget build(BuildContext context) {
    return GenericEliminar<Usuario>(
      futureItems: service.getUsuarios(),
      columnTitles: [
        'Nombre',
        'Apellido P.',
        'Apellido M.',
        'Email',
        'Teléfono',
        'Tipo doc.',
        'Documento'
      ],
      displayValues: (usuario) => [
        usuario.personales?.nombre ?? '',
        usuario.personales?.apellidop ?? '',
        usuario.personales?.apellidom ?? '',
        usuario.personales?.email ?? '',
        usuario.personales?.telefono ?? '',
        usuario.personales?.tipodocumento ?? '',
        usuario.personales?.documento ?? '',
      ],
      getDeleteLabel: (usuario) => usuario.personales!.nombre,
      onDelete: (usuario) => service.eliminarUsuario(usuario.id),
    );
  }
}
