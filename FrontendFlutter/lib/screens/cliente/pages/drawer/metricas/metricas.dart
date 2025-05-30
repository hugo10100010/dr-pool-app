import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/providers/usuario_provider.dart';
import 'package:proyecto/services/usuario_service.dart';

class MetricasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Métricas')),
      body: MetricasForm(),
    );
  }
}

class MetricasForm extends StatefulWidget {
  @override
  State<MetricasForm> createState() => _MetricasFormState();
}

class _MetricasFormState extends State<MetricasForm> {
  final _formKey = GlobalKey<FormState>();

  bool editando = false;
  late Map<String, dynamic> _originalData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario = Provider.of<UsuarioProvider>(context).usuario!;
    TextEditingController _estaturaController = TextEditingController(text: usuario.metricas?.estatura?.toString() ?? '');
    TextEditingController _pesoController = TextEditingController(text: usuario.metricas?.peso?.toString() ?? '');
    TextEditingController _maxCardioController = TextEditingController(text: usuario.metricas?.maxcardio?.toString() ?? '');
    TextEditingController _maxPulsoController = TextEditingController(text: usuario.metricas?.maxpulso?.toString() ?? '');
    TextEditingController _frecuenciaSemanalController = TextEditingController(text: usuario.metricas?.frecuenciasemanal?.toString() ?? '');
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
          SizedBox(height: 12,),
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
          SizedBox(height: 12,),
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
          SizedBox(height: 12,),
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
          SizedBox(height: 12,),
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
                  onPressed: editando
                      ? () async {
                          Map<String, dynamic> data = {
                            "id": usuario.id,
                          };
                          Map<String,dynamic> metricas = {};

                          if (_estaturaController.text.isNotEmpty) {
                            metricas["estatura"] = double.parse(_estaturaController.text);
                          }
                          if (_pesoController.text.isNotEmpty) {
                            metricas["peso"] = double.parse(_pesoController.text);
                          }
                          if (_maxCardioController.text.isNotEmpty) {
                            metricas["maxcardio"] = double.parse(_maxCardioController.text);
                          }
                          if (_maxPulsoController.text.isNotEmpty) {
                            metricas["maxpulso"] = int.parse(_maxPulsoController.text);
                          }
                          if (_frecuenciaSemanalController.text.isNotEmpty) {
                            metricas["frecuenciasemanal"] = int.parse(_frecuenciaSemanalController.text);
                          }
                          if(metricas.isNotEmpty) {
                            data["metricas"] = metricas;
                          }
                          bool success =
                              await UsuarioService().modificarUsuario(data);
                          if (success) {
                            Provider.of<UsuarioProvider>(context,listen: false)
                                .actualizarMetricas(
                              metricas["estatura"],
                              metricas["peso"],
                              metricas["maxcardio"],
                              metricas["maxpulso"],
                              metricas["frecuenciasemanal"],
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Datos guardados')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error al guardar')),
                          );
                          }
                        }
                      : null,
                  child: const Text('Guardar'),
                ),
              ),
              if (editando) SizedBox(width: 12),
              if (editando)
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      _estaturaController.text =
                          usuario.metricas?.estatura.toString() ?? '';
                      _pesoController.text =
                          usuario.metricas?.peso.toString() ?? '';
                      _maxCardioController.text =
                          usuario.metricas?.maxcardio.toString() ?? '';
                      _maxPulsoController.text =
                          usuario.metricas?.maxpulso.toString() ?? '';
                      _frecuenciaSemanalController.text =
                          usuario.metricas?.frecuenciasemanal.toString() ?? '';
                    },
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
