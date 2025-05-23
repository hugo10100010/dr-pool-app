import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/models/field_config_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/agregar_form.dart';
import 'package:proyecto/services/casillahorario_service.dart';
import 'package:proyecto/services/clase_servicio.dart';
import 'package:proyecto/services/curso_service.dart';
import 'package:proyecto/services/usuario_service.dart';

class Agregar extends StatelessWidget {
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
        
        final coachOptions = usuariosList
            .where((u) => u.tipousuario == 3)
            .map<DropdownOption<int>>((u) => DropdownOption<int>(
                  value: u.id,
                  label: "${u.personales.nombre} ${u.personales.apellidop}",
                ))
            .toList();

        final casillaOptions = casillasList
            .map<DropdownOption<int>>((c) => DropdownOption<int>(
                  value: c.id,
                  label: "${c.dia} - ${c.horaini}",
                ))
            .toList();

        final cursosOptions = cursosList
            .map<DropdownOption<int>>(
                (c) => DropdownOption<int>(value: c.id, label: c.curso))
            .toList();

        return GenericAgregarForm(
          pages: [
            [
              FieldConfig(
                label: "Coach",
                key: "idcoach",
                type: FieldType.dropdown,
                dropdownItems: coachOptions,
              ),
              FieldConfig(
                label: "Casilla",
                key: "idcasilla",
                type: FieldType.dropdown,
                dropdownItems: casillaOptions,
              ),
              FieldConfig(
                label: "Curso",
                key: "idcurso",
                type: FieldType.dropdown,
                dropdownItems: cursosOptions,
              ),
            ],
          ],
          onSubmit: (data) async {
            final payload = {
              "idcoach": int.parse(data['idcoach']),
              "idcasilla": int.parse(data['idcasilla']),
              "idcurso": int.parse(data['idcurso']),
            };
            final success = await ClaseServicio().agregarClase(payload);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      success ? 'Clase agregada' : 'Error al agregar clase'),
                ),
              );
            }
          },
        );
      },
    );
  }
}
