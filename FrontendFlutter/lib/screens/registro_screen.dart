import 'package:flutter/material.dart';
import 'package:proyecto/services/usuario_service.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _pageController = PageController();

  // Controllers info personal
  final _nombreController = TextEditingController();
  final _apellidopController = TextEditingController();
  final _apellidomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _tipodocumentoController = TextEditingController();
  final _documentoController = TextEditingController();

  // Controllers para la cuenta
  final _nombreusuController = TextEditingController();
  final _passwordController = TextEditingController();

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
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
      "tipousuario": 2,
    };
    var resultado = await UsuarioService().registrarUsuario(data);
    if (resultado) {
      Navigator.pop(context, "El usuario fue agregado.");
    } else {
      Navigator.pop(context, "Algo falló al agregar el usuario.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildPersonalForm(),
          _buildAccountForm(),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(onPressed: _prevPage, child: Text("Back")),
          TextButton(
            onPressed: _nextPage,
            child: Text(_currentPage < 1 ? "Next" : "Submit"),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalForm() {
    return Padding(
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
    return Padding(
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
}
