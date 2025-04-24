import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'providers/usuario_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_)=>UsuarioProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) {
        final routes = AppRoutes.getRoutes(settings);
        final builder = routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed:() {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back),),
            ),
            body: Center(
              child: Text('404: Not found'),
            ),
          ),
        );
      },
    );
  }
}
