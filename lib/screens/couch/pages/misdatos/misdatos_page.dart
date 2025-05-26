import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/services/usuario_service.dart';

class MisdatosPage extends StatefulWidget {
  @override
  _MisdatosPageState createState() => _MisdatosPageState();
}

class _MisdatosPageState extends State<MisdatosPage> {
  final _formKey = GlobalKey<FormState>();
  bool editable = false; // Controla si los campos están habilitados

  // Datos de ejemplo
  final TextEditingController _nombreController =
      TextEditingController(text: '');
  final TextEditingController _apellidopController =
      TextEditingController(text: "");
  final TextEditingController _apellidomController =
      TextEditingController(text: "");
  final TextEditingController _telefonoController =
      TextEditingController(text: '');
  final TextEditingController _emailController =
      TextEditingController(text: '');

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
    _nombreController.text = usuario.personales.nombre;
    _apellidopController.text = usuario.personales.apellidop;
    _apellidomController.text = usuario.personales.apellidom;
    _emailController.text = usuario.personales.email;
    _telefonoController.text = usuario.personales.telefono;

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
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          UsuarioService().modificarUsuario({
                            "id": usuario.id,
                            "personales": {
                              "nombre": _nombreController.text,
                              "apellidop": _apellidopController.text,
                              "apellidom": _apellidomController.text,
                              "email": _emailController.text,
                              "telefono": _telefonoController.text,
                            }
                          });
                          Provider.of<UsuarioProvider>(context, listen: false)
                              .actualizarPersonales(
                            _nombreController.text,
                            _apellidopController.text,
                            _apellidomController.text,
                            _emailController.text,
                            _telefonoController.text,
                          );
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
