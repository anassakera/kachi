import 'package:flutter/material.dart';
import '../screens/auth/LogIn/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/checks/check_list_screen.dart';
import '../screens/checks/add_check_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/user_management_screen.dart';
import '../screens/dashboard/table_add_check.dart';

class AppRoutes {
  // static const String login = '/login';
  static const String signUp = '/register';
  static const String dashboard = '/dashboard';
  static const String tableAddCheck = '/tableAddCheck';
  static const String analytics = '/analytics';
  static const String checkList = '/checks';
  static const String addCheck = '/checks/add';
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String userManagement = '/settings/users';
  static const String loginScreen = '/auth';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      signUp: (context) => const MobileSignUpScreen(),
      dashboard: (context) => const DashboardScreen(),
      analytics: (context) => const AnalyticsScreen(),
      checkList: (context) => const CheckListScreen(),
      addCheck: (context) => const AddCheckScreen(),
      reports: (context) => const ReportsScreen(),
      settings: (context) => const SettingsScreen(),
      userManagement: (context) => const UserManagementScreen(),
      loginScreen: (context) => const LoginScreen(),
      tableAddCheck: (context) => const EditableTableScreen(),
    };
  }
}
