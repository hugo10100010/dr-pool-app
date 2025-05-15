import 'package:flutter/material.dart';
//import 'pages/eliminar.dart';
import 'pages/agregar.dart';
import 'pages/consultar.dart';

class ClasesPage extends StatefulWidget {
  @override
  State<ClasesPage> createState() => _ClasesPageState();
}

class _ClasesPageState extends State<ClasesPage> {
  final tabs = [
    Tab(
      child: Text('Agregar'),
    ),
    Tab(
      child: Text('Consultar'),
    ),
    Tab(
      child: Text('Eliminar'),
    ),
    Tab(
      child: Text('Modificar'),
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      SeleccionarCursoWidget(), // de agregar.dart
      DropdownListExample(),   // de consultar.dart
      Center(child: Text('Eliminar')), // Placeholder para Eliminar
      Center(child: Text('Modificar')), // Placeholder para Modificar
    ];
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            tabs: tabs,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
          Expanded(child: pages[selectedIndex])
        ],
      ),
    );
  }
}
