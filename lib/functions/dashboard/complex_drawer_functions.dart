import 'package:flutter/material.dart';

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final List<DrawerSubMenuItem> submenus;
  final Color? iconColor;
  final Function(BuildContext)? onTap;

  const DrawerMenuItem({
    required this.icon,
    required this.title,
    this.submenus = const [],
    this.iconColor,
    this.onTap,
  });
}

class DrawerSubMenuItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const DrawerSubMenuItem({
    required this.title,
    required this.icon,
    this.iconColor,
    this.onPressed,
  });
}

class ComplexDrawerFunctions {
  late AnimationController _controller;
  bool isExpanded = true;
  int selectedIndex = -1;
  late final List<DrawerMenuItem> menuItems;

  void initialize(TickerProvider vsync) {
    _controller = AnimationController(
      duration: DrawerConstants.animationDuration,
      vsync: vsync,
    );
    if (isExpanded) _controller.forward();
    _initializeMenuItems();
  }

  void dispose() {
    _controller.dispose();
  }

  void toggleDrawer() {
    isExpanded = !isExpanded;
    if (isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void selectMenuItem(int index) {
    selectedIndex = selectedIndex == index ? -1 : index;
  }

  void _initializeMenuItems() {
    menuItems = [
      DrawerMenuItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        iconColor: const Color(0xFFFFB74D),
        onTap: (context) => Navigator.pushNamed(context, '/dashboard'),
        submenus: const [
          DrawerSubMenuItem(
            title: "Overview",
            icon: Icons.assessment_rounded,
            iconColor: Color(0xFF7986CB),
          ),
          // ...more submenu items...
        ],
      ),
      // ...more menu items...
    ];
  }

  void Function() get onProfileTap => () {
    // Handle profile tap
  };
}

class DrawerConstants {
  static double getDrawerWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return screenWidth * 0.75;
    if (screenWidth < 900) return screenWidth * 0.30;
    if (screenWidth < 1200) return screenWidth * 0.25;
    return screenWidth * 0.20;
  }

  static const double collapsedWidth = 70.0;
  static const double submenuWidth = 220.0;
  static const Duration animationDuration = Duration(milliseconds: 250);
  static const double borderRadius = 12.0;
  static const double itemSpacing = 6.0;
  static const double menuItemHeight = 50.0;
}