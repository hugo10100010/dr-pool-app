import 'package:flutter/material.dart';

class SubscripcionPage extends StatefulWidget {
  @override
  State<SubscripcionPage> createState() => _SubscripcionPageState();
}

class _SubscripcionPageState extends State<SubscripcionPage> {
  // Simulación de datos
  final Map<String, dynamic> suscripcionActual = {
    'titulo': 'Estándar',
      'precio': '\$199.90/mes',
      'beneficios': ['4 Clases', 'Rutinas Personalizadas', 'Coach Personal'],
    'color': Colors.green[100],
  };

  final List<Map<String, dynamic>> historial = [
    {
      'titulo': 'Básico',
      'fecha': '01/2023 - 06/2023',
      'precio': '\$99.90/mes',
    },
    {
      'titulo': 'Estándar',
      'fecha': '07/2023 - Actual',
      'precio': '\$199.90/mes',
    },
  ];

  bool mostrarBeneficios = false;

  @override
  Widget build(BuildContext context) {
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
                    color: suscripcionActual['color'],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suscripción actual',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        suscripcionActual['titulo'],
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        suscripcionActual['precio'],
                        style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                      ),
                      AnimatedCrossFade(
                        firstChild: SizedBox.shrink(),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text('Beneficios:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ...suscripcionActual['beneficios']
                                .map<Widget>((b) => Row(
                                      children: [
                                        Icon(Icons.check,
                                            color: Colors.green, size: 20),
                                        SizedBox(width: 6),
                                        Text(b),
                                      ],
                                    )),
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
              ...historial.map((item) => Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text(item['titulo']),
                      subtitle: Text(item['fecha']),
                      trailing: Text(item['precio']),
                    ),
                  )),
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
                      backgroundColor: Colors.blue,
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