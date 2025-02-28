import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting("fr_FR").then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dossier locataire',
      initialRoute: "/occupants",
      routes: {
        "/dashboard": (_) => const Dashboard(),
        "/garants": (_) => const Warrantors(),
        "/occupants": (_) => const Occupants(),
      },
      theme: ThemeData(
        fontFamily: "Inter",
        fontFamilyFallback: ["Inter"],
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0B74E7),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Color(0xFFDF1A1A),
          onError: Color(0xFFDF1A1A),
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
    );
  }
}
