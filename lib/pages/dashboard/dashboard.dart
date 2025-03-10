import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/dashboard/call-to-action.dart';
import 'package:dossier_locataire/pages/dashboard/dash-cards.dart';
import 'package:dossier_locataire/pages/dashboard/hero-section.dart';
import 'package:flutter/material.dart';

enum SearchState { searching, paused }

class DashboardData {
  final String firstname;
  final int opennedMail;
  final SearchState searchState;

  const DashboardData({
    required this.firstname,
    required this.opennedMail,
    required this.searchState,
  });
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const route = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<DashboardData> data = Future.delayed(
    Duration(seconds: 1),
    () => DashboardData(
      firstname: "Jolan",
      opennedMail: 80,
      searchState: SearchState.searching,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: data,
          builder:
              (context, snapshot) => Column(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeroSection(snapshot: snapshot),
                  CallToAction(snapshot: snapshot),
                  DashCards(),
                ],
              ),
        ),
      ),
    );
  }
}
