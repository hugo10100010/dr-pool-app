import 'package:flutter/material.dart';

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
  final TextEditingController _direccionController =
      TextEditingController(text: 'El Carmen 2');
  final TextEditingController _telefonoController =
      TextEditingController(text: '555-123-4567');
  final TextEditingController _emailController =
      TextEditingController(text: 'ramon.alfonso@email.com');

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      decoration: InputDecoration(labelText: 'Nombre completo'),
      enabled: editable,
      validator: (value) =>
          value == null || value.isEmpty ? 'Ingrese su nombre' : null,
    ),
    SizedBox(height: 16),
    TextFormField(
      controller: _telefonoController,
      decoration: InputDecoration(labelText: 'Teléfono'),
      keyboardType: TextInputType.phone,
      enabled: editable,
      validator: (value) =>
          value == null || value.isEmpty ? 'Ingrese su teléfono' : null,
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