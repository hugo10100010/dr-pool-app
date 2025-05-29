import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/screens/admin/pages/casillas/casillashorario_page.dart';
import 'package:proyecto/screens/admin/pages/clases/clases_page.dart';
import 'package:proyecto/screens/admin/pages/cursos/cursos_page.dart';
import 'package:proyecto/screens/admin/pages/home_page.dart';
import 'package:proyecto/screens/admin/pages/paquetes/paquetes_page.dart';
import 'package:proyecto/screens/admin/pages/usuarios/usuarios_page.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
    final _pages = [
      AdminHome(),
      UsuariosPage(),
      PaquetesPage(),
      CasillashorarioPage(),
      ClasesPage(),
      CursosPage(),
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
      ListTile(leading: Icon(Icons.person),title: Text('Usuarios'),onTap: () => _onSelectPage(1),),
      ListTile(leading: Icon(Icons.abc),title: Text('Paquetes'),onTap: () => _onSelectPage(2),),
      ListTile(leading: Icon(Icons.calendar_month),title: Text('Casillas de horario'),onTap: () => _onSelectPage(3),),
      ListTile(leading: Icon(Icons.schedule),title: Text('Clases'),onTap: () => _onSelectPage(4),),
      ListTile(leading: Icon(Icons.golf_course),title: Text('Cursos'),onTap: () => _onSelectPage(5),),
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
        title: Text("Administrador"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: usuario != null ? Text(usuario.cuenta!.nombreusu) : Text(""),
              accountEmail: usuario != null ? Text(usuario.personales.email) : Text(""),
              currentAccountPicture: usuario != null ? CircleAvatar(
                backgroundImage: usuario.cuenta?.avatar != null ? MemoryImage(usuario.cuenta!.avatar!) : AssetImage('assets/avatar.gif') as ImageProvider,
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
