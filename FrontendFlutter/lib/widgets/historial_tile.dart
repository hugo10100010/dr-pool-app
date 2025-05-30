import 'package:flutter/material.dart';

class HistorialTile extends StatelessWidget {
  const HistorialTile({
    super.key,
    required this.specifications,
  });

  final List<Widget> specifications;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      shape: Border.all(
        width: 2,
        color: Colors.black,
      ),
      leading: Icon(Icons.star),
      expandedAlignment: Alignment.topLeft,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "Fecha",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Monto \$",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
      children: [...specifications],
    );
  }
}