import 'package:flutter/material.dart';
import '../../../../widgets/custom_container.dart';
import '../../../../widgets/class_tile.dart';

class Clases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxPadding: EdgeInsets.fromLTRB(10, 20, 10, 30),
          boxHeight: 500,
          child: SingleChildScrollView(
            child: Column(
              spacing: 5,
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Paquetes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
                ClassTile(specifications: [Text("A")]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}