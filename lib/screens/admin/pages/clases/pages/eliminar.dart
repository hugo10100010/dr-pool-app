import 'package:flutter/material.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/screens/admin/pages/generic/eliminar_form.dart';
import 'package:proyecto/services/clase_servicio.dart';

class Eliminar extends StatelessWidget {
  final service = ClaseServicio();

  @override
  Widget build(BuildContext context) {
    return GenericEliminar<Clase>(
      futureItems: service.getClases(),
      columnTitles: [
        'Coach',
        'Casilla',
        'Descripcion',
      ],
      displayValues: (clase) => [
        "${clase.coach.nombre} + ${clase.coach.apellidop}" ?? '',
        "${clase.casilla.dia} ${clase.casilla.horaini} ${clase.casilla.horafin}" ?? '',
        "${clase.curso.curso}" ?? '',
      ],
      getDeleteLabel: (clase) => clase.id.toString(),
      onDelete: (clase) => service.eliminarClase(clase.id),
    );
  }
}
