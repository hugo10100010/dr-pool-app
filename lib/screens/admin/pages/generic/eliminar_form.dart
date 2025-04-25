import 'package:flutter/material.dart';

class GenericEliminar<T> extends StatelessWidget {
  final Future<List<T>> futureItems;
  final List<String> columnTitles;
  final List<String> Function(T item) displayValues;
  final String Function(T item) getDeleteLabel;
  final Future<String> Function(T item) onDelete;

  const GenericEliminar({
    required this.futureItems,
    required this.columnTitles,
    required this.displayValues,
    required this.getDeleteLabel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));

        final items = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: columnTitles.map((title) => DataColumn(label: Text(title))).toList(),
            rows: items.map((item) {
              final values = displayValues(item);
              return DataRow(
                cells: values.map((val) => DataCell(Text(val))).toList(),
                onLongPress: () async {
                  final result = await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Eliminar"),
                      content: Text("¿Deseas eliminar: ${getDeleteLabel(item)}?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, {"action": false}),
                          child: Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final message = await onDelete(item);
                            Navigator.pop(context, {"action": true, "message": message});
                          },
                          child: Text("Confirmar"),
                        ),
                      ],
                    ),
                  );

                  if (result?['action'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result?['message'] ?? 'Eliminado')),
                    );
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
