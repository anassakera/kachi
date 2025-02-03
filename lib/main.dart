import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kachi/invoice.dart';
import 'constant/app_theme.dart';
import 'constant/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: 'https://alrsbtwzpqqyiuxokwwp.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFscnNidHd6cHFxeWl1eG9rd3dwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxNjI4ODIsImV4cCI6MjA1MTczODg4Mn0.rTxpOP5MAikTtNSoZf9CO3lJ5V91hAIgSj4crfGmAYY',
  // );

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
      home: const InvoiceCreateScreen(),
      // initialRoute: AppRoutes.splashScreen,
      // routes: AppRoutes.getRoutes(),
      // onUnknownRoute: AppRoutes.onGenerateRoute,
    );
  }
}
