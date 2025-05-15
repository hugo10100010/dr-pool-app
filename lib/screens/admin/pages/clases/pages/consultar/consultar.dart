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
        DataCell(Text("${clase.coach.nombre} ${clase.coach.apellidop}" ?? '')),
        DataCell(Text("${clase.casilla.dia} ${clase.casilla.horaini} ${clase.casilla.horafin}" ?? '')),
        DataCell(Text(clase.curso.curso ?? '')),
      ]),
      onRowTap: (paquete) {
        
      },
    );
  }
}
