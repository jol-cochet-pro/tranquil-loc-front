import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/dashboard/call_to_action.dart';
import 'package:dossier_locataire/pages/dashboard/dash_cards.dart';
import 'package:dossier_locataire/pages/dashboard/hero_section.dart';
import 'package:dossier_locataire/shared/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const route = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<User> dashboardData;

  Future<User> retrieveData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
          fromFirestore: (snapshot, _) => User.fromFirestore(snapshot.data()),
          toFirestore: (dashboardData, _) => User.toFirestore(dashboardData),
        )
        .get()
        .then((value) => value.data()!);
  }

  @override
  void initState() {
    dashboardData = retrieveData();
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
                  CallToAction(
                    snapshot: snapshot,
                    reload:
                        () => setState(() => dashboardData = retrieveData()),
                  ),
                  DashCards(),
                ],
              ),
        ),
      ),
    );
  }
}
