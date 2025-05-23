import 'package:flutter/material.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/detalles_form.dart';
import 'package:proyecto/screens/admin/pages/generic/modificar/editablefield.dart';
import 'package:proyecto/services/usuario_service.dart';

class Detallesusuariomodif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final usuario = args['usuario'] as Usuario;
    final service = UsuarioService();

    return GenericDetallesModificables(
      tabTitles: ['Cuenta', 'Domicilio', 'Metricas'],
      editableTabs: [
        // Cuenta
        [
          EditableField(
            label: 'Usuario',
            controller: TextEditingController(text: usuario.cuenta.nombreusu),
            onSubmit: (val) {
              usuario.cuenta.nombreusu = val;
              service.modificarUsuario({
                "cuenta": {"nombreusu": val}
              });
            },
          ),
        ],
        // Domicilio
        [
          EditableField(
            label: 'Calle',
            controller: TextEditingController(text: usuario.domicilio.calle),
            onSubmit: (val) {
              usuario.domicilio.calle = val;
              service.modificarUsuario({
                "domicilio": {"calle": val}
              });
            },
          ),
          EditableField(
            label: 'Num ext.',
            controller: TextEditingController(
                text: usuario.domicilio.numext.toString()),
            onSubmit: (val) {
              usuario.domicilio.numext = int.tryParse(val) ?? 0;
              service.modificarUsuario({
                "domicilio": {"numext": val}
              });
            },
          ),
          EditableField(
            label: 'Num int.',
            controller: TextEditingController(
                text: usuario.domicilio.numint.toString()),
            onSubmit: (val) {
              usuario.domicilio.numext = int.tryParse(val) ?? 0;
              service.modificarUsuario({
                "domicilio": {"numint": val}
              });
            },
          ),
          EditableField(
            label: 'Asentamiento',
            controller:
                TextEditingController(text: usuario.domicilio.asentamiento),
            onSubmit: (val) {
              usuario.domicilio.numext = int.tryParse(val) ?? 0;
              service.modificarUsuario({
                "domicilio": {"asentamiento": val}
              });
            },
          ),
          EditableField(
            label: 'Codigo p.',
            controller: TextEditingController(
                text: usuario.domicilio.codigop.toString()),
            onSubmit: (val) {
              usuario.domicilio.numext = int.tryParse(val) ?? 0;
              service.modificarUsuario({
                "domicilio": {"codigop": val}
              });
            },
          ),
        ],
        // Metricas
        [
          EditableField(
            label: 'Estatura',
            controller: TextEditingController(
                text: usuario.metricas.estatura.toString()),
            onSubmit: (val) {
              usuario.metricas.estatura = double.tryParse(val) ?? 0;
              service.modificarUsuario({
                "metricas": {"estatura": val}
              });
            },
          ),
          EditableField(
            label: 'Peso',
            controller:
                TextEditingController(text: usuario.metricas.peso.toString()),
            onSubmit: (val) {
              usuario.metricas.peso = double.tryParse(val) ?? 0;
              service.modificarUsuario({
                "metricas": {"peso": val}
              });
            },
          ),
          EditableField(
            label: 'Max. cardio.',
            controller: TextEditingController(
                text: usuario.metricas.maxcardio.toString()),
            onSubmit: (val) {
              usuario.metricas.maxcardio = double.tryParse(val) ?? 0;
              service.modificarUsuario({
                "metricas": {"maxcardio": val}
              });
            },
          ),
          EditableField(
            label: 'Max. pulso',
            controller: TextEditingController(
                text: usuario.metricas.maxpulso.toString()),
            onSubmit: (val) {
              usuario.metricas.maxpulso = int.tryParse(val) ?? 0;
              service.modificarUsuario({
                "metricas": {"maxpulso": val}
              });
            },
          ),
          EditableField(
            label: 'Frecuencia semanal',
            controller: TextEditingController(
                text: usuario.metricas.frecuenciasemanal.toString()),
            onSubmit: (val) {
              usuario.metricas.frecuenciasemanal = int.tryParse(val) ?? 0;
              service.modificarUsuario({
                "metricas": {"frecuenciasemanal": val}
              });
            },
          ),
        ]
      ],
    );
  }
}
