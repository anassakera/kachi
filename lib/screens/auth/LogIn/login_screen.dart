import 'package:flutter/material.dart';
import 'desktop_login_screen.dart';
import 'mobile_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          mobileLayout: MobileLoginScreen(),
          desktopLayout: DesktopLoginScreen(),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const ResponsiveLayout(
      {super.key, required this.mobileLayout, required this.desktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 710) {
          return mobileLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}

