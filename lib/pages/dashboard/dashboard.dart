import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/dashboard/call_to_action.dart';
import 'package:dossier_locataire/pages/dashboard/dash_cards.dart';
import 'package:dossier_locataire/pages/dashboard/hero_section.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const route = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [HeroSection(), CallToAction(), DashCards()],
        ),
      ),
    );
  }
}
