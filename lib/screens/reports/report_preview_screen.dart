import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';
import '../../widgets/custom_button.dart';

class ReportPreviewScreen extends StatelessWidget {
  final String reportTitle;

  const ReportPreviewScreen({super.key, required this.reportTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          reportTitle,
          style: AppTypography.heading2.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Report Preview',
              style: AppTypography.heading2,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                // TO DO: Implement export logic
              },
              child: const Text('Export Report'),
            ),
          ],
        ),
      ),
    );
  }
}
