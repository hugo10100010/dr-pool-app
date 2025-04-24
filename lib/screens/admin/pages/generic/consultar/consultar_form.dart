import 'package:flutter/material.dart';

class GenericConsultar<T> extends StatelessWidget {
  final Future<List<T>> futureItems;
  final List<DataColumn> Function() buildColumns;
  final DataRow Function(T item) buildRow;
  final void Function(T item)? onRowTap;

  const GenericConsultar({
    required this.futureItems,
    required this.buildColumns,
    required this.buildRow,
    this.onRowTap,
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
            columns: buildColumns(),
            rows: items.map((item) {
              final row = buildRow(item);
              return DataRow(
                cells: row.cells,
                onLongPress: () => onRowTap?.call(item),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
