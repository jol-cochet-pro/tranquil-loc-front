import 'package:tranquil_loc/components/icon_button.dart';
import 'package:tranquil_loc/components/icon_with_state.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/pages/occupants/components/occupant_info_card.dart';
import 'package:tranquil_loc/pages/occupants/update_occupant.dart';
import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/occupant.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

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
                  Text("${occupant.firstname} ${occupant.lastname}", style: h3),
                  Text(formatter.format(occupant.dateOfBirth), style: p2),
                ],
              ),
              CustomIconButton(
                onPressed: () {
                  context.go(UpdateOccupant.routeId(occupant.id));
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
                Text("${locale.documents}:", style: h4),
                if (occupant.documents.isNotEmpty)
                  Expanded(
                    child: ShadowContainer(
                      padding: EdgeInsets.all(10),
                      radius: Radius.circular(10),
                      child: SingleChildScrollView(
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
                                    Text(
                                      DocumentType.values
                                          .byName(entry.key)
                                          .locale(locale),
                                      style: p3,
                                    ),
                                  ],
                                );
                              }).toList(),
                        ),
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
                state: occupant.isCompleted ? IconState.valid : IconState.wrong,
              ),
              Text(
                occupant.isCompleted ? locale.complete : locale.incomplete,
                style: TextStyle(
                  color:
                      occupant.isCompleted
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
