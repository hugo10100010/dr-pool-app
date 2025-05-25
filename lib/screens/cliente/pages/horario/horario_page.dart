import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/usuario_provider.dart';

class Horario extends StatefulWidget {
  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> with SingleTickerProviderStateMixin {
  final List<int> dias = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    if(usuario==null) {
      return Center(child: Text("Nada que ver aquí..."),);
    }

    usuario!.horario!
        .sort((a, b) => a.clase.casilla.dia.compareTo(a.clase.casilla.dia));

    return DefaultTabController(
      length: dias.length,
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 255, 90, 90),
            child: TabBar(
              isScrollable: false,
              tabs: dias.map((dia) {
                return Tab(
                  child: Center(
                    child: Text(
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
                    ),
                  ),
                );
              }).toList(),
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              children: dias.map((dia) {
                final clasesDelDia =
                    usuario.horario!.where((e) => e.clase.casilla.dia == dia).toList();
                return ListView.builder(
                  itemCount:
                      usuario.horario!.where((e) => e.clase.casilla.dia == dia).length,
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
                            clasesDelDia[index].clase.casilla.horaini,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            clasesDelDia[index].clase.curso.curso,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${clasesDelDia[index].clase.coach.nombre} ${clasesDelDia[index].clase.coach.apellidop} ${clasesDelDia[index].clase.coach.apellidom}",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
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
        ],
      ),
    );
  }
}
