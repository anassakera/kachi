
import 'package:flutter/material.dart';

class DashboardScreenFunctions {
  final Map<String, FocusNode> _focusNodes = {};
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  void dispose() {
    _disposeControllers();
  }

  void _disposeControllers() {
    _focusNodes.forEach((_, node) => node.dispose());
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
  }
}