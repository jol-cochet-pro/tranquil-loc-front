import 'package:dossier_locataire/pages/dashboard/dash-cards.dart';
import 'package:dossier_locataire/pages/dashboard/hero-section.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [HeroSection(), Expanded(flex: 1, child: DashCards())],
    );
  }
}
