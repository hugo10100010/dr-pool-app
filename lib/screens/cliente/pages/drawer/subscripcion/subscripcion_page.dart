import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/providers/usuario_provider.dart';

class SubscripcionPage extends StatefulWidget {
  @override
  State<SubscripcionPage> createState() => _SubscripcionPageState();
}

class _SubscripcionPageState extends State<SubscripcionPage> {
  // Simulación de datos
  bool mostrarBeneficios = false;

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    if(usuario==null) {
      return Center(child: Text("Nada que ver aquí..."),);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Suscripción')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Botón grande con info de la suscripción actual
              GestureDetector(
                onTap: () {
                  setState(() {
                    mostrarBeneficios = !mostrarBeneficios;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: usuario!.subscripcion!.paquete == null
                        ? Colors.grey
                        : usuario!.subscripcion!.estado != "Activa"
                            ? Colors.grey
                            : usuario!.subscripcion!.paquete!.clases == 2
                                ? Colors.green
                                : usuario.subscripcion!.paquete!.clases == 3
                                    ? Colors.amber
                                    : usuario.subscripcion!.paquete!.clases >= 4
                                        ? const Color.fromARGB(255, 255, 90, 90)
                                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suscripción actual',
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Vigencia: ${usuario.subscripcion!.fechaini.year}/${usuario.subscripcion!.fechaini.month}/${usuario.subscripcion!.fechaini.day} - ${usuario.subscripcion!.fechafin.year}/${usuario.subscripcion!.fechafin.month}/${usuario.subscripcion!.fechafin.day}",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${usuario.subscripcion?.paquete?.precio.toString() ?? "N/A"}",
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 40, 40, 40)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        usuario.subscripcion!.estado,
                        style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 40, 40, 40)),
                      ),
                      AnimatedCrossFade(
                        firstChild: SizedBox.shrink(),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text('Beneficios:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(
                                    usuario.subscripcion!.paquete == null
                                        ? Icons.question_mark
                                        : Icons.check,
                                    color: usuario.subscripcion!.paquete == null
                                        ? Colors.yellow
                                        : Colors.green,
                                    size: 20),
                                SizedBox(width: 6),
                                Text(usuario.subscripcion!.paquete == null
                                    ? "N/A"
                                    : "${usuario.subscripcion!.paquete!.clases} clases"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                    usuario.subscripcion!.paquete == null
                                        ? Icons.question_mark
                                        : usuario
                                                .subscripcion!.paquete!.flexible
                                            ? Icons.check
                                            : Icons.close,
                                    color: usuario.subscripcion!.paquete == null
                                        ? Colors.yellow
                                        : usuario
                                                .subscripcion!.paquete!.flexible
                                            ? Colors.green
                                            : Colors.red,
                                    size: 20),
                                SizedBox(width: 6),
                                Text("Flexible"),
                              ],
                            ),
                          ],
                        ),
                        crossFadeState: mostrarBeneficios
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 350),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              // Historial de suscripciones
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Historial de suscripciones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12),
              ...usuario.historial!
                  .map((item) => Card(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text(
                              "${item.paquete.clases} clases - ${item.paquete.flexible ? "Flexible" : "No flexible"}"),
                          subtitle: Text(
                              "${item.fechaini.year}/${item.fechaini.month}/${item.fechaini.day} - ${item.fechafin.year}/${item.fechafin.month}/${item.fechafin.day}"),
                          trailing: Text("\$${item.paquete.precio}"),
                        ),
                      ))
                  .toList(),
              SizedBox(height: 40),
              // Botón grande de contratar
              Center(
                child: SizedBox(
                  width: 250,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Redirige a la ventana de contratación
                      Navigator.pushNamed(context, '/contratar');
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      backgroundColor: const Color.fromARGB(255, 255, 90, 90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Contratar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
