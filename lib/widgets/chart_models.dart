// lib/widgets/chart_models.dart

import 'package:flutter/material.dart';

// Data Models
class LineChartData {
  final String label;
  final double value;

  LineChartData({required this.label, required this.value});
}

class BarChartData {
  final String label;
  final double value;

  BarChartData({required this.label, required this.value});
}

class PieChartData {
  final String label;
  final double value;

  PieChartData({required this.label, required this.value});
}

// Chart Widgets
class LineChart extends StatelessWidget {
  final List<LineChartData> data;

  const LineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Implement line chart visualization here
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: LineChartPainter(data: data),
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final List<BarChartData> data;

  const BarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Implement bar chart visualization here
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: BarChartPainter(data: data),
      ),
    );
  }
}

class PieChart extends StatelessWidget {
  final List<PieChartData> data;

  const PieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Implement pie chart visualization here
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: PieChartPainter(data: data),
      ),
    );
  }
}

// Custom Painters
class LineChartPainter extends CustomPainter {
  final List<LineChartData> data;

  LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    // Implement line chart painting logic
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BarChartPainter extends CustomPainter {
  final List<BarChartData> data;

  BarChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    // Implement bar chart painting logic
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PieChartPainter extends CustomPainter {
  final List<PieChartData> data;

  PieChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    // Implement pie chart painting logic
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
