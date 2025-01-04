import 'package:flutter/material.dart';
import 'widgets/dashboard_screen_widgets.dart';
import 'functions/dashboard_screen_functions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardScreenFunctions _functions = DashboardScreenFunctions();
  final DashboardScreenWidgets _widgets = DashboardScreenWidgets();

  @override
  void dispose() {
    _functions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _widgets.buildDashboard(context);
  }
}
