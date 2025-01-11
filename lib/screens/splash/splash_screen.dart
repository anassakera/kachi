import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../auth/Signup/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      useImmersiveMode: true,
      duration: const Duration(milliseconds: 2000),
      nextScreen: const SignUpScreen(),
      backgroundColor: Colors.white,
      splashScreenBody: Center(
        child: Lottie.asset(
          "assets/lottie_loading.json",
          repeat: false,
        ),
      ),
    );
  }
}
