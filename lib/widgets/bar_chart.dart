import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../constant/app_colors.dart';

class CustomBarChart extends StatelessWidget {
  final List<CustomBarChartData> data;

  const CustomBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: data
              .asMap()
              .map((index, item) => MapEntry(
                  index,
                  BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: item.value,
                        color: AppColors.primary,
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  )))
              .values
              .toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      data[value.toInt()].label,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }
}

class CustomBarChartData {
  final String label;
  final double value;

  CustomBarChartData({required this.label, required this.value});
}
