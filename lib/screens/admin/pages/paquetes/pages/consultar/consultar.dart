import 'package:flutter/material.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/screens/admin/pages/generic/consultar/consultar_form.dart';
import 'package:proyecto/services/paquete_service.dart';

class Consultar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericConsultar<Paquete>(
      futureItems: PaqueteService().getPaquetes(),
      buildColumns: () => const [
        DataColumn(label: Text('Precio')),
        DataColumn(label: Text('Clases')),
        DataColumn(label: Text('Flexible')),
      ],
      buildRow: (paquete) => DataRow(cells: [
        DataCell(Text(paquete.precio.toString() ?? '')),
        DataCell(Text(paquete.clases.toString() ?? '')),
        DataCell(Text(paquete.flexible.toString() ?? '')),
      ]),
      onRowTap: (paquete) {
        
      },
    );
  }
}
