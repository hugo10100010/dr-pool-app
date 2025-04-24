import 'package:flutter/material.dart';

class EditableField {
  final String label;
  final TextEditingController controller;
  final void Function(String) onSubmit;

  EditableField({
    required this.label,
    required this.controller,
    required this.onSubmit,
  });
}
