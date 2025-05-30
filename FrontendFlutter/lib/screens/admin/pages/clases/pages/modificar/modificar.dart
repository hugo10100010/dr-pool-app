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
                value: u.id,
                label: "${u.personales?.nombre} ${u.personales?.apellidop}",
              ),
            )
            .toList();

        final opcionesCasillas = casillasList
            .map<DropdownOption>(
              (c) => DropdownOption(
                value: c.id,
                label: "${c.horaini} ${c.dia == 1 ? "Lunes" : c.dia == 2 ? "Martes" : c.dia == 3 ? "Miercoles" : c.dia == 4 ? "Jueves" : c.dia == 5 ? "Viernes" : c.dia == 6 ? "Sabado" : c.dia == 7 ? "Domingo" : "NO"}",
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
              controller: TextEditingController(text: clase.idcoach.toString()),
              onSubmit: (val) {
                clase.idcoach = int.parse(val);
                service.modificarClase({
                  "id": clase.id,
                  "idcasilla": clase.idcasilla,
                  "idcurso": clase.idcurso,
                  "idcoach": int.parse(val),
                  "coach": {
                    "personales": usuariosList.where((e) => e.id==int.parse(val)).toList()[0].personales?.toJson(),
                  },
                  "casillahorario": clase.casilla.toJson(),
                  "curso": clase.curso.toJson(),
                });
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCoach,
            ),
            GenericEditableField<dynamic>(
              controller:
                  TextEditingController(text: clase.idcasilla.toString()),
              onSubmit: (val) {
                clase.idcasilla = int.parse(val);
                service.modificarClase({
                  "id": clase.id,
                  "idcasilla": int.parse(val),
                  "idcurso": clase.idcurso,
                  "idcoach": clase.idcoach,
                  "coach": {
                    "personales": clase.coach.toJson(),
                  },
                  "casillahorario": casillasList.where((e) => e.id==int.parse(val)).toList()[0].toJson(),
                  "curso": clase.curso.toJson(),
                });
              },
              type: EditableFieldType.dropdown,
              dropdownItems: opcionesCasillas,
            ),
            GenericEditableField(
              controller: TextEditingController(text: clase.idcurso.toString()),
              onSubmit: (val) {
                clase.idcurso = int.parse(val);
                service.modificarClase({
                  "id": clase.id,
                  "idcasilla": clase.idcasilla,
                  "idcurso": int.parse(val),
                  "idcoach": clase.idcoach,
                  "coach": {
                    "personales": clase.coach.toJson(),
                  },
                  "casillahorario": clase.casilla.toJson(),
                  "curso": cursosList.where((e) => e.id==int.parse(val)).toList()[0].toJson(),
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
