import 'package:flutter/material.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/screens/admin/pages/generic/eliminar_form.dart';
import 'package:proyecto/services/paquete_service.dart';

class Eliminar extends StatelessWidget {
  final service = PaqueteService();

  @override
  Widget build(BuildContext context) {
    return GenericEliminar<Paquete>(
      futureItems: service.getPaquetes(),
      columnTitles: [
        'Precio',
        'Beneficios',
      ],
      displayValues: (paquete) => [
        paquete.precio.toString() ?? '',
        paquete.beneficios ?? '',
      ],
      getDeleteLabel: (paquete) => paquete.id.toString(),
      onDelete: (paquete) => service.eliminarPaquete(paquete.id),
    );
  }
}
