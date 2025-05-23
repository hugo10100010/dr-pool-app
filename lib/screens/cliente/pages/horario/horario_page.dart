import 'package:flutter/material.dart';
import '../../../../widgets/horario_page.dart';
import '../../../../widgets/training_tile.dart';
import '../../../../widgets/custom_container.dart';

class Horario extends StatefulWidget {
  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;

  final List<String> days = ["L", "M", "M", "J", "V", "S", "D"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> pages = [
    HorarioPage(
      division: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
      sugerencia: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
    ),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  List<Widget> pagesPrueba = List.generate(7, (index) {
    return HorarioPage(
      division: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
      sugerencia: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
    );
  });

  final List<String> dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  final List<String> horas = List.generate(12, (index) {
    int hora = 8 + index;
    String inicio =
        hora < 12 ? '$hora:00 AM' : '${hora == 12 ? 12 : hora - 12}:00 PM';
    String fin = hora + 1 < 12
        ? '${hora + 1}:00 AM'
        : '${hora + 1 == 12 ? 12 : hora + 1 - 12}:00 PM';
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
    child: Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 223, 2, 2),
          child: TabBar(
            isScrollable: false,
            tabs: dias.map((dia) {
              return Tab(child: Text(dia));
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
              final clasesDelDia = horarioClases[dia] ??
                  List.generate(12, (_) => {'clase': '-', 'profe': '-'});
              return ListView.builder(
                itemCount: horas.length,
                itemBuilder: (context, index) {
                  final claseInfo = clasesDelDia[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            horas[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            claseInfo?['clase'] ?? '-',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Profe: ${claseInfo?['profe'] ?? '-'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
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
