import 'package:flutter/material.dart';

class CarritoPage extends StatelessWidget {
  final List<String> horarios;
  final Map<String, dynamic>? paquete;

  const CarritoPage({Key? key, required this.horarios, this.paquete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: horarios.isEmpty
            ? Center(child: Text('No hay clases en el carrito.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (paquete != null) ...[
                    Text(
                      'Paquete seleccionado:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    ListTile(
                      title: Text(paquete!['titulo'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(paquete!['precio'] ?? ''),
                          SizedBox(height: 4),
                          Text('Beneficios:', style: TextStyle(fontWeight: FontWeight.bold)),
                          ...((paquete!['beneficios'] as List<dynamic>? ?? []).map((b) => Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green, size: 18),
                                  SizedBox(width: 6),
                                  Text(b.toString()),
                                ],
                              ))),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                  Text(
                    'Horarios seleccionados:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: horarios.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.class_),
                            title: Text(
                              horarios[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Función de eliminar no implementada')),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: horarios.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('¡Listo!'),
                      content: Text('Tu suscripción ha sido registrada.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  ).then((_) {
    Navigator.pushReplacementNamed(context, '/subscripcioncliente');
  });
                },
                child: Text('Pagar'),
              ),
            )
          : null,
    );
  }
}