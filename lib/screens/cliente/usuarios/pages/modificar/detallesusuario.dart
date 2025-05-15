import 'package:flutter/material.dart';
import 'package:proyecto/services/usuario_service.dart';

import '../../../../../../models/usuario_model.dart';

class Detallesusuariomodif extends StatefulWidget {
  @override
  State<Detallesusuariomodif> createState() => _DetallesusuariomodifState();
}

class _DetallesusuariomodifState extends State<Detallesusuariomodif> {
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
  final service = UsuarioService();
  final Usuario usuario;
  CuentaDetalles({required this.usuario});
  @override
  Widget build(BuildContext context) {
    final _nombreusuController =
        TextEditingController(text: usuario.cuenta.nombreusu);
    final _passwordController = TextEditingController();
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Usuario')),
          DataColumn(label: Text('Passwordhash')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(TextField(
                controller: _nombreusuController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.cuenta.nombreusu = value;
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _passwordController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.cuenta.password = value;
                  service.modificarUsuario(usuario.toJson());
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class DomicilioDetalles extends StatelessWidget {
  final service = UsuarioService();
  final Usuario usuario;
  DomicilioDetalles({required this.usuario});
  @override
  Widget build(BuildContext context) {
    final _calleController =
        TextEditingController(text: usuario.domicilio.calle);
    final _numextController =
        TextEditingController(text: usuario.domicilio.numext.toString());
    final _numintController =
        TextEditingController(text: usuario.domicilio.numint.toString());
    final _asentamientoController =
        TextEditingController(text: usuario.domicilio.asentamiento);
    final _codigopController =
        TextEditingController(text: usuario.domicilio.codigop.toString());
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
              DataCell(TextField(
                controller: _calleController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.domicilio.calle = value;
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _numextController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.domicilio.numext = int.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _numintController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.domicilio.numint = int.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _asentamientoController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.domicilio.asentamiento = value;
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _codigopController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.domicilio.codigop = int.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class MetricasDetalles extends StatelessWidget {
  final service = UsuarioService();
  final Usuario usuario;
  MetricasDetalles({required this.usuario});
  @override
  Widget build(BuildContext context) {
    final _estaturaController =
        TextEditingController(text: usuario.metricas.estatura.toString());
    final _pesoController =
        TextEditingController(text: usuario.metricas.peso.toString());
    final _maxcardioController =
        TextEditingController(text: usuario.metricas.maxcardio.toString());
    final _maxpulsoController =
        TextEditingController(text: usuario.metricas.maxpulso.toString());
    final _frecuenciasemanalController =
        TextEditingController(text: usuario.metricas.frecuenciasemanal.toString());
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
              DataCell(TextField(
                controller: _estaturaController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.metricas.estatura = double.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _pesoController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.metricas.peso = double.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _maxcardioController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.metricas.maxcardio = double.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _maxpulsoController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.metricas.maxpulso = int.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
              DataCell(TextField(
                controller: _frecuenciasemanalController,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  usuario.metricas.frecuenciasemanal = int.parse(value);
                  service.modificarUsuario(usuario.toJson());
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}
