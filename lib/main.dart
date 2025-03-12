import 'package:dossier_locataire/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF007BFF),
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      tertiary: Color(0xFF0A9A00),
      onTertiary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Color(0xFFFF5252),
      onError: Colors.white,
      outline: Color(0xFFB0BEC5),
      onSurfaceVariant: Color(0xFFB0BEC5),
      shadow: Color(0x40AEAEAE),
    );

    return MaterialApp.router(
      title: 'Dossier locataire',
      routerConfig: router,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fr'), // French
        Locale('en'), // English
      ],

      theme: ThemeData(
        fontFamily: "Inter",
        fontFamilyFallback: ["Inter"],
        colorScheme: colorScheme,
      ),
    );
  }
}
