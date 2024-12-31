import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';
import '../../widgets/bar_chart.dart';
import '../../widgets/distribution_chart.dart';
import '../../widgets/line_chart.dart';
import '../../widgets/pie_chart.dart';
import '../../widgets/trend_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics',
          style: AppTypography.heading2.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Payment Trends Chart
            TrendChart(
              title: 'Payment Trends',
              chart: CustomLineChart(
                data: [
                  CustomLineChartData(label: 'Jan', value: 100),
                  CustomLineChartData(label: 'Feb', value: 150),
                  CustomLineChartData(label: 'Mar', value: 200),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Customer Payment Behavior Chart
            DistributionChart(
              title: 'Customer Payment Behavior',
              chart: CustomBarChart(
                data: [
                  CustomBarChartData(label: 'Customer A', value: 50),
                  CustomBarChartData(label: 'Customer B', value: 30),
                  CustomBarChartData(label: 'Customer C', value: 70),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Amount Distribution Chart
            DistributionChart(
              title: 'Amount Distribution',
              chart: CustomPieChart(
                data: [
                  CustomPieChartData(label: 'Bank A', value: 30),
                  CustomPieChartData(label: 'Bank B', value: 70),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Risk Analysis Chart
            DistributionChart(
              title: 'Risk Analysis',
              chart: CustomBarChart(
                data: [
                  CustomBarChartData(label: 'High Risk', value: 10),
                  CustomBarChartData(label: 'Medium Risk', value: 20),
                  CustomBarChartData(label: 'Low Risk', value: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
