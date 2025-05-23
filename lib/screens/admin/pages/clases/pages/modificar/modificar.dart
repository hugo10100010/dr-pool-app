import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/modificar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';
import 'package:proyecto/services/clase_servicio.dart';
import 'package:proyecto/services/curso_service.dart';
import 'package:proyecto/services/usuario_service.dart';

class Modificar extends StatelessWidget {
  final service = ClaseServicio();
  final Future<List<Usuario>> usuarios = UsuarioService().getUsuarios();
  final Future<List<CasillaHorario>> casillas =
      CasillahorarioService().getCasillas();
  final Future<List<Curso>> cursos = CursoServicio().getCursos();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([usuarios, casillas, cursos]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        final usuariosList = snapshot.data![0] as List<Usuario>;
        final casillasList = snapshot.data![1] as List<CasillaHorario>;
        final cursosList = snapshot.data![2] as List<Curso>;

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

        final opcionesCursos = cursosList
            .map<DropdownOption>(
              (e) => DropdownOption(value: e.id, label: e.curso),
            )
            .toList();

        return GenericModificar<Clase>(
          futureItems: service.getClases(),
          columnTitles: ['Coach', 'Casilla', 'Curso'],
          buildEditableFields: (clase) => [
            GenericEditableField<dynamic>(
              controller: TextEditingController(text: "${clase.coach.nombre} ${clase.coach.apellidop}"),
              onSubmit: (val) {
                clase.idcoach = int.parse(val);
                service.modificarClase({
                  "coach": int.parse(val),
                });
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCoach,
            ),
            GenericEditableField<dynamic>(
              controller:
                  TextEditingController(text: "${clase.casilla.dia} ${clase.casilla.horaini} ${clase.casilla.horafin}"),
              onSubmit: (val) {
                clase.idcasilla = int.parse(val);
                service.modificarClase({
                  "idcasilla": int.parse(val),
                });
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCasillas,
            ),
            GenericEditableField(
              controller: TextEditingController(text: clase.curso.curso),
              onSubmit: (val) {
                clase.idcurso = int.parse(val);
                service.modificarClase({
                  "curso": int.parse(val),
                });
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCursos,
            ),
          ],
          onRowTap: (clase) {},
        );
      },
    );
  }
}
