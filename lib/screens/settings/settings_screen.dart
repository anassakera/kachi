import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTypography.heading2.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Account Settings
          ListTile(
            title: const Text(
              'Change Password',
              style: AppTypography.bodyLarge,
            ),
            onTap: () {
              // TO DO: Navigate to change password screen
            },
          ),
          ListTile(
            title: const Text(
              'Edit Profile',
              style: AppTypography.bodyLarge,
            ),
            onTap: () {
              // TO DO: Navigate to edit profile screen
            },
          ),

          // Notification Settings
          ListTile(
            title: const Text(
              'Check Due Notifications',
              style: AppTypography.bodyLarge,
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TO DO: Implement notification toggle logic
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Payment Notifications',
              style: AppTypography.bodyLarge,
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TO DO: Implement notification toggle logic
              },
            ),
          ),

          // General Settings
          ListTile(
            title: const Text(
              'Change Language',
              style: AppTypography.bodyLarge,
            ),
            onTap: () {
              // TO DO: Show language selection dialog
            },
          ),
          ListTile(
            title: const Text(
              'Date and Time Format',
              style: AppTypography.bodyLarge,
            ),
            onTap: () {
              // TO DO: Show date and time format selection dialog
            },
          ),

          // About
          ListTile(
            title: const Text(
              'About the App',
              style: AppTypography.bodyLarge,
            ),
            onTap: () {
              // TO DO: Show about the app dialog
            },
          ),
        ],
      ),
    );
  }
}
