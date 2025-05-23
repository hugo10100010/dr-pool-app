import 'package:flutter/material.dart';

class ContratarPage extends StatefulWidget {
  @override
  State<ContratarPage> createState() => _ContratarPageState();
}

class _ContratarPageState extends State<ContratarPage> {
  final List<Map<String, dynamic>> paquetes = [
    {
      'titulo': 'Básico',
      'precio': '\$99.90/mes',
      'beneficios': ['2 Clases', 'Rutinas Predeterminadas'],
    },
    {
      'titulo': 'Estándar',
      'precio': '\$199.90/mes',
      'beneficios': ['4 Clases', 'Rutinas Personalizadas', 'Coach Personal'],
    },
    {
      'titulo': 'Premium',
      'precio': '\$299.90/mes',
      'beneficios': [
        'Clases ilimitadas',
        'Rutinas Personalizadas',
        'Coach Personal',
        'Invitaciones a 4 amigos por mes'
      ],
    },
  ];

  Map<String, dynamic>? paqueteSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contratar suscripción')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<Map<String, dynamic>>(
              hint: Text('Selecciona un paquete'),
              value: paqueteSeleccionado,
              isExpanded: true,
              items: paquetes.map((paquete) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: paquete,
                  child: Text('${paquete['titulo']} - ${paquete['precio']}'),
                );
              }).toList(),
              onChanged: (nuevoPaquete) {
                setState(() {
                  paqueteSeleccionado = nuevoPaquete;
                });
              },
            ),
            SizedBox(height: 20),
            if (paqueteSeleccionado != null) ...[
              Text(
                'Beneficios:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ...List.generate(
                paqueteSeleccionado!['beneficios'].length,
                (i) => Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 20),
                    SizedBox(width: 6),
                    Text(paqueteSeleccionado!['beneficios'][i]),
                  ],
                ),
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
                          arguments: paqueteSeleccionado,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Selecciona un paquete para continuar')),
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
  }
}
