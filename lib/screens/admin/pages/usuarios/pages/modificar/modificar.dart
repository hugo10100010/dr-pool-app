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
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "nombre": val
              }
            });
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.apellidop),
          onSubmit: (val) {
            usuario.personales.apellidop = val;
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "apellidop": val
              }
            });
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.apellidom),
          onSubmit: (val) {
            usuario.personales.apellidom = val;
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "apellidom": val
              }
            });
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.email),
          onSubmit: (val) {
            usuario.personales.email = val;
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "email": val
              }
            });
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.telefono),
          onSubmit: (val) {
            usuario.personales.telefono = val;
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "telefono": val
              }
            });
          },
          type: EditableFieldType.int
        ),
        GenericEditableField(
          controller: TextEditingController(text: usuario.personales.tipodocumento),
          onSubmit: (val) {
            usuario.personales.tipodocumento = val;
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "tipodocumento": val
              }
            });
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
            service.modificarUsuario({
              "id": usuario.id,
              "personales": {
                "documento": val
              }
            });
          },
        ),
      ],
      onRowTap: (usuario) {
        Navigator.pushNamed(context, AppRoutes.detallesusuariomodif, arguments: {'usuario': usuario});
      },
    );
  }
}
