import 'package:tranquil_loc/api/file_api.dart';
import 'package:tranquil_loc/api/warrantor_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/person/documents_info_form.dart';
import 'package:tranquil_loc/components/person/personal_infos_form.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/warrantors/warrantors.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/file.dart';
import 'package:tranquil_loc/shared/models/warrantor.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class UpdateWarrantor extends StatefulWidget {
  final String warrantorId;

  const UpdateWarrantor({super.key, required this.warrantorId});

  static const route = "/warrantors/update/:id";
  static String routeId(String id) => "/warrantors/update/$id";

  @override
  State<UpdateWarrantor> createState() => _UpdateWarrantorState();
}

class _UpdateWarrantorState extends State<UpdateWarrantor> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, List<PlatformFile>> newDocuments = ProSituation.OTHER.documents;
  final Map<String, List<File>> rmDocuments = {};
  late Future<Warrantor?> warrantor;
  bool isLoading = false;

  @override
  void initState() {
    warrantor = WarrantorApi.get(widget.warrantorId);
    super.initState();
  }

  void submit(AppLocalizations locale) async {
    Warrantor? loadedWarrantor = await warrantor;
    if (loadedWarrantor == null) return;
    try {
      setState(() => isLoading = true);
      // Remove old documents that where removed
      for (final document in rmDocuments.entries) {
        await FileApi.remove(document.toPair());
        loadedWarrantor.documents[document.key]!.removeWhere(
          (wfile) => document.value.map((file) => file.url).contains(wfile.url),
        );
      }
      // Remove old documents with pro-situation
      for (final document in Map.of(loadedWarrantor.documents).entries) {
        if (!loadedWarrantor.proSituation.documents.containsKey(document.key)) {
          await FileApi.remove(document.toPair());
          loadedWarrantor.documents.remove(document.key);
        }
      }
      // Create new documents
      for (final document in newDocuments.entries) {
        List<File> uploadedFiles = await FileApi.add(
          document.toPair(),
          "warrantors/${widget.warrantorId}",
        );
        loadedWarrantor.documents.createAddAll(document.key, uploadedFiles);
      }
      await WarrantorApi.update(widget.warrantorId, loadedWarrantor);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Warrantors.route);
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
                Text(locale.update_warrantor, style: h2),
                !isLoading
                    ? Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          onPressed: () => context.go(Warrantors.route),
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
                    )
                    : Loader(showImediately: true),
              ],
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: warrantor,
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
                                  person: snapshot.data!,
                                  onSituationUpdate:
                                      (situation) => setState(
                                        () =>
                                            newDocuments = situation.documents,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: DocumentsInfoForm(
                                  person: snapshot.data!,
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
