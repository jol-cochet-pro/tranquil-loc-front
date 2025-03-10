import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-state-cell.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OccupantsCard extends StatelessWidget {
  final Future<List<Occupant>> occupants = Future.delayed(
    Duration(seconds: 2),
    () => [],
  );

  OccupantsCard({super.key});

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
            onAdd: () {
              print("add occupant.");
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
                            "id of the occupant: ${snapshot.data![index].id}",
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
