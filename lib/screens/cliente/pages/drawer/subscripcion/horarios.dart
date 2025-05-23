
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HorariosPage extends StatefulWidget {
  @override
  _HorariosPageState createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {
  final int rows = 5;
  final int cols = 7;
  List<List<bool>> selected = [];
  final List<String> dias = [
    'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
  ];

  Map<String, dynamic>? paqueteSeleccionado;
  int maxClases = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    paqueteSeleccionado = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Detecta el máximo de clases según el paquete
    if (paqueteSeleccionado != null) {
      final titulo = paqueteSeleccionado!['titulo'] ?? '';
      if (titulo == 'Básico') maxClases = 2;
      else if (titulo == 'Estándar') maxClases = 4;
      else if (titulo == 'Premium') maxClases = 9999; // ilimitadas
    }
  }

  @override
  void initState() {
    super.initState();
    selected = List.generate(rows, (_) => List.generate(cols, (_) => false));
  }

  int get seleccionadosCount {
    int count = 0;
    for (var row in selected) {
      for (var cell in row) {
        if (cell) count++;
      }
    }
    return count;
  }

  void _onCellTap(int row, int col) {
    setState(() {
      if (selected[row][col]) {
        // Permite deseleccionar siempre
        selected[row][col] = false;
      } else {
        // Solo permite seleccionar si no se ha llegado al máximo
        if (seleccionadosCount < maxClases) {
          selected[row][col] = true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Solo puedes seleccionar $maxClases clase(s) según tu paquete.')),
          );
        }
      }
    });
  }

  void _contratar() {
    //enviar la selección a la siguiente pantalla
    final paqueteSeleccionado = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HorariosSeleccionadosPage(
          seleccion: selected,
          dias: dias,
          paqueteSeleccionado: paqueteSeleccionado,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tus horarios'),
      ),
      body: Column(
        children: [
          // Encabezado de días
          Row(
            children: [
              SizedBox(width: 40), // Espacio para la columna de horas
              ...dias.map((d) => Expanded(
                child: Center(child: Text(d, style: TextStyle(fontWeight: FontWeight.bold))),
              )),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rows,
              // ...existing code...
itemBuilder: (context, row) {
  int horaInicio = 8 + row * 2;
  int horaFin = horaInicio + 2;
  String rango = '${horaInicio.toString().padLeft(2, '0')}:00-${horaFin.toString().padLeft(2, '0')}:00';
  return Row(
    children: [
      // Si quieres dejar la columna de horas vacía:
      // SizedBox(width: 0),
      ...List.generate(cols, (col) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _onCellTap(row, col),
            child: Container(
              margin: EdgeInsets.all(4),
              height: 60,
              decoration: BoxDecoration(
                color: selected[row][col] ? Colors.red : Colors.grey[300],
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  rango,
                  style: TextStyle(
                    color: selected[row][col] ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      }),
    ],
  );
},
// ...existing code...
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _contratar,
              child: Text('Contratar'),
            ),
          ),
        ],
      ),
    );
  }
}

class HorariosSeleccionadosPage extends StatelessWidget {
  final List<List<bool>> seleccion;
  final List<String> dias;
  final Map<String, dynamic>? paqueteSeleccionado;

  HorariosSeleccionadosPage({required this.seleccion, required this.dias, required this.paqueteSeleccionado});

  @override
  Widget build(BuildContext context) {
    List<String> seleccionados = [];
    for (int row = 0; row < seleccion.length; row++) {
  int horaInicio = 8 + row * 2;
  int horaFin = horaInicio + 2;
  String rango = '${horaInicio.toString().padLeft(2, '0')}:00-${horaFin.toString().padLeft(2, '0')}:00';
  for (int col = 0; col < seleccion[row].length; col++) {
    if (seleccion[row][col]) {
      seleccionados.add('${dias[col]} $rango');
    }
  }
}

    return Scaffold(
  appBar: AppBar(
    title: Text('Horarios Seleccionados'),
  ),
  body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (seleccionados.isEmpty)
          Text('No seleccionaste ningún horario.')
        else
  Center(
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: seleccionados
          .map((h) => Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 205, 205),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Text(
                  h,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ))
          .toList(),
    ),
  ),
        SizedBox(height: 24),
Center(
  child: ElevatedButton(
    onPressed: () {
      if (seleccionados.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Atención'),
            content: Text('Debes seleccionar al menos una clase para continuar.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        Navigator.pushNamed(context, '/carrito', arguments: {
          'horarios': seleccionados, 'paquete': paqueteSeleccionado,
        });
      }
    },
    child: Text('Continuar'),
  ),
),
      ],
    ),
  ),
);
  }
}