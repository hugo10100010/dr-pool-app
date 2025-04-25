import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';

class Modificar extends StatelessWidget {
  final service = CasillahorarioService();

  @override
  Widget build(BuildContext context) {
    return GenericModificar<CasillaHorario>(
      futureItems: service.getCasillas(),
      columnTitles: [
        'Hora inicio',
        'Hora fin',
        'Dia'
      ],
      buildEditableFields: (casilla) => [
        GenericEditableField(
          controller: TextEditingController(text: casilla.horaini),
          onSubmit: (val) {
            casilla.horaini = val;
            service.modificarCasilla(casilla.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: casilla.horafin),
          onSubmit: (val) {
            casilla.horafin = val;
            service.modificarCasilla(casilla.toJson());
          },
        ),
        GenericEditableField(
          controller: TextEditingController(text: casilla.dia.toString()),
          onSubmit: (val) {
            casilla.dia = int.parse(val);
            service.modificarCasilla(casilla.toJson());
          },
        ),
      ],
      onRowTap: (casilla) {
        
      },
    );
  }
}
