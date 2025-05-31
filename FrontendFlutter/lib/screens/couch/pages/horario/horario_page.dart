import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';

class HorarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horario Clases de Ejercicio',
      home: HorarioClases(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HorarioClases extends StatelessWidget {
  final List<int> dias = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    if (usuario == null) {
      return Center(
        child: Text("Nada que ver aquí..."),
      );
    }
    usuario.clases!
        .sort((a, b) => a.casilla.horaini.compareTo(b.casilla.horaini));

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Horario Clases de Ejercicio',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Container(
              color: const Color.fromARGB(255, 223, 2, 2),
              child: TabBar(
                isScrollable: false,
                tabs: dias.map((dia) {
                  return Tab(
                    child: Center(
                      child: MediaQuery.of(context).size.width > 600
                          ? Text(
                              dia == 1
                                  ? "Lunes"
                                  : dia == 2
                                      ? "Martes"
                                      : dia == 3
                                          ? "Miercoles"
                                          : dia == 4
                                              ? "Jueves"
                                              : dia == 5
                                                  ? "Viernes"
                                                  : dia == 6
                                                      ? "Sábado"
                                                      : dia == 7
                                                          ? "Domingo"
                                                          : "No",
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              dia == 1
                                  ? "L"
                                  : dia == 2
                                      ? "M"
                                      : dia == 3
                                          ? "M"
                                          : dia == 4
                                              ? "J"
                                              : dia == 5
                                                  ? "V"
                                                  : dia == 6
                                                      ? "S"
                                                      : dia == 7
                                                          ? "D"
                                                          : "No",
                              textAlign: TextAlign.center,
                            ),
                    ),
                  );
                }).toList(),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[400],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: TabBarView(
          children: dias.map((dia) {
            final clasesDelDia =
                usuario.clases!.where((e) => e.casilla.dia == dia).toList();
            return ListView.builder(
              itemCount:
                  usuario.clases!.where((e) => e.casilla.dia == dia).length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        clasesDelDia[index].casilla.horaini,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        clasesDelDia[index].curso.curso,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
