import 'package:flutter/material.dart';
import 'pages/eliminar.dart';
import 'pages/agregar.dart';
import 'pages/consultar/consultar.dart';
import 'pages/modificar/modificar.dart';

class PaquetesPage extends StatefulWidget {
  @override
  State<PaquetesPage> createState() => _PaquetesPageState();
}

class _PaquetesPageState extends State<PaquetesPage> {
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
      Agregar(),
      Consultar(),
      Eliminar(),
      Modificar()
    ];
    return Column(
      children: [
        DefaultTabController(
          length: 4,
          child: TabBar(
            tabs: tabs,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        ),
        Expanded(child: pages[selectedIndex])
      ],
    );
  }
}
