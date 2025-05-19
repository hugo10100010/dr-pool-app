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
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      SeleccionarCursoWidget(), // de agregar.dart
      DropdownListExample(),   // de consultar.dart/ Placeholder para Modificar
    ];
    return DefaultTabController(
      length: 2,
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
