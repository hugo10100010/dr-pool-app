import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DropdownListExample(),
    );
  }
}

class DropdownListExample extends StatefulWidget {
  @override
  _DropdownListExampleState createState() => _DropdownListExampleState();
}

class _DropdownListExampleState extends State<DropdownListExample> {
  final Map<String, List<String>> items = {
    'Clase1': ['1', '2', '2'],
    'Clase2': ['3', '2', '1'],
    'Clase3': ['0', '1', '2'],
  };

  String? selectedCategory = 'Clase1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Consultar Clases'),
        backgroundColor: Colors.red[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          DropdownButton<String>(
            dropdownColor: Colors.black,
            value: selectedCategory,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            iconEnabledColor: Colors.red,
            items: items.keys.map((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(key, style: TextStyle(color: Colors.red)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[900]?.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: items[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.red, width: 1),
                    ),
                    child: ListTile(
                      title: Text(
                        items[selectedCategory]![index],
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.class_, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
