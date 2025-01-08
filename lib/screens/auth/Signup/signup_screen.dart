import 'package:flutter/material.dart';
import 'package:kachi/screens/auth/Signup/desktop_signup_screen.dart';
import 'desktop_signUp_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          mobileLayout: MobileSignUpScreen(),
          desktopLayout: DesktopSignUpScreen(),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.desktopLayout,
  });

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
