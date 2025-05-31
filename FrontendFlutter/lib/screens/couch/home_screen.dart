import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/helpers/avatar_manager.dart';
import 'package:proyecto/helpers/isonline_func.dart';
import 'package:proyecto/helpers/session_manager.dart';
import 'package:proyecto/helpers/sync_funcs.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/screens/couch/pages/home_page.dart';
import 'package:proyecto/screens/couch/pages/horario/horario_page.dart';
import 'package:proyecto/screens/couch/pages/clases/clases_page.dart';
import 'package:proyecto/services/connectivity_service.dart';

class CouchHomePage extends StatefulWidget {
  @override
  State<CouchHomePage> createState() => _CouchHomePageState();
}

class _CouchHomePageState extends State<CouchHomePage> {
  @override
  void initState() {
    super.initState();
    _initializeSyncAfterToken();
  }

  @override
  void dispose() {
    ConnectivityService().stopListening();
    super.dispose();
  }

  void _initSync() async {
    if (!(await isOnline())) {
      await coachCheckAndSync();
    }
  }

  void _initializeSyncAfterToken() async {
    await SessionManager().loadToken();
    _initSync();
    ConnectivityService().startListeningForConnection(
        () async => debouncedSync(coachCheckAndSync));
  }

  final _pages = [
    CoucheHome(),
    ClasesPage(),
    HorarioPage(),
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
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Inicio'),
        onTap: () => _onSelectPage(0),
      ),
      ListTile(
        leading: Icon(Icons.schedule),
        title: Text('Clases'),
        onTap: () => _onSelectPage(1),
      ),
      ListTile(
        leading: Icon(Icons.schedule),
        title: Text('Horario'),
        onTap: () => _onSelectPage(2),
      ),
      ListTile(
          leading: Icon(Icons.person_add),
          title: Text('Datos personales'),
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.personalescliente)),
      ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Cuenta'),
          onTap: () => Navigator.pushNamed(context, AppRoutes.cuentacliente)),
      ListTile(
          leading: Icon(Icons.home),
          title: Text('Datos domiciliados'),
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.domiciliocliente)),
      ListTile(
        leading: Icon(Icons.turn_right),
        title: Text('Cerrar sesión'),
        onTap: () async {
          final usuarioProvider =
              Provider.of<UsuarioProvider>(context, listen: false);
          usuarioProvider.logout();
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      ),
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
              accountName:
                  usuario != null ? Text(usuario.cuenta!.nombreusu) : Text(""),
              accountEmail:
                  usuario != null ? Text(usuario.personales!.email) : Text(""),
              currentAccountPicture: usuario != null
                  ? FutureBuilder(
                      future: getAvatarPath(usuario.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("fallo al cargar"),
                          );
                        }
                        final avatarPath = snapshot.data;
                        return CircleAvatar(
                          backgroundImage: getAvatar(avatarPath),
                        );
                      })
                  : null,
            ),
            ...tabs
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
