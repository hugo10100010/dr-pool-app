import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/services/usuario_service.dart';
import 'package:proyecto/widgets/image_picker.dart';

class CuentaPage extends StatefulWidget {
  @override
  State<CuentaPage> createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  final TextEditingController _nombreUsuController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String avatarb64 = "";

  void escogerArchivo(String? base64Data) {
    if (base64Data != null) {
      if (base64Data.isEmpty) {
        return;
      } else {
        avatarb64 = base64Data;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //  _nombreUsuController.text="OAS";
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    _nombreUsuController.text = usuario!.cuenta.nombreusu;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de cuenta'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 15.0,
          children: [
            Flexible(
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  enabled: true,
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
                  child: ImagePickerField(onImagePicked: escogerArchivo)),
            ),
            Flexible(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Uint8List bytes = base64Decode(avatarb64);
                    UsuarioService().modificarUsuario(
                      {
                        "id": usuario!.id,
                        "cuenta": {
                          "nombreusu": _nombreUsuController.text,
                          "avatar": bytes,
                        }
                      },
                    );
                    Provider.of<UsuarioProvider>(context, listen: false).actualizarAvatar(bytes);
                  },
                  child: Text("Confirmar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
