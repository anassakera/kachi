import 'package:flutter/material.dart';
import '../screens/auth/LogIn/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/user_management_screen.dart';
import '../screens/dashboard/table_add_check.dart';

class AppRoutes {
  // Auth Routes
  static const String auth = '/auth';
  static const String register = '/auth/register';

  // Main Routes
  static const String dashboard = '/';
  static const String tableAddCheck = '/table-add-check';
  static const String analytics = '/analytics';

  // Checks Routes
  static const String checks = '/checks';
  static const String addCheck = '/checks/add';

  // Settings Routes
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String users = '/settings/users';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      auth: (context) => const LoginScreen(),
      register: (context) => const MobileSignUpScreen(),
      dashboard: (context) => const DashboardScreen(),
      settings: (context) => const SettingsScreen(),
      users: (context) => const UserManagementScreen(),
      tableAddCheck: (context) => const EditableTableScreen(),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('الصفحة غير موجودة: ${settings.name}'),
        ),
      ),
    );
  }
}
