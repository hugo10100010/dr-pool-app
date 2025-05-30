import 'package:flutter/material.dart';
import 'package:proyecto/models/field_config_model.dart';

class GenericAgregarForm extends StatefulWidget {
  final List<List<FieldConfig>> pages;
  final void Function(Map<String, dynamic>) onSubmit;

  const GenericAgregarForm({required this.pages, required this.onSubmit});

  @override
  State<GenericAgregarForm> createState() => _GenericAgregarFormState();
}

class _GenericAgregarFormState extends State<GenericAgregarForm> {
  final List<GlobalKey<FormState>> _formKeys = [];
  final _pageController = PageController();
  final Map<String, TextEditingController> _controllers = {};
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    for (final page in widget.pages) {
      for (final field in page) {
        _controllers[field.key] = TextEditingController();
      }
    }
  }

  void _nextPage() {
    final currentForm = _formKeys[_currentPage];

    if (!currentForm.currentState!.validate()) {
      return;
    }

    if (_currentPage < widget.pages.length - 1) {
      setState(() {
        _currentPage++;
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });
    } else {
      final data = {
        for (var entry in _controllers.entries) entry.key: entry.value.text
      };
      widget.onSubmit(data);
      _controllers.forEach((key, value) => value.clear());
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_formKeys.length < widget.pages.length) {
      _formKeys.clear();
      _formKeys.addAll(
          List.generate(widget.pages.length, (_) => GlobalKey<FormState>()));
    }
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(widget.pages.length, (index) {
                    final page = widget.pages[index];
                    return Form(
                      key: _formKeys[index],
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 12,
                          children: page.map((field) {
                            if (field.type == FieldType.dropdown &&
                                field.dropdownItems != null) {
                              final options = field.dropdownItems!;
                              final selectedValue =
                                  _controllers[field.key]?.text;

                              return DropdownButtonFormField<dynamic>(
                                value: selectedValue?.isNotEmpty == true
                                    ? options
                                        .firstWhere(
                                          (opt) =>
                                              opt.value.toString() ==
                                              selectedValue,
                                          orElse: () => options.first
                                              as DropdownOption<
                                                  dynamic>, // ✳️ Force cast
                                        )
                                        .value
                                    : null,
                                decoration:
                                    InputDecoration(labelText: field.label),
                                items: [
                                  DropdownMenuItem(
                                    enabled: false,
                                    value: null,
                                    child: Text("Seleccione una opción..."),
                                  ),
                                  ...options.map((opt) => DropdownMenuItem(
                                        value: opt.value,
                                        child: Text(opt.label),
                                      )),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    _controllers[field.key]!.text =
                                        value.toString();
                                  }
                                },
                                validator: (value) => value == null
                                    ? 'Este campo es obligatorio'
                                    : null,
                              );
                            }

                            return TextFormField(
                              controller: _controllers[field.key],
                              obscureText: field.obscureText,
                              keyboardType: field.inputType,
                              decoration:
                                  InputDecoration(labelText: field.label),
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Este campo es obligatorio';

                                switch (field.type) {
                                  case FieldType.int:
                                    return int.tryParse(value) == null
                                        ? 'Debe ser un número entero'
                                        : null;
                                  case FieldType.double:
                                    return double.tryParse(value) == null
                                        ? 'Debe ser un número decimal'
                                        : null;
                                  default:
                                    return null;
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPage > 0)
              ElevatedButton(onPressed: _prevPage, child: Text("Back")),
            ElevatedButton(
              onPressed: _nextPage,
              child: Text(
                  _currentPage < widget.pages.length - 1 ? "Next" : "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
