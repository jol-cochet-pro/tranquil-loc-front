import 'package:dossier_locataire/api/occupant_api.dart';
import 'package:dossier_locataire/components/icon_button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash_card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash_state_cell.dart';
import 'package:dossier_locataire/pages/occupants/add_occupant.dart';
import 'package:dossier_locataire/pages/occupants/update_occupant.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OccupantsCard extends StatefulWidget {
  const OccupantsCard({super.key});

  @override
  State<OccupantsCard> createState() => _OccupantsCardState();
}

class _OccupantsCardState extends State<OccupantsCard> {
  late Future<List<Occupant>> occupants;

  @override
  void initState() {
    occupants = OccupantApi.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return FutureBuilder(
      future: occupants,
      builder:
          (context, snapshot) => DashCard(
            title: locale.future_occupants,
            emptyInfo: locale.no_future_occupants_saved,
            onAdd: () => context.go(AddOccupant.route),
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
                              style: h4,
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
                        onPressed:
                            () => context.go(
                              UpdateOccupant.routeId(snapshot.data![index].id),
                            ),
                        icon: Icons.settings_outlined,
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}
