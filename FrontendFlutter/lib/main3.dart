import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/services/usuario_service.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.pinkAccent,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          tertiary: Colors.deepPurple,
          onTertiary: Colors.white,
          error: Colors.yellow,
          onError: Colors.blue,
          surface: Color(0xFFed6464),
          onSurface: Colors.black,
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
            backgroundColor: Colors.greenAccent,
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
          filled: true,
          fillColor: Color.fromARGB(127, 255, 255, 255),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide()),
        ),
        splashColor: Colors.white.withAlpha(64),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFFed6464),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.greenAccent,
            unselectedItemColor: Colors.white),
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

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

Future<List<dynamic>> fetchUsuarios() async {
  final response = await http.get(Uri.parse("http://127.0.0.1:5000/usuario/"));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load usuario');
  }
}

class _LoginState extends State<Login> {
  final service = UsuarioService();
  late Future<List<dynamic>> futureUsuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUsuario = fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Ingrese para continuar",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Container(
                width: 225,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(45.0),
                ),
                padding: EdgeInsets.fromLTRB(20, 50, 20, 80),
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  spacing: 20,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UI(),
                            ));*/
                        print(service.login({"username":_usernameController.value.text,"password":_passwordController.value.text}).then((value) => {print(value)}));
                      },
                      child: Text('Ingresar'),
                    ),
                    Column(
                      spacing: 2.0,
                      children: [
                        Text(
                          "¿Tiene una cuenta?",
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registrar(),
                              ),
                            );
                          },
                          child: Text(
                            "Registrarse",
                          ),
                        ),
                        Container(
                          height: 100,
                          child: FutureBuilder<List<dynamic>>(
                            future: futureUsuario,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                  return ListTile(
                                    
                                    title: Text(snapshot.data![index]["nombre"],style: TextStyle(fontSize: 10),),
                                  );
                                });
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  TextEditingController _textEditingController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                spacing: 2.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Crear Nueva",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    "Cuenta",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "¿Ya está registrado? Iniciar Sesión",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Container(
                width: 225,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(45.0),
                ),
                padding: EdgeInsets.fromLTRB(20, 50, 20, 80),
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  spacing: 20,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Fecha de nacimiento',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      cursorColor: Colors.white,
                      style: Theme.of(context).textTheme.bodySmall,
                      onTap: () async {
                        selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year + 1),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                                data: ThemeData.light(), child: child!);
                          },
                        );
                        setState(() {
                          if (selectedDate == null) {
                            _textEditingController.text = "";
                          } else {
                            _textEditingController.text =
                                "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
                          }
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {/* */},
                      child: Text('Crear'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UI extends StatefulWidget {
  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time_filled_rounded),
      label: "Horario",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.circle_notifications_rounded),
      label: "Clases",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: "Inicio",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money_rounded),
      label: "Pagos",
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

  List<Widget> pages = [Horario(), Clases(), Inicio(), Pagos(), AcercaDe()];

  int selectedTab = 2;

  @override
  Widget build(BuildContext context) {
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
              accountName: Text('Komori-chan'),
              accountEmail: Text('21690116@tecvalles.mx'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.gif'),
              ),
            ),
            ...tiles
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

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Image.asset(
                  "assets/inicio_1.jpg",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Bienvenido a",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Smart Fit",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Entrena tu vida",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: (Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize! *
                              (4 / 7))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 5, 3, 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
            gradient: RadialGradient(
              colors: [
                Color(0xFF75ff52),
                Color(0xFF00a06a),
              ],
              center: Alignment.center,
              radius: 4.2,
            ),
          ),
          child: Text(
            "Novedades",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                  ImageContainerInicio(
                    image: AssetImage('assets/inicio_2.jpg'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Horario extends StatefulWidget {
  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;

  final List<String> days = ["L", "M", "M", "J", "V", "S", "D"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> pages = [
    HorarioPage(
      division: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
      sugerencia: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
    ),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  List<Widget> pagesPrueba = List.generate(7, (index) {
    return HorarioPage(
      division: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
      sugerencia: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
    );
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxHeight: 500,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(days.length, (index) {
                    bool isSelected = index == _selectedIndex;
                    return GestureDetector(
                      onTap: () => _tabController.animateTo(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 11),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.pink[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Text(
                          days[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: pagesPrueba,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Clases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxPadding: EdgeInsets.fromLTRB(10, 20, 10, 30),
          boxHeight: 500,
          child: SingleChildScrollView(
            child: Column(
              spacing: 5,
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Paquetes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Pagos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxHeight: 300,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Historial de subscripciones ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              HistorialTile(specifications: [
                Text(
                  'data',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ])
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        CustomContainer(
          boxHeight: 200,
          boxPadding: EdgeInsets.all(0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 33,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Datos de cobro",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 5, 3, 5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Tarjeta registrada: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "No. de tarjeta: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        CustomContainer(
          boxHeight: 150,
          child: Text(
            "Acerca de nosotros",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        CustomContainer(
          boxHeight: 100,
          child: Text(
            "Sede central",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        CustomContainer(
          boxHeight: 120,
          child: Text(
            "Contáctenos",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}

class HorarioPage extends StatelessWidget {
  const HorarioPage({
    super.key,
    required this.division,
    required this.sugerencia,
  });

  final List<TrainingTile> division;
  final List<TrainingTile> sugerencia;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 5,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "División de",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "Entrenamiento: ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ...division,
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "División sugerida:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ...sugerencia,
        ],
      ),
    );
  }
}

class TextoNormal extends StatelessWidget {
  const TextoNormal({
    super.key,
    required this.text,
    this.fontFamily = "Montserrat",
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
  });

  final String text;
  final String fontFamily;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}

class HistorialTile extends StatelessWidget {
  const HistorialTile({
    super.key,
    required this.specifications,
  });

  final List<Widget> specifications;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      shape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "Fecha",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Monto \$",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
      children: [...specifications],
    );
  }
}

class ClassTile extends StatelessWidget {
  const ClassTile({
    super.key,
    required this.specifications,
  });

  final List<Widget> specifications;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      shape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Text(
        'data',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: specifications,
        ),
      ],
    );
  }
}

class TrainingTile extends StatelessWidget {
  const TrainingTile({
    super.key,
    required this.specifications,
  });

  final List<Widget> specifications;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      shape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Text(
        "data",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: specifications,
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.boxPadding = const EdgeInsets.fromLTRB(10, 5, 3, 5),
    this.boxMargin,
    this.alignContent,
    this.boxBgColor = const Color(0xFFbf6370),
    this.boxHeight,
    this.boxWidth = double.infinity,
  });

  final Widget child;
  final double? boxWidth;
  final double? boxHeight;
  final EdgeInsetsGeometry? boxPadding;
  final EdgeInsetsGeometry? boxMargin;
  final AlignmentGeometry? alignContent;
  final Color boxBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight,
      alignment: alignContent,
      padding: boxPadding,
      margin: boxMargin,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: boxBgColor,
      ),
      child: child,
    );
  }
}

class ImageContainerInicio extends StatelessWidget {
  const ImageContainerInicio({
    super.key,
    this.boxMargin = 5.0,
    this.boxPadding = const EdgeInsets.fromLTRB(5, 5, 5, 10),
    this.boxSpacing = 5,
    this.externalBorderWidth = 2.0,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.imageBorderWidth = 2.0,
    required this.image,
  });

  final double boxMargin;
  final EdgeInsetsGeometry? boxPadding;
  final double boxSpacing;
  final double externalBorderWidth;
  final double imageWidth;
  final double imageHeight;
  final double imageBorderWidth;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: boxPadding,
      decoration: BoxDecoration(
        border: Border.all(
          width: externalBorderWidth,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(boxMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: boxSpacing,
        children: [
          Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              border: Border.all(
                width: imageBorderWidth,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Leyenda',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 9,
            ),
          ),
          Text(
            '~',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
