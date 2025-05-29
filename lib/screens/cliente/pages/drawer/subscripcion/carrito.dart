import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/routes/app_routes.dart';
import 'package:proyecto/services/usuario_service.dart';

class CarritoPage extends StatelessWidget {
  final List<Clase> clases;
  final Paquete? paquete;

  const CarritoPage({Key? key, required this.clases, this.paquete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Usuario usuario = Provider.of<UsuarioProvider>(context).usuario!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: clases.isEmpty
            ? Center(child: Text('No hay clases en el carrito.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (paquete != null) ...[
                    Text(
                      'Paquete seleccionado:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    ListTile(
                      title: Text("Paquete ${paquete!.id}" ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${paquete!.precio.toString()}" ?? ''),
                          SizedBox(height: 4),
                          Text('Beneficios:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Icon(Icons.check, color: Colors.green, size: 20),
                              SizedBox(width: 6),
                              Text("${paquete!.clases} clases"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                  paquete!.flexible ? Icons.check : Icons.close,
                                  color: paquete!.flexible
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20),
                              SizedBox(width: 6),
                              Text("Flexible"),
                            ],
                          ),
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
                      itemCount: clases.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.class_),
                            title: Text(
                              "${clases[index].casilla.dia == 1 ? "Lunes" : clases[index].casilla.dia == 2 ? "Martes" : clases[index].casilla.dia == 3 ? "Miercoles" : clases[index].casilla.dia == 4 ? "Jueves" : clases[index].casilla.dia == 5 ? "Viernes" : clases[index].casilla.dia == 6 ? "Sabado" : clases[index].casilla.dia == 7 ? "Domingo" : "Error"} - ${clases[index].casilla.horaini} a ${clases[index].casilla.horafin} - ${clases[index].curso.curso}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Función de eliminar no implementada')),
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
      bottomNavigationBar: clases.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  UsuarioService().modificarUsuario({
                    "id":usuario.id,
                    "subscripcion": {
                      "idpaquete": paquete?.id,
                    }
                  });
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
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.clientehome);
                  });
                },
                child: Text('Pagar'),
              ),
            )
          : null,
    );
  }
}
