import 'package:flutter/material.dart';

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
  String? selectTipoCurso;
  String? selectCronograma;

  final List<String> tiposCursos = ['Presencial', 'En línea', 'Híbrido'];
  final List<String> opcionesCronograma = ['Mañana', 'Tarde', 'Noche'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipo de Curso', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: selectTipoCurso,
          hint: Text('Seleccione el tipo de curso', style: TextStyle(color: Colors.red)),
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          iconEnabledColor: Colors.red,
          items: tiposCursos.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type, style: TextStyle(color: Colors.red)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => selectTipoCurso = value);
          },
        ),
        SizedBox(height: 16),
        Text('Casilla de Horario', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: selectCronograma,
          hint: Text('Seleccione el horario', style: TextStyle(color: Colors.red)),
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          iconEnabledColor: Colors.red,
          items: opcionesCronograma.map((cronograma) {
            return DropdownMenuItem(
              value: cronograma,
              child: Text(cronograma, style: TextStyle(color: Colors.red)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => selectCronograma = value);
          },
        ),
      ],
    );
  }
}
