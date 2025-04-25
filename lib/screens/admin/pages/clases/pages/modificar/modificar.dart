import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';
import 'package:proyecto/services/clase_servicio.dart';
import 'package:proyecto/services/usuario_service.dart';

class Modificar extends StatelessWidget {
  final service = ClaseServicio();
  final Future<List<Usuario>> usuarios = UsuarioService().getUsuarios();
  final Future<List<CasillaHorario>> casillas =
      CasillahorarioService().getCasillas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([usuarios, casillas]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        final usuariosList = snapshot.data![0] as List<Usuario>;
        final casillasList = snapshot.data![1] as List<CasillaHorario>;

        final opcionesCoach = usuariosList
            .where((u) => u.tipousuario == 3)
            .map<DropdownOption>(
              (u) => DropdownOption(
                value: u.id, // ✅ integer id
                label: "${u.personales.nombre} ${u.personales.apellidop}",
              ),
            )
            .toList();

        final opcionesCasillas = casillasList
            .map<DropdownOption>(
              (c) => DropdownOption(
                value: c.id, // ✅ integer id
                label: "${c.horaini} ${c.dia}",
              ),
            )
            .toList();

        return GenericModificar<Clase>(
          futureItems: service.getClases(),
          columnTitles: ['Coach', 'Casilla', 'Descripcion'],
          buildEditableFields: (clase) => [
            GenericEditableField<dynamic>(
              controller: TextEditingController(text: clase.idcoach.toString()),
              onSubmit: (val) {
                clase.idcoach = int.parse(val);
                service.modificarClase(clase.toJson());
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCoach,
            ),
            GenericEditableField<dynamic>(
              controller:
                  TextEditingController(text: clase.idcasilla.toString()),
              onSubmit: (val) {
                clase.idcasilla = int.parse(val);
                service.modificarClase(clase.toJson());
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCasillas,
            ),
            GenericEditableField(
              controller: TextEditingController(text: clase.descripcion),
              onSubmit: (val) {
                clase.descripcion = val;
                service.modificarClase(clase.toJson());
              },
            ),
          ],
          onRowTap: (clase) {},
        );
      },
    );
  }
}
