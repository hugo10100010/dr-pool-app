import 'package:flutter/material.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/curso_service.dart';

class Modificar extends StatelessWidget {
  final service = CursoServicio();

  @override
  Widget build(BuildContext context) {
    return GenericModificar<Curso>(
      futureItems: service.getCursos(),
      columnTitles: ['Curso', 'Descripcion'],
      buildEditableFields: (curso) => [
        GenericEditableField<dynamic>(
          controller: TextEditingController(text: curso.curso),
          onSubmit: (val) {
            curso.curso = val;
            service.modificarCurso({
              "curso": val,
            });
          },
          type: EditableFieldType.text,
        ),
        GenericEditableField<dynamic>(
          controller: TextEditingController(text: curso.descripcion),
          onSubmit: (val) {
            curso.descripcion = val;
            service.modificarCurso({
              "descripcion": val,
            });
          },
          type: EditableFieldType.text,
        ),
      ],
      onRowTap: (curso) {},
    );
  }
}
