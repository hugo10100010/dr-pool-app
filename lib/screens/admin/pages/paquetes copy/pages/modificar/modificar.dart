import 'package:flutter/material.dart';
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
        'Beneficios',
      ],
      buildEditableFields: (paquete) => [
        GenericEditableField(
          controller: TextEditingController(text: paquete.precio.toString()),
          onSubmit: (val) {
            paquete.precio = double.parse(val);
            service.modificarPaquete(paquete.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: paquete.beneficios),
          onSubmit: (val) {
            paquete.beneficios = val;
            service.modificarPaquete(paquete.toJson());
          },
        ),
      ],
      onRowTap: (paquete) {
        
      },
    );
  }
}
