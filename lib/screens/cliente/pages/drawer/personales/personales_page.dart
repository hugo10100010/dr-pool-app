import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/services/usuario_service.dart';

class personalesclientePage extends StatefulWidget {
  @override
  _PersonalesPageState createState() => _PersonalesPageState();
}

class _PersonalesPageState extends State<personalesclientePage> {
  final _formKey = GlobalKey<FormState>();
  bool editable = false; // Controla si los campos están habilitados

  // Datos de ejemplo
  final TextEditingController _nombreController =
      TextEditingController(text: 'Ramon Alfonso');
  final TextEditingController _apellidopController =
      TextEditingController(text: "");
  final TextEditingController _apellidomController =
      TextEditingController(text: "");
  final TextEditingController _telefonoController =
      TextEditingController(text: '555-123-4567');
  final TextEditingController _emailController =
      TextEditingController(text: 'ramon.alfonso@email.com');

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidopController.dispose();
    _apellidomController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario!;
    _nombreController.text = usuario.personales!.nombre;
    _apellidopController.text = usuario.personales!.apellidop;
    _apellidomController.text = usuario.personales!.apellidom;
    _emailController.text = usuario.personales!.email;
    _telefonoController.text = usuario.personales!.telefono;

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Personales'),
        actions: [
          IconButton(
            icon: Icon(editable ? Icons.lock_open : Icons.lock),
            tooltip: editable ? 'Bloquear edición' : 'Editar',
            onPressed: () {
              setState(() {
                editable = !editable;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                enabled: editable,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese su nombre' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _apellidopController,
                decoration: InputDecoration(labelText: 'Apellido P.'),
                enabled: editable,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese su apellido paterno'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _apellidomController,
                decoration: InputDecoration(labelText: 'Apellido M.'),
                enabled: editable,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese su apellido materno'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                enabled: editable,
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese su teléfono'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
                enabled: editable,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese su correo' : null,
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: Icon(editable ? Icons.lock_open : Icons.lock),
                  label: Text(editable ? 'Bloquear edición' : 'Editar'),
                  onPressed: () {
                    setState(() {
                      editable = !editable;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: editable
                    ? () async {
                        Map<String, dynamic> data = {
                          "id": usuario.id,
                        };
                        Map<String,dynamic> personales = {};
                        if (_nombreController.text.isNotEmpty) {
                          personales["nombre"] = _nombreController.text;
                        }
                        if (_apellidopController.text.isNotEmpty) {
                          personales["apellidop"] = _apellidopController.text;
                        }
                        if (_apellidomController.text.isNotEmpty) {
                          personales["apellidom"] = _apellidomController.text;
                        }
                        if (_emailController.text.isNotEmpty) {
                          personales["email"] = _emailController.text;
                        }
                        if (_telefonoController.text.isNotEmpty) {
                          personales["telefono"] = _telefonoController.text;
                        }
                        if(personales.isNotEmpty) {
                          data["personales"] = personales;
                        }

                        if (_formKey.currentState!.validate()) {
                          bool success =
                              await UsuarioService().modificarUsuario(data);
                          if (success) {
                            Provider.of<UsuarioProvider>(context, listen: false)
                                .actualizarPersonales(
                              personales["nombre"],
                              personales["apellidop"],
                              personales["apellidom"],
                              personales["email"],
                              personales["telefono"],
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Datos guardados')),
                          );
                          setState(() {
                            editable = false;
                          });
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
