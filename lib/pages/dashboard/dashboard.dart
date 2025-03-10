import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/dashboard/call-to-action.dart';
import 'package:dossier_locataire/pages/dashboard/dash-cards.dart';
import 'package:dossier_locataire/pages/dashboard/hero-section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  static Future<DashboardData> fromSnapshot(
    Future<DocumentSnapshot<Map<String, dynamic>>> data,
  ) {
    return data.then(
      (value) => DashboardData(
        firstname: value["firstname"],
        opennedMail: value["opennedMail"],
        searchState: value["searchState"],
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const route = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<DashboardData> dashboardData;
  @override
  void initState() {
    var data =
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    dashboardData = DashboardData.fromSnapshot(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: dashboardData,
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
