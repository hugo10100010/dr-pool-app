import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:proyecto/providers/usuario_provider.dart';

class MetricasPage extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Future<void> Function(Map<String, dynamic>)? onSubmit;

  const MetricasPage({Key? key, this.initialData, this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Métricas')),
      body: MetricasForm(
        initialData: initialData ?? {},
        onSubmit: onSubmit ??
            (data) async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Métricas guardadas')),
              );
            },
      ),
    );
  }
}

class MetricasForm extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final Future<void> Function(Map<String, dynamic>) onSubmit;

  const MetricasForm({Key? key, this.initialData, required this.onSubmit})
      : super(key: key);

  @override
  State<MetricasForm> createState() => _MetricasFormState();
}

class _MetricasFormState extends State<MetricasForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _estaturaController;
  late TextEditingController _pesoController;
  late TextEditingController _maxCardioController;
  late TextEditingController _maxPulsoController;
  late TextEditingController _frecuenciaSemanalController;

  bool editando = false;
  late Map<String, dynamic> _originalData;

  @override
  void initState() {
    super.initState();
    _estaturaController = TextEditingController(
        text: widget.initialData?['estatura']?.toString() ?? '');
    _pesoController = TextEditingController(
        text: widget.initialData?['peso']?.toString() ?? '');
    _maxCardioController = TextEditingController(
        text: widget.initialData?['maxcardio']?.toString() ?? '');
    _maxPulsoController = TextEditingController(
        text: widget.initialData?['maxpulso']?.toString() ?? '');
    _frecuenciaSemanalController = TextEditingController(
        text: widget.initialData?['frecuenciasemanal']?.toString() ?? '');
    _originalData = Map<String, dynamic>.from(widget.initialData ?? {});
  }

  @override
  void dispose() {
    _estaturaController.dispose();
    _pesoController.dispose();
    _maxCardioController.dispose();
    _maxPulsoController.dispose();
    _frecuenciaSemanalController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Actualiza el estado global del usuario
      Provider.of<UsuarioProvider>(context, listen: false).actualizarMetricas(
        estatura: double.tryParse(_estaturaController.text) ?? 0.0,
        peso: double.tryParse(_pesoController.text) ?? 0.0,
        maxcardio: double.tryParse(_maxCardioController.text) ?? 0.0,
        maxpulso: int.tryParse(_maxPulsoController.text) ?? 0,
        frecuenciasemanal: int.tryParse(_frecuenciaSemanalController.text) ?? 0,
      );

      widget.onSubmit({
        'estatura': double.tryParse(_estaturaController.text),
        'peso': double.tryParse(_pesoController.text),
        'maxcardio': double.tryParse(_maxCardioController.text),
        'maxpulso': int.tryParse(_maxPulsoController.text),
        'frecuenciasemanal': int.tryParse(_frecuenciaSemanalController.text),
      });
      setState(() {
        editando = false;
        _originalData = {
          'estatura': _estaturaController.text,
          'peso': _pesoController.text,
          'maxcardio': _maxCardioController.text,
          'maxpulso': _maxPulsoController.text,
          'frecuenciasemanal': _frecuenciaSemanalController.text,
        };
      });
    }
  }

  void _cancelar() {
    setState(() {
      _estaturaController.text = _originalData['estatura']?.toString() ?? '';
      _pesoController.text = _originalData['peso']?.toString() ?? '';
      _maxCardioController.text = _originalData['maxcardio']?.toString() ?? '';
      _maxPulsoController.text = _originalData['maxpulso']?.toString() ?? '';
      _frecuenciaSemanalController.text =
          _originalData['frecuenciasemanal']?.toString() ?? '';
      editando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              icon: Icon(editando ? Icons.lock_open : Icons.lock),
              label: Text(editando ? 'Bloquear edición' : 'Editar'),
              onPressed: () {
                setState(() {
                  editando = !editando;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _estaturaController,
            decoration: const InputDecoration(labelText: 'Estatura (m)'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            enabled: editando,
            validator: (value) {
              final v = double.tryParse(value ?? '');
              if (v == null || v < 0 || v > 9.99)
                return 'Ingrese una estatura válida';
              return null;
            },
          ),
          TextFormField(
            controller: _pesoController,
            decoration: const InputDecoration(labelText: 'Peso (kg)'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            enabled: editando,
            validator: (value) {
              final v = double.tryParse(value ?? '');
              if (v == null || v < 0 || v > 999.99)
                return 'Ingrese un peso válido';
              return null;
            },
          ),
          TextFormField(
            controller: _maxCardioController,
            decoration: const InputDecoration(labelText: 'Max Cardio'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            enabled: editando,
            validator: (value) {
              final v = double.tryParse(value ?? '');
              if (v == null || v < 0 || v > 99.99)
                return 'Ingrese un valor válido';
              return null;
            },
          ),
          TextFormField(
            controller: _maxPulsoController,
            decoration: const InputDecoration(labelText: 'Max Pulso'),
            keyboardType: TextInputType.number,
            enabled: editando,
            validator: (value) {
              final v = int.tryParse(value ?? '');
              if (v == null || v < 0) return 'Ingrese un valor válido';
              return null;
            },
          ),
          TextFormField(
            controller: _frecuenciaSemanalController,
            decoration: const InputDecoration(labelText: 'Frecuencia Semanal'),
            keyboardType: TextInputType.number,
            enabled: editando,
            validator: (value) {
              final v = int.tryParse(value ?? '');
              if (v == null || v < 0) return 'Ingrese un valor válido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: editando ? _submit : null,
                  child: const Text('Guardar'),
                ),
              ),
              if (editando) SizedBox(width: 12),
              if (editando)
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: _cancelar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
