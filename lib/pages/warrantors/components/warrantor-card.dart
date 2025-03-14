import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/icon-with-state.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/warrantors/components/warrantor-info-card.dart';
import 'package:dossier_locataire/shared/enums/pro-situation.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WarrantorCard extends StatelessWidget {
  final Warrantor warrantor;

  const WarrantorCard({super.key, required this.warrantor});

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
                  Text(
                    "${warrantor.firstname} ${warrantor.lastname}",
                    style: h2,
                  ),
                  Text(formatter.format(warrantor.dateOfBirth), style: p1),
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
          WarrantorInfoCard(
            first: WarrantorInfo(
              icon: Icons.euro_outlined,
              name: locale.monthly_income,
              info: "${warrantor.income}€ / ${locale.months}",
            ),
            second: WarrantorInfo(
              icon: Icons.person_outline,
              name: locale.situation,
              info: warrantor.proSituation.locale(locale),
            ),
            title: locale.pro_situation,
          ),
          WarrantorInfoCard(
            first: WarrantorInfo(
              icon: Icons.email_outlined,
              name: locale.email,
              info: warrantor.email,
            ),
            second: WarrantorInfo(
              icon: Icons.phone_outlined,
              name: locale.phone,
              info: warrantor.phone,
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
                Expanded(
                  child: ShadowContainer(
                    padding: EdgeInsets.all(10),
                    radius: Radius.circular(10),
                    child: Wrap(
                      runSpacing: 4,
                      children:
                          warrantor.documents.entries.map((entry) {
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
                    warrantor.getIsCompleted()
                        ? IconState.valid
                        : IconState.wrong,
              ),
              Text(
                warrantor.getIsCompleted()
                    ? locale.complete
                    : locale.incomplete,
                style: TextStyle(
                  color:
                      warrantor.getIsCompleted()
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
