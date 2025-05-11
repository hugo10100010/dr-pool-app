import 'package:flutter/material.dart';

class CuentaPage extends StatefulWidget {
  @override
  State<CuentaPage> createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  final TextEditingController _nombreUsuController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  _nombreUsuController.text="OAS";
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
                    icon: Icon(Icons.person),
                    labelText: 'Nombre de usuario'
                  ),
                  validator:(value) {
                    if(value==null || value.isEmpty) {
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
                child: TextFormField(
                  enabled: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Contraseña'
                  ),
                  validator:(value) {
                    if(value==null || value.isEmpty) {
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
                child: TextFormField(
                  enabled: true,
                  controller: _nombreUsuController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Nombre de usuario'
                  ),
                  validator:(value) {
                    if(value==null || value.isEmpty) {
                      return 'El campo es obligatorio';
                    }
                    return null;
                  },  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
