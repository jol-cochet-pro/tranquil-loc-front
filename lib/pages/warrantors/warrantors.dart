import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/warrantors/components/warrantor-card.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:dossier_locataire/shared/scroll-controller.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Warrantors extends StatefulWidget {
  const Warrantors({super.key});

  static const route = '/warrantors';

  @override
  State<Warrantors> createState() => _WarrantorsState();
}

class _WarrantorsState extends State<Warrantors> {
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
          toFirestore: (warrantor, _) => Warrantor.toFirestore(warrantor),
        )
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
    super.initState();
  }

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
                Text(locale.warrantors, style: h1),
                CustomButton(
                  onPressed: () {
                    print("add warrantor.");
                  },
                  type: ButtonType.primary,
                  padding: EdgeInsets.all(16),
                  child: Text(locale.add_warrantor),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: warrantors,
              builder:
                  (context, snapshot) =>
                      snapshot.hasData
                          ? snapshot.data!.isNotEmpty
                              ? ScrollConfiguration(
                                behavior: DragScrollBehavior(),
                                child: ListView.separated(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (context, index) => WarrantorCard(
                                        warrantor: snapshot.data![index],
                                      ),
                                  separatorBuilder:
                                      (context, index) => SizedBox(width: 24),
                                ),
                              )
                              : Center(
                                child: ShadowContainer(
                                  radius: Radius.circular(10),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          "assets/empty_list.png",
                                        ),
                                      ),
                                      Text(
                                        locale.no_warrantors_saved,
                                        style: p1,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          : Loader(),
            ),
          ),
        ],
      ),
    );
  }
}
