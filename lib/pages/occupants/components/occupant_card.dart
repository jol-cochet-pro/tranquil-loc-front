import 'package:dossier_locataire/components/icon_button.dart';
import 'package:dossier_locataire/components/icon_with_state.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/pages/occupants/components/occupant_info_card.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OccupantCard extends StatelessWidget {
  final Occupant occupant;

  const OccupantCard({super.key, required this.occupant});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd/MM/yyy");
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AppLocalizations locale = AppLocalizations.of(context)!;
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
                  // TODO ADD THIS
                },
                icon: Icons.settings_outlined,
              ),
            ],
          ),
          OccupantInfoCard(
            first: OccupantInfo(
              icon: Icons.euro_outlined,
              name: locale.monthly_income,
              info: "${occupant.income}€ / ${locale.months}",
            ),
            second: OccupantInfo(
              icon: Icons.person_outline,
              name: locale.situation,
              info: occupant.proSituation.locale(locale),
            ),
            title: locale.pro_situation,
          ),
          OccupantInfoCard(
            first: OccupantInfo(
              icon: Icons.email_outlined,
              name: locale.email,
              info: occupant.email,
            ),
            second: OccupantInfo(
              icon: Icons.phone_outlined,
              name: locale.phone,
              info: occupant.phone,
            ),
            title: locale.contact_details,
          ),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${locale.documents}:", style: h3),
                if (occupant.documents.isNotEmpty)
                  Expanded(
                    child: ShadowContainer(
                      padding: EdgeInsets.all(10),
                      radius: Radius.circular(10),
                      child: Wrap(
                        runSpacing: 4,
                        children:
                            occupant.documents.entries.map((entry) {
                              return Row(
                                spacing: 4,
                                children: [
                                  IconWithState(
                                    state:
                                        entry.value.isNotEmpty
                                            ? IconState.valid
                                            : IconState.wrong,
                                  ),
                                  Text(entry.key, style: p2),
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
              IconWithState(
                state:
                    occupant.getIsCompleted()
                        ? IconState.valid
                        : IconState.wrong,
              ),
              Text(
                occupant.getIsCompleted() ? locale.complete : locale.incomplete,
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
