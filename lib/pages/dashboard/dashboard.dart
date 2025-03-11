import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/dashboard/call-to-action.dart';
import 'package:dossier_locataire/pages/dashboard/dash-cards.dart';
import 'package:dossier_locataire/pages/dashboard/hero-section.dart';
import 'package:dossier_locataire/shared/models/dashboard-data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    dashboardData = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
          fromFirestore:
              (snapshot, _) => DashboardData.fromFirestore(snapshot.data()),
          toFirestore:
              (dashboardData, _) => DashboardData.toFirestore(dashboardData),
        )
        .get()
        .then((value) => value.data()!);
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
