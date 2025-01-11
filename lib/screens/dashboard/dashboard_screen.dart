import 'package:flutter/material.dart';
import '../../widgets/dashboard/dashboard_screen_widgets.dart';
import 'complex_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300.withValues(alpha: 0.95),
      appBar: DashboardScreenWidgets.buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DashboardScreenWidgets.buildBody(context),
      ),
      drawer: DashboardScreenWidgets.isLargeScreen(context)
          ? null
          : const ComplexDrawer(),
      drawerScrimColor: Colors.black38,
    );
  }
}
