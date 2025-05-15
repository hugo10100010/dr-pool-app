import 'package:flutter/material.dart';
import '../../../../widgets/custom_container.dart';

class AcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        CustomContainer(
          boxHeight: 150,
          child: Text(
            "Acerca de nosotros",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        CustomContainer(
          boxHeight: 100,
          child: Text(
            "Sede central",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        CustomContainer(
          boxHeight: 120,
          child: Text(
            "Contáctenos",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}