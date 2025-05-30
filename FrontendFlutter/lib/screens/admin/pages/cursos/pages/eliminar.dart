import 'package:flutter/material.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/screens/admin/pages/generic/eliminar_form.dart';
import 'package:proyecto/services/curso_service.dart';

class Eliminar extends StatelessWidget {
  final service = CursoServicio();

  @override
  Widget build(BuildContext context) {
    return GenericEliminar<Curso>(
      futureItems: service.getCursos(),
      columnTitles: [
        'Curso',
        'Descripcion',
      ],
      displayValues: (curso) => [
        curso.curso ?? '',
        curso.descripcion ?? '',
      ],
      getDeleteLabel: (curso) => curso.id.toString(),
      onDelete: (curso) => service.eliminarCurso(curso.id),
    );
  }
}
