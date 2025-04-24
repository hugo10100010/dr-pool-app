import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/eliminar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';

class Eliminar extends StatelessWidget {
  final service = CasillahorarioService();

  @override
  Widget build(BuildContext context) {
    return GenericEliminar<CasillaHorario>(
      futureItems: service.getCasillas(),
      columnTitles: [
        'Hora inicio',
        'Hora fin',
        'Dia'
      ],
      displayValues: (casilla) => [
        casilla.horaini ?? '',
        casilla.horafin ?? '',
        casilla.dia.toString() ?? '',
      ],
      getDeleteLabel: (casilla) => casilla.id.toString(),
      onDelete: (casilla) => service.eliminarCasilla(casilla.id),
    );
  }
}
