import 'package:flutter/material.dart';
import 'package:proyecto/services/usuario_service.dart';

class Agregar extends StatefulWidget {
  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  final _pageController = PageController();

  // Controllers for personal data
  final _nombreController = TextEditingController();

  final _apellidopController = TextEditingController();

  final _apellidomController = TextEditingController();

  final _emailController = TextEditingController();

  final _telefonoController = TextEditingController();

  final _tipodocumentoController = TextEditingController();

  final _documentoController = TextEditingController();

  // Controllers for account data
  final _nombreusuController = TextEditingController();

  final _passwordController = TextEditingController();

  // Controllers for address data
  final _calleController = TextEditingController();

  final _numextController = TextEditingController();

  final _numintController = TextEditingController();

  final _asentamientoController = TextEditingController();

  final _codigopController = TextEditingController();

  final _tipousuarioController = TextEditingController();

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });
    } else {
      _submitForm();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });
    }
  }

  Future<void> _submitForm() async {
    final data = {
      "personales": {
        "nombre": _nombreController.text,
        "apellidop": _apellidopController.text,
        "apellidom": _apellidomController.text,
        "email": _emailController.text,
        "telefono": _telefonoController.text,
        "tipodocumento": _tipodocumentoController.text,
        "documento": _documentoController.text
      },
      "cuenta": {
        "nombreusu": _nombreusuController.text,
        "password": _passwordController.text,
      },
      "domicilio": {
        "calle": _calleController.text,
        "numext": int.parse(_numextController.text),
        "numint": int.parse(_numintController.text),
        "asentamiento": _asentamientoController.text,
        "codigop": _codigopController.text
      },
      "tipousuario": int.parse(_tipousuarioController.text)
    };
    var resultado = await UsuarioService().agregarUsuario(data);
    if (resultado) {
      Navigator.pop(context, "El usuario fue agregado.");
    } else {
      Navigator.pop(context, "Algo falló al agregar el usuario.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildPersonalForm(),
                    _buildAccountForm(),
                    _buildAddressForm(),
                    _buildTipoUsuarioForm(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPage > 0)
              ElevatedButton(onPressed: _prevPage, child: Text("Back")),
            ElevatedButton(
              onPressed: _nextPage,
              child: Text(_currentPage < 3 ? "Next" : "Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: "Nombre")),
          TextField(
              controller: _apellidopController,
              decoration: InputDecoration(labelText: "Apellido paterno")),
          TextField(
              controller: _apellidomController,
              decoration: InputDecoration(labelText: "Apellido materno")),
          TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email")),
          TextField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: "Telefono")),
          TextField(
              controller: _tipodocumentoController,
              decoration: InputDecoration(labelText: "Tipo documento")),
          TextField(
              controller: _documentoController,
              decoration: InputDecoration(labelText: "Documento")),
        ],
      ),
    );
  }

  Widget _buildAccountForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
              controller: _nombreusuController,
              decoration: InputDecoration(labelText: "Usuario")),
          TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true),
        ],
      ),
    );
  }

  Widget _buildAddressForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
              controller: _calleController,
              decoration: InputDecoration(labelText: "Calle")),
          TextField(
              controller: _numextController,
              decoration: InputDecoration(labelText: "Num. ext.")),
          TextField(
              controller: _numintController,
              decoration: InputDecoration(labelText: "Num. int.")),
          TextField(
              controller: _asentamientoController,
              decoration: InputDecoration(labelText: "Asentamiento")),
          TextField(
              controller: _codigopController,
              decoration: InputDecoration(labelText: "Codigo postal")),
        ],
      ),
    );
  }

  Widget _buildTipoUsuarioForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _tipousuarioController,
            decoration: InputDecoration(labelText: "Tipo de usuario"),
          ),
        ],
      ),
    );
  }
}
