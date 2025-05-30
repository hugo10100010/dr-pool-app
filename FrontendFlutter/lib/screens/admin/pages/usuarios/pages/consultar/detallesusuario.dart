import 'package:flutter/material.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/consultar/detalles_form.dart';

class Detallesusuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final usuario = args['usuario'] as Usuario;

    return GenericDetalles(
      tabTitles: ['Cuenta', 'Domicilio', 'Metricas'],
      tabPages: [
        buildCuenta(usuario),
        buildDomicilio(usuario),
        buildMetricas(usuario),
      ],
    );
  }

  Widget buildCuenta(Usuario usuario) => SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(columns: [
              DataColumn(label: Text('Usuario')),
            ], rows: [
              DataRow(cells: [
                DataCell(Text(usuario.cuenta?.nombreusu ?? '')),
              ]),
            ]),
          ),
        ),
      );

  Widget buildDomicilio(Usuario usuario) => SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(columns: [
              DataColumn(label: Text('Calle')),
              DataColumn(label: Text('Num. ext.')),
              DataColumn(label: Text('Num. int.')),
              DataColumn(label: Text('Asentamiento')),
              DataColumn(label: Text('Codigo p.')),
            ], rows: [
              DataRow(cells: [
                DataCell(Text(usuario.domicilio?.calle ?? '')),
                DataCell(Text('${usuario.domicilio?.numext ?? ''}')),
                DataCell(Text('${usuario.domicilio?.numint ?? ''}')),
                DataCell(Text(usuario.domicilio?.asentamiento ?? '')),
                DataCell(Text('${usuario.domicilio?.codigop ?? ''}')),
              ]),
            ]),
          ),
        ),
      );

  Widget buildMetricas(Usuario usuario) => SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(columns: [
              DataColumn(label: Text('Estatura')),
              DataColumn(label: Text('Peso')),
              DataColumn(label: Text('Max. cardio')),
              DataColumn(label: Text('Max. pulso')),
              DataColumn(label: Text('Frecuencia semanal')),
            ], rows: [
              DataRow(cells: [
                DataCell(Text('${usuario.metricas?.estatura ?? ''}')),
                DataCell(Text('${usuario.metricas?.peso ?? ''}')),
                DataCell(Text('${usuario.metricas?.maxcardio ?? ''}')),
                DataCell(Text('${usuario.metricas?.maxpulso ?? ''}')),
                DataCell(Text('${usuario.metricas?.frecuenciasemanal ?? ''}')),
              ]),
            ]),
          ),
        ),
      );
}
