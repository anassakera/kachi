import 'package:flutter/material.dart';
import 'package:kachi/screens/dashboard/complex_drawer.dart';

import 'table_widgets.dart';

class DashboardScreenWidgets {
  static const double _largeScreenThreshold = 900.0;
  static const double _mediumScreenThreshold = 600.0;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= _largeScreenThreshold;

  static buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF1a1c1e).withValues(alpha: 0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      centerTitle: true,
      title: const Text(
        "Dashboard",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  static Widget buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MediaQuery.of(context).size.width >= _largeScreenThreshold)
            const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: ComplexDrawer(),
            ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < _mediumScreenThreshold) {
                        return const PhoneTable();
                      } else {
                        return const DesktopTable();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return const ComplexDrawer();
  }

  Widget buildTable(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? const PhoneTable()
        : const DesktopTable();
  }
}
