
import 'package:flutter/material.dart';
import '../functions/complex_drawer_functions.dart';

class ComplexDrawerWidgets {
  Widget buildDrawer(BuildContext context, ComplexDrawerFunctions functions) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1c1e).withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: AnimatedContainer(
          duration: DrawerConstants.animationDuration,
          width: functions.isExpanded
              ? DrawerConstants.getDrawerWidth(context)
              : DrawerConstants.collapsedWidth,
          child: Column(
            children: [
              _buildHeader(functions),
              const Divider(color: Colors.white24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildMenuItems(context, functions),
                      const Divider(color: Colors.white24),
                      _buildProfile(functions),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ...existing drawer widget methods...
}