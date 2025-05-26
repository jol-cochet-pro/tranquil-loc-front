import 'package:tranquil_loc/api/file_api.dart';
import 'package:tranquil_loc/api/warrantor_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/warrantors/components/documents_info_form.dart';
import 'package:tranquil_loc/pages/warrantors/components/personal_infos_form.dart';
import 'package:tranquil_loc/pages/warrantors/warrantors.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/warrantor.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AddWarrantor extends StatefulWidget {
  const AddWarrantor({super.key});

  static const route = "/warrantors/add";

  @override
  State<AddWarrantor> createState() => _AddWarrantorState();
}

class _AddWarrantorState extends State<AddWarrantor> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, List<PlatformFile>> documents = ProSituation.OTHER.documents;
  final Warrantor warrantor = Warrantor.empty;
  bool isLoading = false;

  void submit(AppLocalizations locale) async {
    try {
      setState(() => isLoading = true);
      Warrantor newWarrantor = await WarrantorApi.add(warrantor);
      for (final document in documents.entries) {
        warrantor.documents[document.key] = await FileApi.add(
          document.toPair(),
          "warrantors/${newWarrantor.id}",
        );
      }
      await WarrantorApi.update(newWarrantor.id, warrantor);
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
                Text(locale.add_warrantor, style: h2),
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
                    : Loader(),
              ],
            ),
          ),
          Flexible(
            child: Form(
              key: formKey,
              child: Row(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PersonalInfoForm(
                      warrantor: warrantor,
                      onSituationUpdate:
                          (situation) =>
                              setState(() => documents = situation.documents),
                    ),
                  ),
                  Expanded(
                    child: DocumentsInfoForm(
                      warrantor: warrantor,
                      newDocuments: documents,
                      rmDocuments: {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
