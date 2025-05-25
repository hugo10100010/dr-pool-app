import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _asentamientoController = TextEditingController(text: 'El Carmen 2');
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

  void _guardarDomicilio(int id, String calle, int numext, int numint, String asentamiento, int codigop) {
    if (_formKey.currentState!.validate()) {
      UsuarioService().modificarUsuario({
        "id": id,
        "domicilio": {
          "calle": calle,
          "numext": numext,
          "numint": numint,
          "asentamiento": asentamiento,
          "codigop": codigop,
        }
      });
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
    final usuario = Provider.of<UsuarioProvider>(context).usuario!;
    _calleController.text = usuario!.domicilio.calle ?? '';
    _numeroextController.text = usuario!.domicilio.numext?.toString() ?? '';
    _numerointController.text = usuario!.domicilio.numint?.toString() ?? '';
    _asentamientoController.text = usuario!.domicilio.asentamiento ?? '';
    _cpController.text = usuario!.domicilio.codigop?.toString() ?? '';
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
                controller: _numeroextController,
                decoration: InputDecoration(labelText: 'Número ext.'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese el número exterior' : null,
                enabled: editable,
              ),
              TextFormField(
                controller: _numerointController,
                decoration: InputDecoration(labelText: 'Número int.'),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese el número exterior' : null,
                enabled: editable,
              ),
              TextFormField(
                controller: _asentamientoController,
                decoration: InputDecoration(labelText: 'Asentamiento'),
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
                        Provider.of<UsuarioProvider>(context, listen: false).actualizarDomicilio(_calleController.text, int.parse(_numeroextController.text), int.parse(_numerointController.text), _asentamientoController.text, int.parse(_cpController.text));
                        _guardarDomicilio(usuario.id,_calleController.text,int.parse(_numeroextController.text), int.parse(_numerointController.text), _asentamientoController.text, int.parse(_cpController.text));
                        
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