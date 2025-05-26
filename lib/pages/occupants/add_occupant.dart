import 'package:tranquil_loc/api/file_api.dart';
import 'package:tranquil_loc/api/occupant_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/occupants/components/documents_info_form.dart';
import 'package:tranquil_loc/pages/occupants/components/personal_infos_form.dart';
import 'package:tranquil_loc/pages/occupants/occupants.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/occupant.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AddOccupant extends StatefulWidget {
  const AddOccupant({super.key});

  static const route = "/occupants/add";

  @override
  State<AddOccupant> createState() => _AddOccupantState();
}

class _AddOccupantState extends State<AddOccupant> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, List<PlatformFile>> documents = ProSituation.OTHER.documents;
  final Occupant occupant = Occupant.empty;
  bool isLoading = false;

  void submit(AppLocalizations locale) async {
    try {
      setState(() => isLoading = true);
      Occupant newOccupant = await OccupantApi.add(occupant);
      for (final document in documents.entries) {
        occupant.documents[document.key] = await FileApi.add(
          document.toPair(),
          "occupants/${newOccupant.id}",
        );
      }
      await OccupantApi.update(newOccupant.id, occupant);
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
                Text(locale.add_future_occupant, style: h2),
                !isLoading
                    ? Row(
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
                      occupant: occupant,
                      onSituationUpdate:
                          (situation) =>
                              setState(() => documents = situation.documents),
                    ),
                  ),
                  Expanded(
                    child: DocumentsInfoForm(
                      occupant: occupant,
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
