import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/helpers/isonline_func.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/services/usuario_service.dart';

class DomicilioPage extends StatefulWidget {
  @override
  _DomicilioPageState createState() => _DomicilioPageState();
}

class _DomicilioPageState extends State<DomicilioPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numeroextController = TextEditingController();
  final TextEditingController _numerointController = TextEditingController();
  final TextEditingController _asentamientoController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();

  bool editable = false;

  @override
  void dispose() {
    _calleController.dispose();
    _numeroextController.dispose();
    _numerointController.dispose();
    _asentamientoController.dispose();
    _cpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    _calleController.text = usuario!.domicilio?.calle ?? '';
    _numeroextController.text = usuario.domicilio?.numext?.toString() ?? '';
    _numerointController.text = usuario.domicilio?.numint?.toString() ?? '';
    _asentamientoController.text = usuario.domicilio?.asentamiento ?? '';
    _cpController.text = usuario.domicilio?.codigop?.toString() ?? '';
    return Scaffold(
      appBar: AppBar(title: Text('Domicilio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _calleController,
                decoration: InputDecoration(labelText: 'Calle'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese la calle' : null,
                enabled: editable,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _numeroextController,
                decoration: InputDecoration(labelText: 'Número ext.'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese el número exterior'
                    : null,
                enabled: editable,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _numerointController,
                decoration: InputDecoration(labelText: 'Número int.'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese el número exterior'
                    : null,
                enabled: editable,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _asentamientoController,
                decoration: InputDecoration(labelText: 'Asentamiento'),
                enabled: editable,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _cpController,
                decoration: InputDecoration(labelText: 'Código Postal'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese el código postal'
                    : null,
                enabled: editable,
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: Icon(editable ? Icons.lock_open : Icons.lock),
                  label: Text(editable ? 'Bloquear edición' : 'Editar'),
                  onPressed: () async {
                    bool online = await isOnline();
                    if (online) {
                      setState(() {
                        editable = !editable;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("No hay conexión a internet...")));
                    }
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: editable
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "id": usuario.id,
                          };

                          Map<String, dynamic> domicilio = {"id": usuario.domicilio!.id};

                          if (_calleController.text.isNotEmpty) {
                            domicilio["calle"] = _calleController.text;
                          }
                          if (_numeroextController.text.isNotEmpty) {
                            domicilio["numext"] =
                                int.parse(_numeroextController.text);
                          }
                          if (_numerointController.text.isNotEmpty) {
                            domicilio["numint"] =
                                int.parse(_numerointController.text);
                          }
                          if (_asentamientoController.text.isNotEmpty) {
                            domicilio["asentamiento"] =
                                _asentamientoController.text;
                          }
                          if (_cpController.text.isNotEmpty) {
                            domicilio["codigop"] =
                                int.parse(_cpController.text);
                          }

                          if (domicilio.isNotEmpty) {
                            data["domicilio"] = domicilio;
                          }

                          bool success =
                              await UsuarioService().modificarUsuario(data);
                          if (success) {
                            Provider.of<UsuarioProvider>(context, listen: false)
                                .actualizarDomicilio(
                              domicilio["calle"],
                              domicilio["numext"],
                              domicilio["numint"],
                              domicilio["asentamiento"],
                              domicilio["codigop"],
                            );
                          }

                          setState(() {
                            editable = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Domicilio guardado')),
                          );
                        }
                      }
                    : null,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
