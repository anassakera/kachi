import 'package:flutter/material.dart';
import 'package:kachi/widgets/custom_button.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTypography.heading3,
      ),
      content: Text(
        message,
        style: AppTypography.bodyMedium,
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
            onConfirm();
            Navigator.pop(context);
          },
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
