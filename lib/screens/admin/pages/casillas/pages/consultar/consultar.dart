import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/consultar/consultar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';

class Consultar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericConsultar<CasillaHorario>(
      futureItems: CasillahorarioService().getCasillas(),
      buildColumns: () => const [
        DataColumn(label: Text('Hora inicio')),
        DataColumn(label: Text('Hora fin')),
        DataColumn(label: Text('Dia')),
      ],
      buildRow: (casilla) => DataRow(cells: [
        DataCell(Text(casilla.horaini ?? '')),
        DataCell(Text(casilla.horafin ?? '')),
        DataCell(Text(casilla.dia.toString() ?? '')),
      ]),
      onRowTap: (casilla) {
        
      },
    );
  }
}
