import 'package:dossier_locataire/components/navbar.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dossier locataire',
      home: const MyHomePage(),
      theme: ThemeData(
        fontFamily: "Inter",
        fontFamilyFallback: ["Inter"],
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0B74E7),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red[100]!,
          onError: Colors.red,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/background_desktop.png'),
            fit: BoxFit.fill,
          ),
          Positioned(top: 12, left: 24, right: 24, child: Navbar()),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 74, bottom: 24),
            child: Dashboard(),
          ),
        ],
      ),
    );
  }
}
