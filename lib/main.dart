import 'package:dossier_locataire/pages/auth/forgot-password.dart';
import 'package:dossier_locataire/pages/auth/login.dart';
import 'package:dossier_locataire/pages/auth/register.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting("fr_FR").then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String? redirectLoggedIn(BuildContext context, GoRouterState state) {
    return FirebaseAuth.instance.currentUser != null ? Dashboard.route : null;
  }

  String? redirectLoggedOut(BuildContext context, GoRouterState state) {
    return FirebaseAuth.instance.currentUser == null ? Login.route : null;
  }

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
    final GoRouter router = GoRouter(
      initialLocation: Login.route,
      routes: [
        GoRoute(path: '/', redirect: (context, _) => Login.route),
        GoRoute(
          path: Dashboard.route,
          builder: (_, _) => Dashboard(),
          redirect: redirectLoggedOut,
        ),
        GoRoute(
          path: Warrantors.route,
          builder: (_, _) => Warrantors(),
          redirect: redirectLoggedOut,
        ),
        GoRoute(
          path: Occupants.route,
          builder: (_, _) => Occupants(),
          redirect: redirectLoggedOut,
        ),
        GoRoute(
          path: Login.route,
          builder: (_, _) => Login(),
          redirect: redirectLoggedIn,
        ),
        GoRoute(
          path: Register.route,
          builder: (_, _) => Register(),
          redirect: redirectLoggedIn,
        ),
        GoRoute(
          path: ForgotPassword.route,
          builder: (_, _) => ForgotPassword(),
          redirect: redirectLoggedIn,
        ),
      ],
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
