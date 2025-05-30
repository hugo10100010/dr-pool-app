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
          FieldConfig(label: "Clases", key: "clases", type: FieldType.int),
          FieldConfig(label: "Flexible", key: "flexible", type: FieldType.dropdown, dropdownItems: [
            DropdownOption(value: false, label: "No"),
            DropdownOption(value: true, label: "Si")
          ])
        ],
      ],
      onSubmit: (data) async {
        final payload = {
          "precio": double.parse(data['precio']),
          "clases": data['clases'],
          "flexible": data['flexible']
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
