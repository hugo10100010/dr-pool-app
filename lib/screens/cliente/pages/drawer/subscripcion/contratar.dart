import 'package:flutter/material.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/services/paquete_service.dart';

class ContratarPage extends StatefulWidget {
  @override
  State<ContratarPage> createState() => _ContratarPageState();
}

class _ContratarPageState extends State<ContratarPage> {
  final Future<List<Paquete>> paquetesLista = PaqueteService().getPaquetes();

  Paquete? paqueteSeleccionado;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([paquetesLista]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        final listaPaquetes = snapshot.data![0];

        final paquetesItems = listaPaquetes
            .map<DropdownMenuItem<Paquete>>((e) =>
                DropdownMenuItem(value: e, child: Text("Paquete ${e.id}")))
            .toList();

        return Scaffold(
          appBar: AppBar(title: Text('Contratar suscripción')),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton(
                  hint: Text('Selecciona un paquete'),
                  value: paqueteSeleccionado,
                  isExpanded: true,
                  items: paquetesItems,
                  onChanged: (nuevoPaquete) {
                    setState(() {
                      paqueteSeleccionado = nuevoPaquete;
                    });
                  },
                ),
                SizedBox(height: 20),
                if (paqueteSeleccionado != null) ...[
                  Text(
                    'Precio: \$${paqueteSeleccionado!.precio}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 12,),
                  Text(
                    'Beneficios:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Icon(Icons.check, color: Colors.green, size: 20),
                      SizedBox(width: 6),
                      Text("${paqueteSeleccionado!.clases} clases"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                          paqueteSeleccionado!.flexible
                              ? Icons.check
                              : Icons.close,
                          color: paqueteSeleccionado!.flexible
                              ? Colors.green
                              : Colors.red,
                          size: 20),
                      SizedBox(width: 6),
                      Text("Flexible"),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (paqueteSeleccionado != null) {
                            Navigator.pushNamed(
                              context,
                              '/horarios',
                              arguments: {
                                "id": paqueteSeleccionado!.id,
                                "precio": paqueteSeleccionado!.precio.toString(),
                                "clases": paqueteSeleccionado!.clases.toString(),
                                "flexible": paqueteSeleccionado!.flexible.toString(),
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Selecciona un paquete para continuar')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Seleccionar'),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
