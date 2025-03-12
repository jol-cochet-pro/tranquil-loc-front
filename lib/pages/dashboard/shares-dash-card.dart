import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/shared/models/share.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharesCard extends StatefulWidget {
  const SharesCard({super.key});

  @override
  State<SharesCard> createState() => _SharesCardState();
}

class _SharesCardState extends State<SharesCard> {
  late Future<List<Share>> shares;

  @override
  void initState() {
    shares = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("shares")
        .withConverter(
          fromFirestore: (snapshot, _) => Share.fromFirestore(snapshot.data()),
          toFirestore: (occupant, _) => Share.toFirestore(occupant),
        )
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return FutureBuilder(
      future: shares,
      builder: (context, snapshot) {
        print(snapshot.error);
        return DashCard(
          title: locale.my_shares,
          emptyInfo: locale.no_shares_saved,
          onAdd: () {
            print("add shares.");
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
                    Text(
                      snapshot.data![index].description,
                      overflow: TextOverflow.ellipsis,
                      style: h3,
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        Icon(Icons.hourglass_empty_outlined),
                        Text(
                          snapshot.data![index].shareDurationToString(locale),
                          style: p2,
                        ),
                      ],
                    ),
                    Text(snapshot.data![index].email, style: p2),
                    CustomIconButton(
                      onPressed: () {
                        print(
                          "id of the share ${snapshot.data![index].description}",
                        );
                      },
                      icon: Icons.settings_outlined,
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }
}
