import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/screens/admin/pages/generic/agregar_form.dart';
import 'package:proyecto/services/paquete_service.dart';

class Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericAgregarForm(
      pages: [
        [
          FieldConfig(label: "Precio", key: "precio", type: FieldType.double, inputType: TextInputType.numberWithOptions(decimal: true)),
          FieldConfig(label: "Beneficios", key: "beneficios", inputType: TextInputType.multiline),
        ],
      ],
      onSubmit: (data) async {
        final payload = {
          "precio": double.parse(data['precio']),
          "beneficios": data['beneficios']
        };
        final success = await PaqueteService().agregarPaquete(payload); 
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(success ? 'Paquete agregado' : 'Error al agregar')),
          );
        }
      },
    );
  }
}
