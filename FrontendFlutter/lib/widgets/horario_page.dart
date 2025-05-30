import 'package:flutter/material.dart';
import './training_tile.dart';


class HorarioPage extends StatelessWidget {
  const HorarioPage({
    super.key,
    required this.division,
    required this.sugerencia,
  });

  final List<TrainingTile> division;
  final List<TrainingTile> sugerencia;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 5,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "División de",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "Entrenamiento: ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ...division,
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "División sugerida:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ...sugerencia,
        ],
      ),
    );
  }
}