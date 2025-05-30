import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/screens/admin/pages/generic/agregar_form.dart';
import 'package:proyecto/services/curso_service.dart';

class Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericAgregarForm(
      pages: [
        [
          FieldConfig(
            label: "Curso",
            key: "curso",
            type: FieldType.text,
          ),
          FieldConfig(
            label: "Descripcion",
            key: "descripcion",
            type: FieldType.text,
          ),
        ],
      ],
      onSubmit: (data) async {
        final payload = {
          "curso": data['curso'],
          "descripcion": data['descripcion'],
        };
        final success = await CursoServicio().agregarCurso(payload);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(success ? 'Curso agregado' : 'Error al agregar curso'),
            ),
          );
        }
      },
    );
  }
}
