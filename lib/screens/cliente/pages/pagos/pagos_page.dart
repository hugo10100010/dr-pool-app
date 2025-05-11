import 'package:flutter/material.dart';
import '../../../../widgets/custom_container.dart';
import '../../../../widgets/historial_tile.dart';

class Pagos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxHeight: 300,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Historial de subscripciones ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              HistorialTile(specifications: [
                Text(
                  'data',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ])
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        CustomContainer(
          boxHeight: 200,
          boxPadding: EdgeInsets.all(0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 33,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Datos de cobro",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 5, 3, 5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Tarjeta registrada: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "No. de tarjeta: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}