import 'package:dossier_locataire/pages/dashboard/components/action-button.dart';
import 'package:dossier_locataire/pages/dashboard/components/action-card.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class CallToAction extends StatefulWidget {
  const CallToAction({super.key});

  @override
  State<CallToAction> createState() => _CallToActionState();
}

class _CallToActionState extends State<CallToAction> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        ActionCard(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pourcentage de mail ouverts", style: p1),
              Expanded(
                child: Row(
                  spacing: 24,
                  children: [
                    Icon(Icons.mark_email_read_outlined),
                    Text("80%", style: h2),
                  ],
                ),
              ),
            ],
          ),
        ),
        MediaQuery.of(context).size.width > 1008
            ? ActionCard(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      print("Share profile.");
                    },
                    child: Text("Partager mon dossier"),
                  ),
                  ActionButton(
                    color: Color(0xFF0A9A00),
                    onPressed: () {
                      print("Found flat.");
                    },
                    child: Text("J'ai trouvé un appartement"),
                  ),
                ],
              ),
            )
            : SizedBox.shrink(),
        ActionCard(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("État recherche", style: p1),
              Expanded(
                child: Row(
                  spacing: 24,
                  children: [
                    Icon(Icons.task_alt_outlined, color: Color(0xFF0A9A00)),
                    Text("En recherche", style: h2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
