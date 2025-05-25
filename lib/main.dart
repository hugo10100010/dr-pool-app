import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'providers/usuario_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UsuarioProvider())],
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
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: Center(
              child: Text('404: Not found'),
            ),
          ),
        );
      },
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: const Color.fromARGB(255, 255, 90, 90),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          tertiary: Colors.deepPurple,
          onTertiary: Colors.white,
          error: Colors.yellow,
          onError: Colors.blue,
          surface: Color.fromARGB(255, 30, 30, 30),//color de fondo
          onSurface: const Color.fromARGB(255, 255, 255, 255),//color de texto superior
          primaryContainer: Color(0xFFbf6370),
          onPrimaryContainer: Colors.black,
          secondaryContainer: Colors.black,
          onSecondaryContainer: Colors.white,
        ),
        textTheme: TextTheme(
          displayMedium: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 48,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 22,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 18,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 90, 90),
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          floatingLabelStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Color.fromARGB(127, 255, 255, 255),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.white, width: 3.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(width: 5.0),
          ),
        ),
        splashColor: Colors.white.withAlpha(64),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFed6464),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.white,
        ),
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: Color(0xffffabcf),
          collapsedBackgroundColor: Color(0xffffabcf),
          collapsedShape: Border.all(
            width: 2,
            color: Colors.black,
          ),
          shape: Border.all(
            width: 2,
            color: Colors.black,
          ),
          expandedAlignment: Alignment.topCenter,
        ),
      ),
    );
  }
}