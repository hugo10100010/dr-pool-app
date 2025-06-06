import 'package:flutter/material.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/screens/cliente/pages/inicio/inicio_page.dart';
import 'package:proyecto/screens/cliente/pages/horario/horario_page.dart';
import 'package:proyecto/screens/cliente/pages/acercade/acercade_page.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/helpers/avatar_manager.dart';

class ClienteHomePage extends StatefulWidget {
  @override
  State<ClienteHomePage> createState() => _ClienteHomePageState();
}

class _ClienteHomePageState extends State<ClienteHomePage> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: "Inicio",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time_filled_rounded),
      label: "Horario",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_rounded),
      label: "Acerca de",
    ),
  ];

  List<Widget> tiles = [
    ListTile(
      title: Text("Datos personales"),
      leading: Icon(Icons.person),
      onTap: () {},
    ),
    ListTile(
      title: Text('Datos domiciliados'),
      leading: Icon(Icons.home_work),
      onTap: () {},
    ),
    ListTile(
      title: Text("Subscripción"),
      leading: Icon(Icons.subscriptions),
      onTap: () {},
    )
  ];

  List<Widget> pages = [Inicio(), Horario(), AcercaDe()];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    final tabs = [
      ListTile(
        leading: Icon(Icons.account_box),
        title: Text('Cuenta'),
        onTap: () => Navigator.pushNamed(context, AppRoutes.cuentacliente),
      ),
      ListTile(
        leading: Icon(Icons.person_add),
        title: Text('Datos personales'),
        onTap: () => Navigator.pushNamed(context, AppRoutes.personalescliente),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Datos domiciliados'),
        onTap: () => Navigator.pushNamed(context, AppRoutes.domiciliocliente),
      ),
      ListTile(
        leading: Icon(Icons.abc),
        title: Text('Metricas'),
        onTap: () => Navigator.pushNamed(context, AppRoutes.metricascliente),
      ),
      ListTile(
        leading: Icon(Icons.subscriptions),
        title: Text('Subscripción'),
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.subscripcioncliente),
      ),
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
        title: Text(items[selectedTab].label!),
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
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
          child: pages[selectedTab]),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
      ),
    );
  }
}
