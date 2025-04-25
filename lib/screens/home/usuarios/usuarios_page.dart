import 'package:flutter/material.dart';
import './pages/agregar.dart';
import './pages/consultar/consultar.dart';
import './pages/eliminar.dart';
import './pages/modificar/modificar.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
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

  final pages = [
    Agregar(),
    Consultar(),
    Eliminar(),
    Modificar()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 4,
          child: TabBar(tabs: tabs, onTap:(value) {
            setState(() {
              selectedIndex=value;
            });
          },),
        ),
        Expanded(child: pages[selectedIndex])
      ],
    );
  }
}
