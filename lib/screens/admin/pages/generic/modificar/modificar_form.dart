import 'package:flutter/material.dart';
import '../../../../../models/field_config_model.dart';

enum EditableFieldType { text, int, double, dropdown }

class GenericEditableField<T> {
  final TextEditingController controller;
  final EditableFieldType type;
  final void Function(String value) onSubmit;
  final List<DropdownOption<T>>? dropdownItems;

  GenericEditableField({
    required this.controller,
    this.type = EditableFieldType.text,
    required this.onSubmit,
    this.dropdownItems,
  });
}

class GenericModificar<T> extends StatelessWidget {
  final Future<List<T>> futureItems;
  final List<String> columnTitles;
  final List<GenericEditableField<dynamic>> Function(T item)
      buildEditableFields;
  final void Function(T item)? onRowTap;

  const GenericModificar({
    required this.futureItems,
    required this.columnTitles,
    required this.buildEditableFields,
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
            columns: columnTitles
                .map((title) => DataColumn(label: Text(title)))
                .toList(),
            rows: items.map((item) {
              final fieldControllers = buildEditableFields(item);
              return DataRow(
                cells: fieldControllers.map((field) {
                  final selectedOption = field.dropdownItems?.firstWhere(
                        (opt) => opt.value.toString() == field.controller.text,
                        orElse: () =>
                            field.dropdownItems?.first ??
                            DropdownOption<dynamic>(
                                value: "",
                                label: "Default"), // Provide a default value
                      ) ??
                      DropdownOption<dynamic>(
                          value: "", label: "Default"); // Fallback
// Provide a default value

                  return DataCell(
                    field.dropdownItems != null
                        ? () {
                            final items = field.dropdownItems!;
                            final selectedOption = items.firstWhere(
                              (opt) =>
                                  opt.value.toString() == field.controller.text,
                              orElse: () => items.first,
                            );

                            return DropdownButtonFormField<dynamic>(
                              value: selectedOption.value,
                              items: items
                                  .map((opt) => DropdownMenuItem<dynamic>(
                                        value: opt.value,
                                        child: Text(opt.label),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  field.controller.text = value.toString();
                                  field.onSubmit(value.toString());
                                }
                              },
                            );
                          }()
                        : TextFormField(
                            controller: field.controller,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            keyboardType: field.type == EditableFieldType.int
                                ? TextInputType.number
                                : field.type == EditableFieldType.double
                                    ? TextInputType.numberWithOptions(
                                        decimal: true)
                                    : TextInputType.text,
                            onFieldSubmitted: (value) {
                              String? error;
                              if (value.isEmpty) {
                                error = 'Campo obligatorio';
                              } else if (field.type == EditableFieldType.int &&
                                  int.tryParse(value) == null) {
                                error = 'Debe ser un número entero';
                              } else if (field.type ==
                                      EditableFieldType.double &&
                                  double.tryParse(value) == null) {
                                error = 'Debe ser un número decimal';
                              }

                              if (error == null) {
                                field.onSubmit(value);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                field.controller.text = '';
                              }
                            },
                          ),
                  );
                }).toList(),
                onLongPress: () => onRowTap?.call(item),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
