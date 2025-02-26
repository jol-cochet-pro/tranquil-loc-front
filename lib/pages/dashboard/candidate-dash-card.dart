import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-state-cell.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Candidate {
  final String id;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final bool hasIncomeFilled;
  final bool hasPersonalInfoFilled;
  final bool hasEmailFilled;
  final bool hasPhoneFilled;
  final bool hasAllDocumentsFilled;

  Candidate({
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

class CandidatesCard extends StatelessWidget {
  final List<Candidate> candidates = [
    Candidate(
      id: "1",
      firstname: "Jolan",
      lastname: "Cochet",
      dateOfBirth: DateTime(2003, 3, 27),
      hasIncomeFilled: true,
      hasPersonalInfoFilled: false,
      hasEmailFilled: true,
      hasPhoneFilled: true,
      hasAllDocumentsFilled: false,
    ),
    Candidate(
      id: "2",
      firstname: "Mael",
      lastname: "Pendhillas",
      dateOfBirth: DateTime(2003, 3, 27),
      hasIncomeFilled: true,
      hasPersonalInfoFilled: false,
      hasEmailFilled: true,
      hasPhoneFilled: true,
      hasAllDocumentsFilled: false,
    ),
    Candidate(
      id: "2",
      firstname: "Eliot",
      lastname: "Blondeel",
      dateOfBirth: DateTime(2003, 3, 27),
      hasIncomeFilled: true,
      hasPersonalInfoFilled: false,
      hasEmailFilled: true,
      hasPhoneFilled: true,
      hasAllDocumentsFilled: false,
    ),
    Candidate(
      id: "2",
      firstname: "Kakou",
      lastname: "Kakou",
      dateOfBirth: DateTime(2003, 3, 27),
      hasIncomeFilled: true,
      hasPersonalInfoFilled: false,
      hasEmailFilled: true,
      hasPhoneFilled: true,
      hasAllDocumentsFilled: false,
    ),
  ];

  CandidatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return DashCard(
      title: "Candidat",
      onAdd: () {
        print("add candidate.");
      },
      items: candidates,
      itemBuilder:
          (context, index) => ShadowContainer(
            radius: Radius.circular(10),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${candidates[index].firstname} ${candidates[index].lastname}",
                      overflow: TextOverflow.ellipsis,
                      style: h3,
                    ),
                    Text(
                      formatter.format(candidates[index].dateOfBirth),
                      overflow: TextOverflow.ellipsis,
                      style: p2,
                    ),
                  ],
                ),
                DashStateCell(
                  first: StateStatus(
                    iconData: Icons.euro_outlined,
                    isCompleted: candidates[index].hasIncomeFilled,
                  ),
                  second: StateStatus(
                    iconData: Icons.person_outline,
                    isCompleted: candidates[index].hasPersonalInfoFilled,
                  ),
                ),
                DashStateCell(
                  first: StateStatus(
                    iconData: Icons.drafts_outlined,
                    isCompleted: candidates[index].hasEmailFilled,
                  ),
                  second: StateStatus(
                    iconData: Icons.call_outlined,
                    isCompleted: candidates[index].hasPhoneFilled,
                  ),
                ),
                DashStateCell(
                  first: StateStatus(
                    iconData: Icons.folder_outlined,
                    isCompleted: candidates[index].hasAllDocumentsFilled,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("id of the candidate: ${candidates[index].id}");
                  },
                  icon: Icon(Icons.settings_outlined),
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(color: Color(0xFFF1F5F9)),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
