import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../constant/app_colors.dart';

class CustomLineChart extends StatelessWidget {
  final List<CustomLineChartData> data;

  const CustomLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .map((index, item) =>
                      MapEntry(index, FlSpot(index.toDouble(), item.value)))
                  .values
                  .toList(),
              isCurved: true,
              color: AppColors.primary,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
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

class CustomLineChartData {
  final String label;
  final double value;

  CustomLineChartData({required this.label, required this.value});
}
