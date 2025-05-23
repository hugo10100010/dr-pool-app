import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/paquete_service.dart';

class Modificar extends StatelessWidget {
  final service = PaqueteService();

  @override
  Widget build(BuildContext context) {
    return GenericModificar<Paquete>(
      futureItems: service.getPaquetes(),
      columnTitles: [
        'Precio',
        'Clases',
        'Flexible',
      ],
      buildEditableFields: (paquete) => [
        GenericEditableField(
          controller: TextEditingController(text: paquete.precio.toString()),
          onSubmit: (val) {
            paquete.precio = double.parse(val);
            service.modificarPaquete({
              "precio": val,
            });
          },
          type: EditableFieldType.double,
        ),
        GenericEditableField(
          controller: TextEditingController(text: paquete.clases.toString()),
          onSubmit: (val) {
            paquete.clases = int.parse(val);
            service.modificarPaquete({
              "clases": int.parse(val),
            });
          },
        ),
        GenericEditableField(
            controller:
                TextEditingController(text: paquete.flexible ? 'Si' : 'No'),
            onSubmit: (val) {
              paquete.flexible = bool.parse(val);
              service.modificarPaquete({
                "flexible": bool.parse(val),
              });
            },
            type: EditableFieldType.dropdown,
            dropdownItems: [
              DropdownOption(value: false, label: "No"),
              DropdownOption(value: true, label: "Si"),
            ]),
      ],
      onRowTap: (paquete) {},
    );
  }
}
