import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerField extends StatefulWidget {
  final void Function(String? base64Data)? onImagePicked;
  final Icon? icon;
  final String? label;

  const ImagePickerField({
    super.key,
    required this.onImagePicked,
    this.label = 'Seleccionar imagen',
    this.icon,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  String? _fileName;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      final file = File(path);
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        _fileName = result.files.single.name;
      });

      widget.onImagePicked?.call(base64Image);
    } else {
      widget.onImagePicked?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          icon: widget.icon,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.image),
        ),
        child: Text(
          _fileName ?? 'Ninguna imagen seleccionada',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
