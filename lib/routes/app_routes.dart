import 'package:flutter/material.dart';
import '../screens/auth/LogIn/login_screen.dart';
import '../screens/auth/Signup/signup_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/dashboard/table_add_check.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  // Auth Routes
  static const String auth = '/auth';
  static const String register = '/auth/register';

  // Main Routes
  static const String splashScreen = '/';
  static const String dashboard = '/dashboard';
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
      splashScreen: (context) => const SplashScreen(),
      auth: (context) => const LoginScreen(),
      register: (context) => const SignUpScreen(),
      dashboard: (context) => const DashboardScreen(),
      tableAddCheck: (context) => const TableAddCheck(),
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
