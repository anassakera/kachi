import 'package:flutter/material.dart';

import '../../functions/dashboard/table_functions.dart';
import '../../widgets/dashboard/crud_as_a_card_widget.dart';
import '../../widgets/dashboard/table_widgets.dart';
import 'complex_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Map<String, FocusNode> _focusNodes = {};
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  late TableFunctions tableFunctions;
  late TableWidgets tableWidgets;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNodes.forEach((_, node) => node.dispose());
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width >= 720;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: _buildResponsiveAppBar(context),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLargeScreen) const ComplexDrawer(),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        return const PhoneTable();
                      } else {
                        return const DesktopTable();
                        // return const DataManagement();
                      }
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
        drawer: isLargeScreen ? null : const ComplexDrawer(),
        drawerScrimColor: Colors.black54,
      ),
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: const Color(0xFF1a1c1e),
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Colors.white,
            size: 28,
          ),
      title: const Text(
        "Dashboard",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (MediaQuery.of(context).size.width > 600) ...[
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ],
    );
  }
}
