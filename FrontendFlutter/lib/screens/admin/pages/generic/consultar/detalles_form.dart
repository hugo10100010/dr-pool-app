import 'package:flutter/material.dart';

class GenericDetalles extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabPages;

  const GenericDetalles({
    required this.tabTitles,
    required this.tabPages,
  });

  @override
  State<GenericDetalles> createState() => _GenericDetallesState();
}

class _GenericDetallesState extends State<GenericDetalles>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Clean up!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: widget.tabTitles.map((title) => Tab(text: title)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabPages,
      ),
    );
  }
}
