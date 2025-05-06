import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/landing/components/landing_call_to_action.dart';
import 'package:dossier_locataire/pages/landing/components/landing_description.dart';
import 'package:dossier_locataire/pages/landing/components/landing_navbar.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  static final route = "/landing-page";

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      hideNavbar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 32,
        children: [
          LandingNavbar(),
          LandingCallToAction(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 12,
            children: [
              LandingDescription(text: "Dossier complet en\nquelques minutes"),
              LandingDescription(text: "Mise à jour facile de\nvos documents"),
              LandingDescription(
                text: "Partage sécurisé avec\nles propriétaires",
              ),
              LandingDescription(
                text: "Conformes aux\nexigences des\nbailleurs",
              ),
              LandingDescription(text: "Gagnez du temps à\nchaque candidature"),
            ],
          ),
        ],
      ),
    );
  }
}
