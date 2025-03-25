import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFed6464),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 46.1, fontFamily: 'Poppins Medium'),
              ),
              Text(
                "Ingrese para continuar",
                style: TextStyle(
                    fontSize: 10.5, fontFamily: "DM Sans", color: Colors.white),
              ),
              Container(
                width: 225,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(45.0),
                    color: Color(0xFFbf6370)),
                padding: EdgeInsets.fromLTRB(20, 50, 20, 80),
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  spacing: 20,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(127, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins Light",
                          fontSize: 11),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(127, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins Light",
                          fontSize: 11),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UI(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black),
                      child: Text('Ingresar'),
                    ),
                    Column(
                      spacing: 2.0,
                      children: [
                        Text(
                          "¿Tiene una cuenta?",
                          style: TextStyle(color: Colors.white),
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
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
      backgroundColor: Color(0xFFed6464),
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
                    style: TextStyle(
                      fontSize: 46.1,
                      fontFamily: 'Poppins Medium',
                    ),
                  ),
                  Text(
                    "Cuenta",
                    style: TextStyle(
                      fontSize: 46.1,
                      fontFamily: 'Poppins Medium',
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "¿Ya está registrado? Iniciar Sesión",
                  style: TextStyle(
                      fontSize: 10.5,
                      fontFamily: "DM Sans",
                      color: Colors.white),
                ),
              ),
              Container(
                width: 225,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(45.0),
                    color: Color(0xFFbf6370)),
                padding: EdgeInsets.fromLTRB(20, 50, 20, 80),
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  spacing: 20,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(127, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins Light",
                          fontSize: 11),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(127, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins Light",
                          fontSize: 11),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(127, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins Light",
                          fontSize: 11),
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Fecha de nacimiento',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(127, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins Light",
                          fontSize: 11),
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black),
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
      backgroundColor: Color(0xFFed6464),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.circle_notifications_rounded),
      label: "Clases",
      backgroundColor: Color(0xFFed6464),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: "Inicio",
      backgroundColor: Color(0xFFed6464),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money_rounded),
      label: "Pagos",
      backgroundColor: Color(0xffed6464),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_rounded),
      label: "Acerca de",
      backgroundColor: Color(0xFFed6464),
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
      backgroundColor: Color(0xFFed6464),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
          child: pages[selectedTab]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFed6464),
        showUnselectedLabels: true,
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
                    TextoNormal(
                      text: "Bienvenido a",
                      fontSize: 16.5,
                      textAlign: TextAlign.end,
                    ),
                    TextoNormal(
                      text: "Smart Fit",
                      fontSize: 16.5,
                      textAlign: TextAlign.end,
                    ),
                    TextoNormal(
                      text: "Entrena tu vida",
                      fontSize: 7.4,
                      textAlign: TextAlign.end,
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
          child: TextoNormal(
            text: "Novedades",
            fontSize: 16,
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
                  child: TextoNormal(
                    text: "Paquetes",
                    fontSize: 18,
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
                child: TextoNormal(text: "Historial de subscripciones: "),
              ),
              HistorialTile(specifications: [Text('data')])
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
                color: Color(0xffc1a2c5),
                child: TextoNormal(text: "Datos de cobro: "),
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
                    TextoNormal(
                      text: "Tarjeta registrada: ",
                      fontSize: 12,
                    ),
                    TextoNormal(
                      text: "No. de tarjeta: ",
                      fontSize: 12,
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
          child: TextoNormal(
            text: "Acerca de nosotros",
          ),
        ),
        CustomContainer(
          boxHeight: 100,
          child: TextoNormal(text: "Sede central"),
        ),
        CustomContainer(
          boxHeight: 120,
          child: TextoNormal(text: "Contáctenos"),
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
            child: TextoNormal(
              text: "División de",
              fontSize: 18,
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: TextoNormal(
              text: "Entrenamiento:",
              fontSize: 18,
            ),
          ),
          ...division,
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: TextoNormal(
              text: "División sugerida:",
              fontSize: 18,
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
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
  });

  final String text;
  final String fontFamily;
  final double fontSize;
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
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: TextoNormal(
              text: "Fecha",
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextoNormal(
              text: "Monto \$",
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
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Text('data'),
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
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Text('data'),
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
        color: Color(0xFFc1a2c5),
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
