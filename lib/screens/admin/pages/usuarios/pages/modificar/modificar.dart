import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/usuario_service.dart';

class Modificar extends StatelessWidget {
  final service = UsuarioService();

  @override
  Widget build(BuildContext context) {
    return GenericModificar<Usuario>(
      futureItems: service.getUsuarios(),
      columnTitles: [
        'Nombre',
        'Apellido P.',
        'Apellido M.',
        'Email',
        'Telefono',
        'Tipo doc.',
        'Documento',
      ],
      buildEditableFields: (usuario) => [
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.nombre),
          onSubmit: (val) {
            usuario.personales.nombre = val;
            service.modificarUsuario(usuario.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.apellidop),
          onSubmit: (val) {
            usuario.personales.apellidop = val;
            service.modificarUsuario(usuario.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.apellidom),
          onSubmit: (val) {
            usuario.personales.apellidom = val;
            service.modificarUsuario(usuario.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.email),
          onSubmit: (val) {
            usuario.personales.email = val;
            service.modificarUsuario(usuario.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.telefono),
          onSubmit: (val) {
            usuario.personales.telefono = val;
            service.modificarUsuario(usuario.toJson());
          },
          type: EditableFieldType.int
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.tipodocumento),
          onSubmit: (val) {
            usuario.personales.tipodocumento = val;
            service.modificarUsuario(usuario.toJson());
          },
          type: EditableFieldType.dropdown,
          dropdownItems: [
            DropdownOption(value: "CURP", label: "CURP"),
            DropdownOption(value: "RFC", label: "RFC"),
          ]
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.documento),
          onSubmit: (val) {
            usuario.personales.documento = val;
            service.modificarUsuario(usuario.toJson());
          },
        ),
      ],
      onRowTap: (usuario) {
        Navigator.pushNamed(context, AppRoutes.detallesusuariomodif, arguments: {'usuario': usuario});
      },
    );
  }
}
