import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                      style:
                          TextStyle(fontSize: 46.1, fontFamily: 'Poppins Medium',),
                    ),
                    Text(
                      "Cuenta",
                      style:
                          TextStyle(fontSize: 46.1, fontFamily: 'Poppins Medium',),
                    ),
                  ],
                ),
                Text(
                  "¿Ya está registrado? Iniciar Sesión",
                  style: TextStyle(
                      fontSize: 10.5,
                      fontFamily: "DM Sans",
                      color: Colors.white),
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
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
