import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/services/usuario_service.dart';
import 'package:proyecto/widgets/image_picker.dart';

class CuentaPage extends StatefulWidget {
  @override
  State<CuentaPage> createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  final TextEditingController _nombreUsuController = TextEditingController();
  String avatarb64 = "";
  bool editando = false;

  void escogerArchivo(String? base64Data) {
    if (base64Data != null && base64Data.isNotEmpty) {
      avatarb64 = base64Data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    _nombreUsuController.text = usuario?.cuenta?.nombreusu ?? '';
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de cuenta'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Flexible(
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  enabled: editando,
                  controller: _nombreUsuController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre de usuario'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo es obligatorio';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: 300,
                child: AbsorbPointer(
                  absorbing: !editando,
                  child: Opacity(
                    opacity: editando ? 1.0 : 0.5,
                    child: ImagePickerField(onImagePicked: escogerArchivo),
                  ),
                ),
              ),
            ),
            Flexible(
  child: SizedBox(
    width: 300,
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            icon: Icon(editando ? Icons.lock_open : Icons.lock),
            label: Text(editando ? 'Bloquear edición' : 'Editar'),
            onPressed: () {
              setState(() {
                editando = !editando;
              });
            },
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: editando
              ? () {
                  Uint8List bytes = base64Decode(avatarb64);
                  UsuarioService().modificarUsuario({
                    "id": usuario?.id,
                    "cuenta": {
                      "nombreusu": _nombreUsuController.text,
                      "avatar": bytes,
                    }
                  });
                  Provider.of<UsuarioProvider>(context, listen: false).actualizarAvatar(bytes);
                  setState(() {
                    editando = false;
                  });
                }
              : null,
          child: Text("Confirmar"),
        ),
        if (editando)
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Restaurar valores originales
                _nombreUsuController.text = usuario?.cuenta?.nombreusu ?? '';
                avatarb64 = "";
                editando = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text("Cancelar"),
          ),
      ],
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}