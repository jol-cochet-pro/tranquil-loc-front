import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-state-cell.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WarrantorsCard extends StatefulWidget {
  const WarrantorsCard({super.key});

  @override
  State<WarrantorsCard> createState() => _WarrantorsCardState();
}

class _WarrantorsCardState extends State<WarrantorsCard> {
  late Future<List<Warrantor>> warrantors;

  @override
  void initState() {
    warrantors = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("warrantors")
        .withConverter(
          fromFirestore:
              (snapshot, _) => Warrantor.fromFirestore(snapshot.data()),
          toFirestore: (occupant, _) => Warrantor.toFirestore(occupant),
        )
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return FutureBuilder(
      future: warrantors,
      builder:
          (context, snapshot) => DashCard(
            title: locale.warrantors,
            emptyInfo: locale.no_warrantors_saved,
            onAdd: () {
              print("add Warrantor.");
            },
            hasData: snapshot.hasData,
            items: snapshot.data,
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
                              "${snapshot.data![index].firstname} ${snapshot.data![index].lastname}",
                              overflow: TextOverflow.ellipsis,
                              style: h3,
                            ),
                            Text(
                              formatter.format(
                                snapshot.data![index].dateOfBirth,
                              ),
                              overflow: TextOverflow.ellipsis,
                              style: p2,
                            ),
                          ],
                        ),
                      ),
                      DashStateCell(
                        first: StateStatus(
                          iconData: Icons.euro_outlined,
                          isCompleted: snapshot.data![index].getInfoCompleted(
                            "hasIncomeFilled",
                          ),
                        ),
                        second: StateStatus(
                          iconData: Icons.person_outline,
                          isCompleted: snapshot.data![index].getInfoCompleted(
                            "hasPersonalInfoFilled",
                          ),
                        ),
                      ),
                      DashStateCell(
                        first: StateStatus(
                          iconData: Icons.drafts_outlined,
                          isCompleted: snapshot.data![index].getInfoCompleted(
                            "hasEmailFilled",
                          ),
                        ),
                        second: StateStatus(
                          iconData: Icons.call_outlined,
                          isCompleted: snapshot.data![index].getInfoCompleted(
                            "hasPhoneFilled",
                          ),
                        ),
                      ),
                      DashStateCell(
                        first: StateStatus(
                          iconData: Icons.folder_outlined,
                          isCompleted: snapshot.data![index].getInfoCompleted(
                            "hasAllDocumentsFilled",
                          ),
                        ),
                      ),
                      CustomIconButton(
                        onPressed: () {
                          print(
                            "id of the Warrantor: ${snapshot.data![index].firstname}",
                          );
                        },
                        icon: Icons.settings_outlined,
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}
