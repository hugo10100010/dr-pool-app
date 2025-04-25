import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/screens/admin/pages/generic/agregar_form.dart';
import 'package:proyecto/services/usuario_service.dart';

class Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericAgregarForm(
      pages: [
        // Personal data
        [
          FieldConfig(label: "Nombre", key: "nombre"),
          FieldConfig(label: "Apellido paterno", key: "apellidop"),
          FieldConfig(label: "Apellido materno", key: "apellidom"),
          FieldConfig(
              label: "Email",
              key: "email",
              inputType: TextInputType.emailAddress),
          FieldConfig(
            label: "Telefono",
            key: "telefono",
            inputType: TextInputType.phone,
            type: FieldType.int,
          ),
          FieldConfig(
              label: "Tipo documento",
              key: "tipodocumento",
              type: FieldType.dropdown,
              dropdownItems: [
                DropdownOption(value: "CURP", label: "CURP"),
                DropdownOption(value: "RFC", label: "RFC"),
              ]),
          FieldConfig(label: "Documento", key: "documento"),
        ],
        // Account data
        [
          FieldConfig(label: "Usuario", key: "nombreusu"),
          FieldConfig(label: "Contraseña", key: "password", obscureText: true),
        ],
        // Address data
        [
          FieldConfig(label: "Calle", key: "calle"),
          FieldConfig(
            label: "Num. ext.",
            key: "numext",
            inputType: TextInputType.number,
            type: FieldType.int,
          ),
          FieldConfig(
            label: "Num. int.",
            key: "numint",
            inputType: TextInputType.number,
            type: FieldType.int,
          ),
          FieldConfig(label: "Asentamiento", key: "asentamiento"),
          FieldConfig(
            label: "Codigo postal",
            key: "codigop",
            inputType: TextInputType.number,
            type: FieldType.int,
          ),
        ],
        // User type
        [
          FieldConfig(
            label: "Tipo de usuario",
            key: "tipousuario",
            inputType: TextInputType.number,
            type: FieldType.dropdown,
            dropdownItems: [
              DropdownOption(value: 1, label: "Admin",),
              DropdownOption(value: 2, label: "Cliente"),
              DropdownOption(value: 3, label: "Coach"),
            ],
          ),
        ]
      ],
      onSubmit: (data) async {
        final payload = {
          "personales": {
            "nombre": data["nombre"],
            "apellidop": data["apellidop"],
            "apellidom": data["apellidom"],
            "email": data["email"],
            "telefono": data["telefono"],
            "tipodocumento": data["tipodocumento"],
            "documento": data["documento"]
          },
          "cuenta": {
            "nombreusu": data["nombreusu"],
            "password": data["password"],
          },
          "domicilio": {
            "calle": data["calle"],
            "numext": int.parse(data["numext"]),
            "numint": int.parse(data["numint"]),
            "asentamiento": data["asentamiento"],
            "codigop": data["codigop"]
          },
          "tipousuario": int.parse(data["tipousuario"])
        };

        final success = await UsuarioService().agregarUsuario(payload);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(success ? 'Usuario agregado' : 'Error al agregar')),
          );
        }
      },
    );
  }
}
