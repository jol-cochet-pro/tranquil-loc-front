import 'package:tranquil_loc/components/icon_button.dart';
import 'package:tranquil_loc/components/icon_with_state.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/components/person/person_info_card.dart';
import 'package:tranquil_loc/pages/occupants/update_occupant.dart';
import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/person.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final bool isSmall;

  const PersonCard({super.key, required this.person, this.isSmall = false});

  int getAge(DateTime dateOfBirth) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(dateOfBirth);
    return (duration.inDays / 365.25).toInt();
  }

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
                  Text("${person.firstname} ${person.lastname}", style: h3),
                  Text(
                    "${formatter.format(person.dateOfBirth)} - ${getAge(person.dateOfBirth)} ans",
                    style: p2,
                  ),
                ],
              ),
              if (!isSmall)
                CustomIconButton(
                  onPressed: () {
                    context.go(UpdateOccupant.routeId(person.id));
                  },
                  icon: Icons.settings_outlined,
                ),
            ],
          ),
          PersonInfoCard(
            first: PersonInfo(
              icon: Icons.euro_outlined,
              name: locale.monthly_income,
              info: "${person.income}€ / ${locale.months}",
            ),
            second: PersonInfo(
              icon: Icons.person_outline,
              name: locale.situation,
              info: person.proSituation.locale(locale),
            ),
            title: locale.pro_situation,
            isSmall: isSmall,
          ),
          PersonInfoCard(
            first: PersonInfo(
              icon: Icons.email_outlined,
              name: locale.email,
              info: person.email,
            ),
            second: PersonInfo(
              icon: Icons.phone_outlined,
              name: locale.phone,
              info: person.phone,
            ),
            title: locale.contact_details,
            isSmall: isSmall,
          ),
          if (!isSmall)
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${locale.documents}:", style: h4),
                  if (person.documents.isNotEmpty)
                    Expanded(
                      child: ShadowContainer(
                        padding: EdgeInsets.all(10),
                        radius: Radius.circular(10),
                        child: SingleChildScrollView(
                          child: Wrap(
                            runSpacing: 4,
                            children:
                                person.documents.entries.map((entry) {
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
          if (!isSmall)
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithState(
                  state: person.isCompleted ? IconState.valid : IconState.wrong,
                ),
                Text(
                  person.isCompleted ? locale.complete : locale.incomplete,
                  style: TextStyle(
                    color:
                        person.isCompleted
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
