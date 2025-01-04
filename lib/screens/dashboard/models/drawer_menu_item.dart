
import 'package:flutter/material.dart';

class DrawerMenuItem {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  const DrawerMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}