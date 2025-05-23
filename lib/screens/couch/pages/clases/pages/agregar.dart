import 'package:flutter/material.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/services/casillahorario_service.dart';
import 'package:proyecto/services/curso_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.red[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[900],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Agregar Curso')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SeleccionarCursoWidget(),
        ),
      ),
    );
  }
}

class SeleccionarCursoWidget extends StatefulWidget {
  @override
  _SeleccionarCursoWidgetState createState() => _SeleccionarCursoWidgetState();
}

class _SeleccionarCursoWidgetState extends State<SeleccionarCursoWidget> {
  int? selectCurso;
  int? selectCasilla;

  final Future<List<Curso>> cursos = CursoServicio().getCursos();
  final Future<List<CasillaHorario>> casillas =
      CasillahorarioService().getCasillas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([cursos, casillas]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final cursosList = snapshot.data![0] as List<Curso>;
        final casillasList = snapshot.data![1] as List<CasillaHorario>;

        final cursosItems = cursosList
            .map<DropdownMenuItem>(
              (c) => DropdownMenuItem(
                value: c.id.toString(),
                child: Text(c.curso),
              ),
            )
            .toList();
        final casillasItems = casillasList
            .map<DropdownMenuItem>(
              (e) => DropdownMenuItem(
                  value: e.id.toString(),
                  child: Text(
                      "${e.dia == 1 ? "Lunes" : e.dia == 2 ? "Martes" : e.dia == 3 ? "Miercoles" : e.dia == 4 ? "Jueves" : e.dia == 5 ? "Viernes" : e.dia == 6 ? "Sábado" : e.dia == 7 ? "Domingo" : "No"} - ${e.horaini} a ${e.horafin}")),
            )
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Curso',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            DropdownButton(
              value: selectCurso,
              hint: Text('Seleccione el tipo de curso',
                  style: TextStyle(color: Colors.red)),
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              iconEnabledColor: Colors.red,
              items: cursosItems,
              onChanged: (value) {
                setState(() => selectCurso = value);
              },
            ),
            SizedBox(height: 16),
            Text('Casilla de Horario',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            DropdownButton(
              value: selectCasilla,
              hint: Text('Seleccione el horario',
                  style: TextStyle(color: Colors.red)),
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              iconEnabledColor: Colors.red,
              items: casillasItems,
              onChanged: (value) {
                setState(() => selectCasilla = value);
              },
            ),
          ],
        );
      },
    );
  }
}
