import 'package:flutter/material.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_typography.dart';

class TrendChart extends StatelessWidget {
  final String title;
  final Widget chart;

  const TrendChart({
    super.key,
    required this.title,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }
}
