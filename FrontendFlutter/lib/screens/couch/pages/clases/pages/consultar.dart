import 'package:flutter/material.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/services/clase_servicio.dart';
import 'package:proyecto/services/usuario_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DropdownListExample(),
    );
  }
}

class DropdownListExample extends StatefulWidget {
  @override
  _DropdownListExampleState createState() => _DropdownListExampleState();
}

class _DropdownListExampleState extends State<DropdownListExample> {
  final Map<String, List<String>> items = {
    'Clase1': ['1', '2', '2'],
    'Clase2': ['3', '2', '1'],
    'Clase3': ['0', '1', '2'],
  };

  int? selectedClase;

  final Future<List<Clase>> clases = ClaseServicio().getClases();
  final Future<List<Usuario>> usuarios = UsuarioService().getUsuarios();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([clases, usuarios]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        final clasesList = snapshot.data![0] as List<Clase>;

        clasesList.sort((a, b) => a.casilla.dia.compareTo(b.casilla.dia));

        final usuariosList = snapshot.data![1] as List<Usuario>;

        final clasesItems = clasesList
            .map<DropdownMenuItem<int>>(
              (e) => DropdownMenuItem(
                value: e.id,
                child: Text(
                    "${e.casilla.dia == 1 ? "Lunes" : e.casilla.dia == 2 ? "Martes" : e.casilla.dia == 3 ? "Miercoles" : e.casilla.dia == 4 ? "Jueves" : e.casilla.dia == 5 ? "Viernes" : e.casilla.dia == 6 ? "Sábado" : e.casilla.dia == 7 ? "Domingo" : "No"} - ${e.casilla.horaini} a ${e.casilla.horafin} - ${e.curso.curso}"),
              ),
            )
            .toList();

        var updatableList = usuariosList
            .where(
              (e) =>
                  e.horario?.any(
                      (h) { return h.idclase == (selectedClase ?? 0);}) ??
                  false,
            )
            .toList();

        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              SizedBox(height: 20),
              DropdownButton(
                dropdownColor: Colors.black,
                value: selectedClase,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                iconEnabledColor: Colors.red,
                items: clasesItems,
                onChanged: (value) {
                  setState(() {
                    selectedClase = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[900]?.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: updatableList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.red, width: 1),
                        ),
                        child: ListTile(
                          title: Text(
                            "${updatableList[index].personales?.nombre} ${updatableList[index].personales?.apellidop} ${updatableList[index].personales?.apellidom}",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(Icons.class_, color: Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
