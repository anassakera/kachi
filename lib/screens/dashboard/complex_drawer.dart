import 'package:flutter/material.dart';
import 'widgets/complex_drawer_widgets.dart';
import 'functions/complex_drawer_functions.dart';

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({super.key});

  @override
  State<ComplexDrawer> createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer>
    with SingleTickerProviderStateMixin {
  final _functions = ComplexDrawerFunctions();
  final _widgets = ComplexDrawerWidgets();

  @override
  void initState() {
    super.initState();
    _functions.initialize(this);
  }

  @override
  void dispose() {
    _functions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _widgets.buildDrawer(context, _functions);
  }
}
