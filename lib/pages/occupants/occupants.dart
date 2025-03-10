import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/occupants/components/occupant-card.dart';
import 'package:dossier_locataire/shared/scroll-controller.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProSituation {
  cdd,
  cdi,
  retired,
  coopStudent,
  unemployed,
  student,
  official,
  freelance,
  none,
}

class Document {
  final String name;
  final String? url;

  const Document({required this.name, this.url});
}

class Occupant {
  final String id;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final int income;
  final ProSituation proSituation;
  final String email;
  final String phone;
  final List<Document> documents;

  Occupant({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.income,
    required this.proSituation,
    required this.email,
    required this.phone,
    required this.documents,
  });

  String getProSituation(AppLocalizations locale) {
    switch (proSituation) {
      case ProSituation.cdd:
        return locale.cdd;
      case ProSituation.cdi:
        return locale.cdi;
      case ProSituation.retired:
        return locale.retired;
      case ProSituation.coopStudent:
        return locale.coopStudent;
      case ProSituation.unemployed:
        return locale.unemployed;
      case ProSituation.student:
        return locale.student;
      case ProSituation.official:
        return locale.official;
      case ProSituation.freelance:
        return locale.freelance;
      case ProSituation.none:
        return "";
    }
  }

  bool getIsCompleted() {
    return (email.isNotEmpty &&
        phone.isNotEmpty &&
        !documents.any((document) => document.url == null));
  }

  bool getInfoCompleted(String info) {
    switch (info) {
      case "hasIncomeFilled":
        return income != 0;
      case "hasPersonalInfoFilled":
        return firstname != "" && lastname != "";
      case "hasEmailFilled":
        return email != "";
      case "hasPhoneFilled":
        return phone != "";
      case "hasAllDocumentsFilled":
        return !documents.any((document) => document.url == null);
      default:
        return false;
    }
  }
}

class Occupants extends StatefulWidget {
  const Occupants({super.key});

  static const route = '/occupants';

  @override
  State<Occupants> createState() => _OccupantsState();
}

class _OccupantsState extends State<Occupants> {
  double oldPosition = 0.0;
  final List<Occupant> occupants = [
    Occupant(
      id: "1",
      firstname: "Jolan",
      lastname: "Cochet",
      dateOfBirth: DateTime(2003, 3, 27),
      income: 1000,
      proSituation: ProSituation.cdd,
      email: "jolan.cochet@gmail.com",
      phone: "+33695243465",
      documents: [
        Document(name: "Carte d'identité", url: null),
        Document(
          name: "Bulletins de salaires",
          url: "https://pdfobject.com/pdf/sample.pdf",
        ),
        Document(name: "Justificatif de domicile", url: null),
        Document(
          name: "Avis d'imposition",
          url: "https://pdfobject.com/pdf/sample.pdf",
        ),
      ],
    ),
    // Occupant(
    //   id: "1",
    //   firstname: "Jolan",
    //   lastname: "Cochet",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   income: 1000,
    //   proSituation: ProSituation.cdd,
    //   email: "jolan.cochet@gmail.com",
    //   phone: "+33695243465",
    //   documents: [
    //     Document(name: "Carte d'identité", url: null),
    //     Document(
    //       name: "Bulletins de salaires",
    //       url: "https://pdfobject.com/pdf/sample.pdf",
    //     ),
    //     Document(name: "Justificatif de domicile", url: null),
    //     Document(
    //       name: "Avis d'imposition",
    //       url: "https://pdfobject.com/pdf/sample.pdf",
    //     ),
    //   ],
    // ),
    // Occupant(
    //   id: "1",
    //   firstname: "Jolan",
    //   lastname: "Cochet",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   income: 1000,
    //   proSituation: ProSituation.cdd,
    //   email: "jolan.cochet@gmail.com",
    //   phone: "+33695243465",
    //   documents: [
    //     Document(name: "Carte d'identité", url: null),
    //     Document(
    //       name: "Bulletins de salaires",
    //       url: "https://pdfobject.com/pdf/sample.pdf",
    //     ),
    //     Document(name: "Justificatif de domicile", url: null),
    //     Document(
    //       name: "Avis d'imposition",
    //       url: "https://pdfobject.com/pdf/sample.pdf",
    //     ),
    //   ],
    // ),
    // Occupant(
    //   id: "1",
    //   firstname: "Jolan",
    //   lastname: "Cochet",
    //   dateOfBirth: DateTime(2003, 3, 27),
    //   income: 1000,
    //   proSituation: ProSituation.cdd,
    //   email: "jolan.cochet@gmail.com",
    //   phone: "+33695243465",
    //   documents: [
    //     Document(name: "Carte d'identité", url: null),
    //     Document(
    //       name: "Bulletins de salaires",
    //       url: "https://pdfobject.com/pdf/sample.pdf",
    //     ),
    //     Document(name: "Justificatif de domicile", url: null),
    //     Document(
    //       name: "Avis d'imposition",
    //       url: "https://pdfobject.com/pdf/sample.pdf",
    //     ),
    //   ],
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return PageLayout(
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadowContainer(
            radius: Radius.circular(10),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(locale.future_occupants, style: h1),
                CustomButton(
                  onPressed: () {
                    print("add occupant.");
                  },
                  type: ButtonType.primary,
                  padding: EdgeInsets.all(16),
                  child: Text(locale.add_future_occupant),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                occupants.isNotEmpty
                    ? ScrollConfiguration(
                      behavior: DragScrollBehavior(),
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: occupants.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) =>
                                OccupantCard(occupant: occupants[index]),
                        separatorBuilder:
                            (context, index) => SizedBox(width: 24),
                      ),
                    )
                    : Center(
                      child: ShadowContainer(
                        radius: Radius.circular(10),
                        child: Column(
                          children: [
                            Image(image: AssetImage("assets/empty_list.png")),
                            Text(locale.no_future_occupants_saved, style: p1),
                          ],
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
