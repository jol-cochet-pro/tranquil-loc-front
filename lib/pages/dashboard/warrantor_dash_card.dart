import 'package:tranquil_loc/api/warrantor_api.dart';
import 'package:tranquil_loc/components/icon_button.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/pages/dashboard/components/dash_card.dart';
import 'package:tranquil_loc/pages/dashboard/components/dash_state_cell.dart';
import 'package:tranquil_loc/pages/warrantors/add_warrantor.dart';
import 'package:tranquil_loc/pages/warrantors/update_warrantor.dart';
import 'package:tranquil_loc/shared/models/warrantor.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

class WarrantorsCard extends StatefulWidget {
  const WarrantorsCard({super.key});

  @override
  State<WarrantorsCard> createState() => _WarrantorsCardState();
}

class _WarrantorsCardState extends State<WarrantorsCard> {
  late Future<List<Warrantor>> warrantors;

  @override
  void initState() {
    warrantors = WarrantorApi.getAll();
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
            onAdd: () => context.go(AddWarrantor.route),
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
                              style: p3,
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
                              UpdateWarrantor.routeId(snapshot.data![index].id),
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
