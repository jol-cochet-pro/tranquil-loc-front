import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-state-cell.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Occupant {
  final String id;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final bool hasIncomeFilled;
  final bool hasPersonalInfoFilled;
  final bool hasEmailFilled;
  final bool hasPhoneFilled;
  final bool hasAllDocumentsFilled;

  Occupant({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.hasIncomeFilled,
    required this.hasPersonalInfoFilled,
    required this.hasEmailFilled,
    required this.hasPhoneFilled,
    required this.hasAllDocumentsFilled,
  });
}

class OccupantsCard extends StatelessWidget {
  final List<Occupant> occupants = [
    // Occupant(
    //   id: "1",
    //   firstname: "Jolan",
    //   lastname: "Cochet",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   hasIncomeFilled: true,
    //   hasPersonalInfoFilled: false,
    //   hasEmailFilled: true,
    //   hasPhoneFilled: true,
    //   hasAllDocumentsFilled: false,
    // ),
    // Occupant(
    //   id: "2",
    //   firstname: "Mael",
    //   lastname: "Pendilhas",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   hasIncomeFilled: true,
    //   hasPersonalInfoFilled: false,
    //   hasEmailFilled: true,
    //   hasPhoneFilled: true,
    //   hasAllDocumentsFilled: false,
    // ),
    // Occupant(
    //   id: "2",
    //   firstname: "Eliot",
    //   lastname: "Blondeel",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   hasIncomeFilled: true,
    //   hasPersonalInfoFilled: false,
    //   hasEmailFilled: true,
    //   hasPhoneFilled: true,
    //   hasAllDocumentsFilled: false,
    // ),
    // Occupant(
    //   id: "2",
    //   firstname: "Kakou",
    //   lastname: "Kakou",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   hasIncomeFilled: true,
    //   hasPersonalInfoFilled: false,
    //   hasEmailFilled: true,
    //   hasPhoneFilled: true,
    //   hasAllDocumentsFilled: false,
    // ),
  ];

  OccupantsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return DashCard(
      title: locale.future_occupants,
      emptyInfo: locale.no_future_occupants_saved,
      onAdd: () {
        print("add occupant.");
      },
      items: occupants,
      itemBuilder:
          (context, index) => ShadowContainer(
            radius: Radius.circular(10),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${occupants[index].firstname} ${occupants[index].lastname}",
                        overflow: TextOverflow.ellipsis,
                        style: h3,
                      ),
                      Text(
                        formatter.format(occupants[index].dateOfBirth),
                        overflow: TextOverflow.ellipsis,
                        style: p2,
                      ),
                    ],
                  ),
                ),
                DashStateCell(
                  first: StateStatus(
                    iconData: Icons.euro_outlined,
                    isCompleted: occupants[index].hasIncomeFilled,
                  ),
                  second: StateStatus(
                    iconData: Icons.person_outline,
                    isCompleted: occupants[index].hasPersonalInfoFilled,
                  ),
                ),
                DashStateCell(
                  first: StateStatus(
                    iconData: Icons.drafts_outlined,
                    isCompleted: occupants[index].hasEmailFilled,
                  ),
                  second: StateStatus(
                    iconData: Icons.call_outlined,
                    isCompleted: occupants[index].hasPhoneFilled,
                  ),
                ),
                DashStateCell(
                  first: StateStatus(
                    iconData: Icons.folder_outlined,
                    isCompleted: occupants[index].hasAllDocumentsFilled,
                  ),
                ),
                CustomIconButton(
                  onPressed: () {
                    print("id of the occupant: ${occupants[index].id}");
                  },
                  icon: Icons.settings_outlined,
                ),
              ],
            ),
          ),
    );
  }
}
