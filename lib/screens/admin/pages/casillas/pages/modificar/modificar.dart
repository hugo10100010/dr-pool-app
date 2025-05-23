import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';

class Modificar extends StatelessWidget {
  final service = CasillahorarioService();

  @override
  Widget build(BuildContext context) {
    return GenericModificar<CasillaHorario>(
      futureItems: service.getCasillas(),
      columnTitles: ['Hora inicio', 'Hora fin', 'Dia'],
      buildEditableFields: (casilla) => [
        GenericEditableField(
          controller: TextEditingController(text: casilla.horaini),
          onSubmit: (val) {
            casilla.horaini = val;
            service.modificarCasilla({
              "horaini": val,
            });
          },
          type: EditableFieldType.dropdown,
          dropdownItems: [
            DropdownOption(value: "8:00", label: "8:00"),
            DropdownOption(value: "9:00", label: "9:00"),
            DropdownOption(value: "10:00", label: "10:00"),
            DropdownOption(value: "11:00", label: "11:00"),
            DropdownOption(value: "12:00", label: "12:00"),
            DropdownOption(value: "13:00", label: "13:00"),
            DropdownOption(value: "14:00", label: "14:00"),
            DropdownOption(value: "15:00", label: "15:00"),
            DropdownOption(value: "16:00", label: "16:00"),
            DropdownOption(value: "17:00", label: "17:00"),
            DropdownOption(value: "18:00", label: "18:00"),
            DropdownOption(value: "19:00", label: "19:00"),
          ],
        ),
        GenericEditableField(
          controller: TextEditingController(text: casilla.horafin),
          onSubmit: (val) {
            casilla.horafin = val;
            service.modificarCasilla({
              "horafin": val,
            });
          },
          type: EditableFieldType.dropdown,
          dropdownItems: [
            DropdownOption(value: "9:00", label: "9:00"),
            DropdownOption(value: "10:00", label: "10:00"),
            DropdownOption(value: "11:00", label: "11:00"),
            DropdownOption(value: "12:00", label: "12:00"),
            DropdownOption(value: "13:00", label: "13:00"),
            DropdownOption(value: "14:00", label: "14:00"),
            DropdownOption(value: "15:00", label: "15:00"),
            DropdownOption(value: "16:00", label: "16:00"),
            DropdownOption(value: "17:00", label: "17:00"),
            DropdownOption(value: "18:00", label: "18:00"),
            DropdownOption(value: "19:00", label: "19:00"),
            DropdownOption(value: "20:00", label: "20:00"),
          ],
        ),
        GenericEditableField(
          controller: TextEditingController(text: casilla.dia.toString()),
          onSubmit: (val) {
            casilla.dia = int.parse(val);
            service.modificarCasilla({
              "dia": int.parse(val)
            });
          },
          type: EditableFieldType.dropdown,
          dropdownItems: [
            DropdownOption(value: 1, label: "Lunes"),
            DropdownOption(value: 2, label: "Martes"),
            DropdownOption(value: 3, label: "Miercoles"),
            DropdownOption(value: 4, label: "Jueves"),
            DropdownOption(value: 5, label: "Viernes"),
            DropdownOption(value: 6, label: "Sábado"),
            DropdownOption(value: 7, label: "Domingo"),
          ],
        ),
      ],
      onRowTap: (casilla) {},
    );
  }
}
