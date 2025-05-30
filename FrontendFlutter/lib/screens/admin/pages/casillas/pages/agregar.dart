import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/screens/admin/pages/generic/agregar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';

class Agregar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericAgregarForm(
      pages: [
        [
          FieldConfig(label: "Hora inicio", key: "horaini", type: FieldType.dropdown,dropdownItems: [
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
          ]),
          FieldConfig(label: "Hora fin", key: "horafin", type: FieldType.dropdown,dropdownItems: [
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
          ]),
          FieldConfig(label: "Dia", key: "dia", type: FieldType.dropdown, dropdownItems: [
            DropdownOption(value: 1, label: "Lunes"),
            DropdownOption(value: 2, label: "Martes"),
            DropdownOption(value: 3, label: "Miercoles"),
            DropdownOption(value: 4, label: "Jueves"),
            DropdownOption(value: 5, label: "Viernes"),
            DropdownOption(value: 6, label: "Sábado"),
            DropdownOption(value: 7, label: "Domingo"),
          ]),
        ],
      ],
      onSubmit: (data) async {
        final payload = {
          "horaini": data['horaini'],
          "horafin": data['horafin'],
          "dia": int.parse(data['dia']),
        };
        final success = await CasillahorarioService().agregarCasilla(payload);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(success ? 'Casilla agregada' : 'Error al agregar')),
          );
        }
      },
    );
  }
}
