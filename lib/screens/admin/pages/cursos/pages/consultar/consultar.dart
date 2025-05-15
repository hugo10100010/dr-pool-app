import 'package:flutter/material.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/screens/admin/pages/generic/consultar/consultar_form.dart';
import 'package:proyecto/services/curso_service.dart';

class Consultar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericConsultar<Curso>(
      futureItems: CursoServicio().getCursos(),
      buildColumns: () => const [
        DataColumn(label: Text('Curso')),
        DataColumn(label: Text('Descripcion')),
      ],
      buildRow: (curso) => DataRow(cells: [
        DataCell(Text(curso.curso ?? '')),
        DataCell(Text(curso.descripcion ?? '')),
      ]),
      onRowTap: (curso) {},
    );
  }
}
