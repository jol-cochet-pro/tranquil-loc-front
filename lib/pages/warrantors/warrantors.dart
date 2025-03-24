import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/warrantors/add_warrantor.dart';
import 'package:dossier_locataire/pages/warrantors/components/warrantor_card.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:dossier_locataire/shared/models/storage.dart';
import 'package:dossier_locataire/shared/scroll_controller.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

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
    warrantors = Storage.warrantors.get().then(
      (value) => value.docs.map((doc) => doc.data()).toList(),
    );
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
                  onPressed: () => context.go(AddWarrantor.route),
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
