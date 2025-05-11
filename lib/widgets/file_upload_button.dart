import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class FileUploadButton extends StatelessWidget {
  PlatformFile file;

  FileUploadButton({required this.file});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('UPLOAD FILE'),
      onPressed: () async {
        var picked = await FilePicker.platform.pickFiles(type:FileType.image, allowedExtensions: ['jpg','gif','png'], allowMultiple: false);

        if (picked != null) {
          file = picked.files.first;
        }
      },
    );
  }
}