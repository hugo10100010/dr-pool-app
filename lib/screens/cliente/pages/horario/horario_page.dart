import 'package:flutter/material.dart';
import '../../../../widgets/horario_page.dart';
import '../../../../widgets/training_tile.dart';
import '../../../../widgets/custom_container.dart';

class Horario extends StatefulWidget {
  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;

  final List<String> days = ["L", "M", "M", "J", "V", "S", "D"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> pages = [
    HorarioPage(
      division: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
      sugerencia: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
    ),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  List<Widget> pagesPrueba = List.generate(7, (index) {
    return HorarioPage(
      division: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
      sugerencia: [
        TrainingTile(
          specifications: [
            Text('Uno'),
            Text('Dos'),
          ],
        ),
      ],
    );
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          boxHeight: 500,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(days.length, (index) {
                    bool isSelected = index == _selectedIndex;
                    return GestureDetector(
                      onTap: () => _tabController.animateTo(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 11),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.pink[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Text(
                          days[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: pagesPrueba,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}