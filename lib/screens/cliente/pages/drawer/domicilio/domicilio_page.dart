import 'package:flutter/material.dart';

class DomicilioPage extends StatefulWidget {
  @override
  _DomicilioPageState createState() => _DomicilioPageState();
}

class _DomicilioPageState extends State<DomicilioPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController(text: 'El Carmen 2');
  final TextEditingController _ciudadController = TextEditingController(text: 'Tuxtla Gutiérrez');
  final TextEditingController _estadoController = TextEditingController(text: 'Chiapas');
  final TextEditingController _cpController = TextEditingController();

  bool editable = false;

  @override
  void dispose() {
    _calleController.dispose();
    _numeroController.dispose();
    _coloniaController.dispose();
    _ciudadController.dispose();
    _estadoController.dispose();
    _cpController.dispose();
    super.dispose();
  }

  void _guardarDomicilio() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        editable = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Domicilio guardado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                validator: (value) => value == null || value.isEmpty ? 'Ingrese la calle' : null,
                enabled: editable,
              ),
              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(labelText: 'Número'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese el número' : null,
                enabled: editable,
              ),
              TextFormField(
                controller: _coloniaController,
                decoration: InputDecoration(labelText: 'Colonia'),
                enabled: editable,
              ),
              TextFormField(
                controller: _ciudadController,
                decoration: InputDecoration(labelText: 'Ciudad'),
                enabled: editable,
              ),
              TextFormField(
                controller: _estadoController,
                decoration: InputDecoration(labelText: 'Estado'),
                enabled: editable,
              ),
              TextFormField(
                controller: _cpController,
                decoration: InputDecoration(labelText: 'Código Postal'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Ingrese el código postal' : null,
                enabled: editable,
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
                        _guardarDomicilio();
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