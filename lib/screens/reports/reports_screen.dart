import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: AppTypography.heading2.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildReportCard(
              'Cash Flow Report',
              Icons.trending_up,
              () => Navigator.pushNamed(context, '/report/cashflow'),
            ),
            const SizedBox(height: 12),
            _buildReportCard(
              'Aging Report',
              Icons.calendar_today,
              () => Navigator.pushNamed(context, '/report/aging'),
            ),
            const SizedBox(height: 12),
            _buildReportCard(
              'Customer Performance',
              Icons.people,
              () => Navigator.pushNamed(context, '/report/customer'),
            ),
            const SizedBox(height: 12),
            _buildReportCard(
              'Check Summary',
              Icons.receipt_long,
              () => Navigator.pushNamed(context, '/report/summary'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, IconData icon, VoidCallback onPressed) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 28, color: AppColors.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.subtitle2,
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
