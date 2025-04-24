import 'package:flutter/material.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/editablefield.dart';
import './editablefield.dart';

class GenericDetallesModificables extends StatefulWidget {
  final List<String> tabTitles;
  final List<List<EditableField>> editableTabs;

  const GenericDetallesModificables({
    required this.tabTitles,
    required this.editableTabs,
  });

  @override
  State<GenericDetallesModificables> createState() => _GenericDetallesModificablesState();
}

class _GenericDetallesModificablesState extends State<GenericDetallesModificables>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabTitles.length, vsync: this);
  }

  Widget buildTab(List<EditableField> fields) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columns: fields.map((f) => DataColumn(label: Text(f.label))).toList(),
        rows: [
          DataRow(
            cells: fields.map((f) {
              return DataCell(TextField(
                controller: f.controller,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: f.onSubmit,
              ));
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar detalles"),
        bottom: TabBar(
          controller: _controller,
          tabs: widget.tabTitles.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: widget.editableTabs.map((tab) => buildTab(tab)).toList(),
      ),
    );
  }
}
