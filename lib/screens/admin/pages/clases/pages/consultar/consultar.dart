import 'package:flutter/material.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/screens/admin/pages/generic/consultar/consultar_form.dart';
import 'package:proyecto/services/clase_servicio.dart';

class Consultar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericConsultar<Clase>(
      futureItems: ClaseServicio().getClases(),
      buildColumns: () => const [
        DataColumn(label: Text('Coach')),
        DataColumn(label: Text('Casilla')),
        DataColumn(label: Text('Descripcion')),
      ],
      buildRow: (clase) => DataRow(cells: [
        DataCell(Text(clase.idcoach.toString() ?? '')),
        DataCell(Text(clase.idcasilla.toString() ?? '')),
        DataCell(Text(clase.descripcion ?? '')),
      ]),
      onRowTap: (paquete) {
        
      },
    );
  }
}
