import 'package:flutter/material.dart';

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
  final List<String> dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

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
    return DefaultTabController(
      length: dias.length,
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
                        dia,
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
            final clasesDelDia = horarioClases[dia] ?? List.generate(12, (_) => {'clase': '-', 'profe': '-'});
            return ListView.builder(
              itemCount: horas.length,
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
                        horas[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        claseInfo!['clase'] ?? '-',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Profe: ${claseInfo['profe'] ?? '-'}',
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
