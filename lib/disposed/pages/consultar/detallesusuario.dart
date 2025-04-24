import 'package:flutter/material.dart';

import '../../../../../../models/usuario_model.dart';

class Detallesusuario extends StatefulWidget {
  @override
  State<Detallesusuario> createState() => _DetallesusuarioState();
}

class _DetallesusuarioState extends State<Detallesusuario> {
  final tabs = [
    Tab(
      child: Text('Cuenta'),
    ),
    Tab(
      child: Text('Domicilio'),
    ),
    Tab(
      child: Text('Metricas'),
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final usuario = args['usuario']!;

    final pages = [
      CuentaDetalles(
        usuario: usuario,
      ),
      DomicilioDetalles(
        usuario: usuario,
      ),
      MetricasDetalles(
        usuario: usuario,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
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
      ),
    );
  }
}

class CuentaDetalles extends StatelessWidget {
  final Usuario usuario;
  CuentaDetalles({required this.usuario});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Usuario')),
          DataColumn(label: Text('Passwordhash')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text(usuario.cuenta.nombreusu)),
              DataCell(Text(usuario.cuenta.password))
            ],
          ),
        ],
      ),
    );
  }
}

class DomicilioDetalles extends StatelessWidget {
  final Usuario usuario;
  DomicilioDetalles({required this.usuario});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Calle')),
          DataColumn(label: Text('Num. ext.')),
          DataColumn(label: Text('Num. int.')),
          DataColumn(label: Text('Asentamiento')),
          DataColumn(label: Text('Codigo postal')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text(usuario.domicilio.calle)),
              DataCell(Text("${usuario.domicilio.numext}")),
              DataCell(Text("${usuario.domicilio.numint}")),
              DataCell(Text(usuario.domicilio.asentamiento)),
              DataCell(Text("${usuario.domicilio.codigop}")),
            ],
          ),
        ],
      ),
    );
  }
}

class MetricasDetalles extends StatelessWidget {
  final Usuario usuario;
  MetricasDetalles({required this.usuario});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Estatura')),
          DataColumn(label: Text('Peso')),
          DataColumn(label: Text('Max. Cardio')),
          DataColumn(label: Text('Max. Pulso')),
          DataColumn(label: Text('Frecuencia semanal')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text("${usuario.metricas.estatura}")),
              DataCell(Text("${usuario.metricas.peso}")),
              DataCell(Text("${usuario.metricas.maxcardio}")),
              DataCell(Text("${usuario.metricas.maxpulso}")),
              DataCell(Text("${usuario.metricas.frecuenciasemanal}")),
            ],
          ),
        ],
      ),
    );
  }
}
