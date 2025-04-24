import 'package:flutter/material.dart';

enum FieldType { text, int, double, dropdown }

class DropdownOption<T> {
  final T value;
  final String label;

  DropdownOption({required this.value, required this.label});
}


class FieldConfig<T> {
  final String key;
  final String label;
  final FieldType type;
  final bool obscureText;
  final TextInputType inputType;
  final List<DropdownOption<T>>? dropdownItems;

  FieldConfig({
    required this.key,
    required this.label,
    this.type = FieldType.text,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.dropdownItems,
  });
}

