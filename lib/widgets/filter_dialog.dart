import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';

class FilterDialog extends StatelessWidget {
  final VoidCallback onApply;

  const FilterDialog({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Filters',
        style: AppTypography.heading3,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add filter options here
          const Text(
            'Select date range',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: () {
              // TO DO: Show date range picker
            },
            backgroundColor: AppColors.surfaceLight,
            foregroundColor: AppColors.textPrimary,
            child: const Text('Select Date Range'),
          ),
        ],
      ),
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: AppColors.surfaceLight,
          foregroundColor: AppColors.textPrimary,
          child: const Text('Cancel'),
        ),
        CustomButton(
          onPressed: () {
            onApply();
            Navigator.pop(context);
          },
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
