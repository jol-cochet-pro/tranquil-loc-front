import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/icon-ok-not-ok.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/occupants/components/occupant-info-card.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../occupants.dart';

class OccupantCard extends StatelessWidget {
  final Occupant occupant;

  const OccupantCard({super.key, required this.occupant});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd/MM/yyy");
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ShadowContainer(
      constraints: BoxConstraints.loose(Size(500, double.infinity)),
      radius: Radius.circular(10),
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${occupant.firstname} ${occupant.lastname}", style: h2),
                  Text(formatter.format(occupant.dateOfBirth), style: p1),
                ],
              ),
              CustomIconButton(
                onPressed: () {
                  print("settings.");
                },
                icon: Icons.settings_outlined,
              ),
            ],
          ),
          OccupantInfoCard(
            first: OccupantInfo(
              icon: Icons.euro_outlined,
              name: "Revenus mensuel",
              info: "${occupant.income}€ / mois",
            ),
            second: OccupantInfo(
              icon: Icons.person_outline,
              name: "Situation",
              info: occupant.getProSituation(),
            ),
            title: "Situation professionnelle",
          ),
          OccupantInfoCard(
            first: OccupantInfo(
              icon: Icons.email_outlined,
              name: "Email",
              info: occupant.email,
            ),
            second: OccupantInfo(
              icon: Icons.phone_outlined,
              name: "Téléphone",
              info: occupant.phone,
            ),
            title: "Coordonnées",
          ),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Documents:", style: h3),
                Expanded(
                  child: ShadowContainer(
                    padding: EdgeInsets.all(10),
                    radius: Radius.circular(10),
                    child: Wrap(
                      runSpacing: 4,
                      children:
                          occupant.documents.map((document) {
                            return Row(
                              spacing: 4,
                              children: [
                                IconOkNoOk(isOk: document.url != null),
                                Text(document.name, style: p2),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconOkNoOk(isOk: occupant.getIsCompleted()),
              Text(
                occupant.getIsCompleted() ? "Complet" : "Incomplet",
                style: TextStyle(
                  color:
                      occupant.getIsCompleted()
                          ? colorScheme.tertiary
                          : colorScheme.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
