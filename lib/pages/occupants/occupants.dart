import 'package:dossier_locataire/api/occupant_api.dart';
import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/occupants/add_occupant.dart';
import 'package:dossier_locataire/pages/occupants/components/occupant_card.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/scroll_controller.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class Occupants extends StatefulWidget {
  const Occupants({super.key});

  static const route = '/occupants';

  @override
  State<Occupants> createState() => _OccupantsState();
}

class _OccupantsState extends State<Occupants> {
  late Future<List<Occupant>> occupants;

  @override
  void initState() {
    occupants = OccupantApi.getAll();
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
                Text(locale.future_occupants, style: h2),
                CustomButton(
                  onPressed: () => context.go(AddOccupant.route),
                  type: ButtonType.primary,
                  padding: EdgeInsets.all(16),
                  child: Text(locale.add_future_occupant),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: occupants,
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
                                      (context, index) => OccupantCard(
                                        occupant: snapshot.data![index],
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
                                        locale.no_future_occupants_saved,
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
