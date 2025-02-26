import 'package:dossier_locataire/pages/dashboard/candidate-dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/shares-dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/warrantor-dash-card.dart';
import 'package:flutter/material.dart';

class DashCards extends StatelessWidget {
  const DashCards({super.key});

  @override
  Widget build(BuildContext context) {
    double screenRatio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    double aspectRatio =
        MediaQuery.of(context).size.width < 1008
            ? screenRatio * 3.75
            : screenRatio * 1.75;
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width < 1008 ? 1 : 2,
      childAspectRatio: aspectRatio,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [CandidatesCard(), WarrantorsCard(), SharesCard()],
    );
  }
}
