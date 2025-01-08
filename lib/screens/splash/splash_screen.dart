import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';  

import '../dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
          useImmersiveMode: true,
          duration: const Duration(milliseconds: 2000),
          nextScreen: const DashboardScreen(),
          backgroundColor: Colors.white,
          splashScreenBody: Center(
            child: Lottie.asset(
              "assets/lottie_loading_2.json",
              repeat: false,
            ),
          ),
        );
  }
}

