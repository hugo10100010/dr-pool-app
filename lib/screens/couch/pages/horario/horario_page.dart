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
  
  final List<int> dias = [1,2,3,4,5,6,7];

  
  final List<String> horas = List.generate(12, (index) {
    int hora = 8 + index;
    String inicio = hora < 12 ? '$hora:00 AM' : '${hora == 12 ? 12 : hora - 12}:00 PM';
    String fin = hora + 1 < 12 ? '${hora + 1}:00 AM' : '${hora + 1 == 12 ? 12 : hora + 1 - 12}:00 PM';
    return '$inicio - $fin';
  });

  final Map<String, List<Map<String, String>>> horarioClases = {
  'Lunes': [
    {'clase': 'Yoga', 'profe': 'Ana'},
    {'clase': 'Zumba', 'profe': 'Carlos'},
    {'clase': 'Pilates', 'profe': 'Sofía'},
    {'clase': 'Crossfit', 'profe': 'Luis'},
    {'clase': 'Cardio', 'profe': 'Marta'},
    {'clase': 'Body Pump', 'profe': 'Raúl'},
    {'clase': 'Boxeo', 'profe': 'Eva'},
    {'clase': 'Spinning', 'profe': 'Jorge'},
    {'clase': 'Aeróbicos', 'profe': 'Laura'},
    {'clase': 'Stretching', 'profe': 'David'},
    {'clase': 'HIIT', 'profe': 'Sonia'},
    {'clase': 'Meditación', 'profe': 'Lucía'},
  ],
  'Martes': [
    {'clase': 'Pilates', 'profe': 'Sofía'},
    {'clase': 'Yoga', 'profe': 'Ana'},
    {'clase': 'Cardio', 'profe': 'Marta'},
    {'clase': 'Boxeo', 'profe': 'Eva'},
    {'clase': 'Crossfit', 'profe': 'Luis'},
    {'clase': 'Zumba', 'profe': 'Carlos'},
    {'clase': 'Body Pump', 'profe': 'Raúl'},
    {'clase': 'Spinning', 'profe': 'Jorge'},
    {'clase': 'Stretching', 'profe': 'David'},
    {'clase': 'HIIT', 'profe': 'Sonia'},
    {'clase': 'Aeróbicos', 'profe': 'Laura'},
    {'clase': 'Meditación', 'profe': 'Lucía'},
  ],
  'Miércoles': [
    {'clase': 'Crossfit', 'profe': 'Luis'},
    {'clase': 'Zumba', 'profe': 'Carlos'},
    {'clase': 'Pilates', 'profe': 'Sofía'},
    {'clase': 'Yoga', 'profe': 'Ana'},
    {'clase': 'Cardio', 'profe': 'Marta'},
    {'clase': 'Boxeo', 'profe': 'Eva'},
    {'clase': 'Body Pump', 'profe': 'Raúl'},
    {'clase': 'Stretching', 'profe': 'David'},
    {'clase': 'Spinning', 'profe': 'Jorge'},
    {'clase': 'HIIT', 'profe': 'Sonia'},
    {'clase': 'Aeróbicos', 'profe': 'Laura'},
    {'clase': 'Meditación', 'profe': 'Lucía'},
  ],
  'Jueves': [
    {'clase': 'Yoga', 'profe': 'Ana'},
    {'clase': 'Body Pump', 'profe': 'Raúl'},
    {'clase': 'Zumba', 'profe': 'Carlos'},
    {'clase': 'Pilates', 'profe': 'Sofía'},
    {'clase': 'Crossfit', 'profe': 'Luis'},
    {'clase': 'Cardio', 'profe': 'Marta'},
    {'clase': 'Boxeo', 'profe': 'Eva'},
    {'clase': 'Spinning', 'profe': 'Jorge'},
    {'clase': 'Stretching', 'profe': 'David'},
    {'clase': 'HIIT', 'profe': 'Sonia'},
    {'clase': 'Aeróbicos', 'profe': 'Laura'},
    {'clase': 'Meditación', 'profe': 'Lucía'},
  ],
  'Viernes': [
    {'clase': 'Pilates', 'profe': 'Sofía'},
    {'clase': 'Yoga', 'profe': 'Ana'},
    {'clase': 'Zumba', 'profe': 'Carlos'},
    {'clase': 'Cardio', 'profe': 'Marta'},
    {'clase': 'Crossfit', 'profe': 'Luis'},
    {'clase': 'Body Pump', 'profe': 'Raúl'},
    {'clase': 'Boxeo', 'profe': 'Eva'},
    {'clase': 'Spinning', 'profe': 'Jorge'},
    {'clase': 'Stretching', 'profe': 'David'},
    {'clase': 'HIIT', 'profe': 'Sonia'},
    {'clase': 'Aeróbicos', 'profe': 'Laura'},
    {'clase': 'Meditación', 'profe': 'Lucía'},
  ],
  'Sábado': [
    {'clase': 'Cardio', 'profe': 'Marta'},
    {'clase': 'Pilates', 'profe': 'Sofía'},
    {'clase': 'Yoga', 'profe': 'Ana'},
    {'clase': 'Crossfit', 'profe': 'Luis'},
    {'clase': 'Zumba', 'profe': 'Carlos'},
    {'clase': 'Body Pump', 'profe': 'Raúl'},
    {'clase': 'Boxeo', 'profe': 'Eva'},
    {'clase': 'Stretching', 'profe': 'David'},
    {'clase': 'Spinning', 'profe': 'Jorge'},
    {'clase': 'HIIT', 'profe': 'Sonia'},
    {'clase': 'Aeróbicos', 'profe': 'Laura'},
    {'clase': 'Meditación', 'profe': 'Lucía'},
  ],
  'Domingo': [
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
    {'clase': 'Descanso', 'profe': '-'},
  ],
};


  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    usuario!.clases!.sort((a, b) => a.casilla.horaini.compareTo(b.casilla.horaini));

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
                      child: Text(
                        dia == 1 ? "Lunes" : dia == 2 ? "Martes" : dia == 3 ? "Miercoles" : dia == 4 ? "Jueves" : dia == 5 ? "Viernes" : dia == 6 ? "Sábado" : dia == 7 ? "Domingo" : "No",
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
            final clasesDelDia = usuario.clases!.where((e) => e.casilla.dia==dia).toList();
            return ListView.builder(
              itemCount: usuario!.clases!.where((e) => e.casilla.dia==dia).length,
              itemBuilder: (context, index) {
                final claseInfo = clasesDelDia[index];
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
                      SizedBox(height: 4),
                      Text(
                        "${clasesDelDia[index].coach.nombre} ${clasesDelDia[index].coach.apellidop} ${clasesDelDia[index].coach.apellidom}",
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
    );
  }
}
