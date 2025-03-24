import 'package:dossier_locataire/api/file_api.dart';
import 'package:dossier_locataire/api/occupant_api.dart';
import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/occupants/components/documents_info_form.dart';
import 'package:dossier_locataire/pages/occupants/components/personal_infos_form.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/file.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class UpdateOccupant extends StatefulWidget {
  final String occupantId;

  const UpdateOccupant({super.key, required this.occupantId});

  static const route = "/occupants/update/:id";
  static String routeId(String id) => "/occupants/update/$id";

  @override
  State<UpdateOccupant> createState() => _UpdateOccupantState();
}

class _UpdateOccupantState extends State<UpdateOccupant> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, List<PlatformFile>> newDocuments = ProSituation.other.documents;
  final Map<String, List<File>> rmDocuments = {};
  late Future<Occupant?> occupant;

  @override
  void initState() {
    occupant = OccupantApi.get(widget.occupantId);
    super.initState();
  }

  void submit(AppLocalizations locale) async {
    Occupant? loadedOccupant = await occupant;
    if (loadedOccupant == null) return;
    try {
      for (final document in rmDocuments.entries) {
        loadedOccupant.documents[document.key]!.removeWhere(
          (wfile) => document.value.map((file) => file.url).contains(wfile.url),
        );
        await FileApi.remove(document.toPair());
      }
      ListResult oldDocuments = await FileApi.getAll(
        "occupants/${widget.occupantId}",
      );
      for (final document in newDocuments.entries) {
        int startIndex =
            oldDocuments.items
                .where((item) => item.name.startsWith(document.key))
                .length;
        loadedOccupant.documents.createAddAll(
          document.key,
          await FileApi.add(
            document.toPair(),
            "occupants/${widget.occupantId}",
            startIndex,
          ),
        );
      }
      await OccupantApi.update(widget.occupantId, loadedOccupant);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Occupants.route);
      });
    } catch (error) {
      // TODO ADD THIS
    }
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
                Text(locale.update_future_occupant, style: h1),
                Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      onPressed: () => context.go(Occupants.route),
                      type: ButtonType.secondary,
                      padding: EdgeInsets.all(16),
                      child: Text(locale.canceled),
                    ),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          submit(locale);
                        }
                      },
                      type: ButtonType.success,
                      padding: EdgeInsets.all(16),
                      child: Text(locale.save),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: occupant,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  newDocuments = snapshot.data!.proSituation.documents;
                }
                return Form(
                  key: formKey,
                  child:
                      snapshot.hasData
                          ? Row(
                            spacing: 24,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: PersonalInfoForm(
                                  occupant: snapshot.data!,
                                  onSituationUpdate:
                                      (situation) => setState(
                                        () =>
                                            newDocuments = situation.documents,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: DocumentsInfoForm(
                                  occupant: snapshot.data!,
                                  newDocuments: newDocuments,
                                  rmDocuments: rmDocuments,
                                ),
                              ),
                            ],
                          )
                          : Loader(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
