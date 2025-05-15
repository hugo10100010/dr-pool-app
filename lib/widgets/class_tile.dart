import 'package:flutter/material.dart';

class ClassTile extends StatelessWidget {
  const ClassTile({
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
      title: Text(
        'data',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: specifications,
        ),
      ],
    );
  }
}