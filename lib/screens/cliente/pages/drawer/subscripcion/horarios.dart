import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/services/clase_servicio.dart';

class HorariosPage extends StatefulWidget {
  @override
  _HorariosPageState createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {
  final int rows = 12;
  final int cols = 7;
  List<List<bool>> selected = [];
  final List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  Paquete? paqueteSeleccionado;
  int maxClases = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final paqueteJson =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    paqueteSeleccionado = Paquete.fromJson(paqueteJson!);
    // Detecta el máximo de clases según el paquete
    if (paqueteSeleccionado != null) {
      maxClases = paqueteSeleccionado!.clases;
    }
  }

  @override
  void initState() {
    super.initState();
    selected = List.generate(rows, (_) => List.generate(cols, (_) => false));
  }

  int get seleccionadosCount {
    int count = 0;
    for (var row in selected) {
      for (var cell in row) {
        if (cell) count++;
      }
    }
    return count;
  }

  void _onCellTap(int row, int col) {
    setState(() {
      if (selected[row][col]) {
        // Permite deseleccionar siempre
        selected[row][col] = false;
      } else {
        // Solo permite seleccionar si no se ha llegado al máximo
        if (seleccionadosCount < maxClases) {
          selected[row][col] = true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Solo puedes seleccionar $maxClases clase(s) según tu paquete.')),
          );
        }
      }
    });
  }

  void _contratar() {
    //enviar la selección a la siguiente pantalla
    final paqueteJson =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final paqueteSeleccionado = Paquete.fromJson(paqueteJson!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HorariosSeleccionadosPage(
          seleccion: selected,
          dias: dias,
          paqueteSeleccionado: paqueteSeleccionado,
        ),
      ),
    );
  }

  final Future<List<Clase>> clases = ClaseServicio().getClases();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: clases,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final clasesLista = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text('Selecciona tus horarios')),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 60 + cols * 108, // Width = label + columns
                      child: Column(
                        children: [
                          // Header row
                          Row(
                            children: [
                              Container(
                                width: 60,
                                alignment: Alignment.center,
                              ),
                              ...dias.map((d) => Container(
                                    width: 100,
                                    padding: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    child: Text(d,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ],
                          ),
                          // Grid rows
                          Expanded(
                            child: ListView.builder(
                              itemCount: rows,
                              itemBuilder: (context, row) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Text(
                                        "${(row + 8).toString().padLeft(2, '0')}:00",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ...List.generate(cols, (col) {
                                      var clase = clasesLista
                                          .where((element) =>
                                              element.casilla.dia == col &&
                                              int.parse(element.casilla.horaini
                                                      .substring(0, 2)) ==
                                                  (row + 8))
                                          .toList();
            
                                      return Container(
                                        width: 100,
                                        height: 60,
                                        margin: EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: clase.isEmpty
                                              ? null
                                              : () => _onCellTap(row, col),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: selected[row][col]
                                                  ? Colors.red
                                                  : Colors.grey[300],
                                              border: Border.all(
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: clase.isEmpty
                                                ? SizedBox.shrink()
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        clase[0].curso.curso,
                                                        style: TextStyle(
                                                          color: selected[row]
                                                                  [col]
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        "${clase[0].casilla.horaini} - ${clase[0].casilla.horafin}",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: selected[row]
                                                                  [col]
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        clase[0].coach.nombre,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: selected[row]
                                                                  [col]
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _contratar,
                    child: Text('Contratar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HorariosSeleccionadosPage extends StatelessWidget {
  final List<List<bool>> seleccion;
  final List<String> dias;
  final Paquete? paqueteSeleccionado;

  HorariosSeleccionadosPage(
      {required this.seleccion,
      required this.dias,
      required this.paqueteSeleccionado});

  @override
  Widget build(BuildContext context) {
    List<String> seleccionados = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios Seleccionados'),
      ),
      body: FutureBuilder(
          future: ClaseServicio().getClases(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            final clasesList = snapshot.data!;
            List<Clase> listaClases = [];

            for (int row = 0; row < seleccion.length; row++) {
              for (int col = 0; col < seleccion[row].length; col++) {
                if (seleccion[row][col]) {
                  try {
                    final matchingClase = clasesList.firstWhere(
                      (e) =>
                          e.casilla.dia == col &&
                          int.parse(e.casilla.horaini.substring(0, 2)) ==
                              (row + 8),
                    );
                    listaClases.add(matchingClase);
                  } catch (e) {
                    // No matching class found – skip
                  }
                }
              }
            }

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (listaClases.isEmpty)
                    Text('No seleccionaste ningún horario.')
                  else
                    Center(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: listaClases
                            .map((e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 205, 205),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Text(
                                    "${e.casilla.dia == 1 ? "Lunes" : e.casilla.dia == 2 ? "Martes" : e.casilla.dia == 3 ? "Miercoles" : e.casilla.dia == 4 ? "Jueves" : e.casilla.dia == 5 ? "Viernes" : e.casilla.dia == 6 ? "Sábado" : e.casilla.dia == 7 ? "Domingo" : "No"} - ${e.casilla.horaini} a ${e.casilla.horafin} - ${e.curso.curso}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (clasesList.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Atención'),
                              content: Text(
                                  'Debes seleccionar al menos una clase para continuar.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.pushNamed(context, '/carrito', arguments: {
                            'clases': listaClases,
                            'paquete': paqueteSeleccionado,
                          });
                        }
                      },
                      child: Text('Continuar'),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
