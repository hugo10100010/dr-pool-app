import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/screens/admin/pages/generic/agregar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';

class Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericAgregarForm(
      pages: [
        [
          FieldConfig(label: "Hora inicio", key: "horaini"),
          FieldConfig(label: "Hora fin", key: "horafin"),
          FieldConfig(label: "Dia", key: "dia"),
          
        ],
      ],
      onSubmit: (data) async {
        final payload = {
          "horaini": data['horaini'],
          "horafin": data['horafin'],
          "dia": int.parse(data['dia']),
        };
        final success = await CasillahorarioService().agregarCasilla(payload);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(success ? 'Casilla agregada' : 'Error al agregar')),
          );
        }
      },
    );
  }
}
