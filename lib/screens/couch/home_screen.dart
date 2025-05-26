import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/screens/cliente/pages/drawer/cuenta/cuenta_page.dart';
import 'package:proyecto/screens/couch/pages/home_page.dart';
import 'package:proyecto/screens/couch/pages/horario/horario_page.dart';
import 'package:proyecto/screens/couch/pages/clases/clases_page.dart';
import 'package:proyecto/screens/couch/pages/misdatos/misdatos_page.dart';
import 'package:proyecto/screens/couch/pages/misdatos/midomicilio_page.dart';

class CouchHomePage extends StatefulWidget {
  @override
  State<CouchHomePage> createState() => _CouchHomePageState();
}

class _CouchHomePageState extends State<CouchHomePage> {
    final _pages = [
      CoucheHome(),
      ClasesPage(),
      HorarioPage(),
      CuentaPage(),
      MisdatosPage(),
      Midomicilio(),
    ];

    int _selectedIndex = 0;

    void _onSelectPage(int index) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pop(context);
    }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    final tabs = [
      ListTile(leading: Icon(Icons.home),title: Text('Inicio'),onTap: ()=>_onSelectPage(0),),
      ListTile(leading: Icon(Icons.schedule),title: Text('Clases'),onTap: () => _onSelectPage(1),),
      ListTile(leading: Icon(Icons.schedule),title: Text('Horario'),onTap: () => _onSelectPage(2),),
      ListTile(leading: Icon(Icons.account_box),title: Text('Cuenta'),onTap: () => _onSelectPage(3),),
      ListTile(leading: Icon(Icons.person_add),title: Text('Datos personales'),onTap: ()=> _onSelectPage(4),),
      ListTile(leading: Icon(Icons.home),title: Text('Datos domiciliados'),onTap: () => _onSelectPage(5),),
      ListTile(leading: Icon(Icons.turn_right),title: Text('Cerrar sesión'),onTap: () async {
        final storage = FlutterSecureStorage();
        await storage.delete(key: "proyectom_access_token");
        await storage.delete(key: "proyectom_refresh_token");
        final usuarioProvider = Provider.of<UsuarioProvider>(context,listen: false);
        usuarioProvider.logout();
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      },)
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ),
        title: Text("Couche"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: usuario != null ? Text(usuario.cuenta.nombreusu) : Text(""),
              accountEmail: usuario != null ? Text(usuario.personales.email) : Text(""),
              currentAccountPicture: usuario != null ? CircleAvatar(
                backgroundImage: usuario.cuenta.avatar != null ? MemoryImage(usuario.cuenta.avatar!) : AssetImage('assets/avatar.gif') as ImageProvider,
              ) : null,
            ),
            ...tabs
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
