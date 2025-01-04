import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constant/app_theme.dart';
import 'constant/constants.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Constants.supportedLanguages.map(
        (lang) => Locale(lang),
      ),
      initialRoute: AppRoutes.dashboard,
      routes: AppRoutes.getRoutes(),
      onUnknownRoute: AppRoutes.onGenerateRoute,
    );
  }
}
