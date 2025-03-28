import 'firebase_options_dev.dart' as dev;
import 'firebase_options_dev.dart' as prod;
import 'package:dossier_locataire/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'PRODUCTION',
  );
  try {
    await Firebase.initializeApp(
      options:
          environment == 'PRODUCTION'
              ? await prod.DefaultFirebaseOptions.currentPlatform
              : environment == 'DEVELOPMENT'
              ? await dev.DefaultFirebaseOptions.currentPlatform
              : null,
    );
  } catch (exception) {
    if (exception is FirebaseException && exception.code == 'duplicate-app') {
      debugPrint(
        "Did you forget to recompile the Runner app, after changing environments?",
      );
    }
    rethrow;
  }
  WidgetsFlutterBinding.ensureInitialized();
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
      title: "Tranquil'loc",
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
