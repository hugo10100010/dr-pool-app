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
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<List<T>>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final items = snapshot.data!;
            final columns = buildColumns();
            final rows = items.map((item) {
              final row = buildRow(item);
              return DataRow(
                cells: row.cells,
                onLongPress: () => onRowTap?.call(item),
              );
            }).toList();

            // Responsive threshold
            final isNarrow = constraints.maxWidth < 600;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: isNarrow
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(columns: columns, rows: rows),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(columns: columns, rows: rows),
                    ),
            );
          },
        );
      },
    );
  }
}
