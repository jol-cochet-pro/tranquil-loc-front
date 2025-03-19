import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/occupants/components/documents_info_form.dart';
import 'package:dossier_locataire/pages/occupants/components/personal_infos_form.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/shared/enums/document_type.dart';
import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/models/storage.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AddOccupant extends StatefulWidget {
  const AddOccupant({super.key});

  static const route = "/occupants/add";

  @override
  State<AddOccupant> createState() => _AddOccupantState();
}

class _AddOccupantState extends State<AddOccupant> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, List<PlatformFile>> files = {
    DocumentType.identityDocuments.str: [],
    DocumentType.proofOfAddress.str: [],
    DocumentType.areCertificate.str: [],
    DocumentType.schoolEnrollmentCertificate.str: [],
  };
  final Occupant occupant = Occupant(
    firstname: "",
    lastname: "",
    dateOfBirth: DateTime.now(),
    income: 0,
    proSituation: ProSituation.other,
    homeSituation: HomeSituation.tenant,
    email: "",
    phone: "",
    documents: {},
  );

  void submit(AppLocalizations locale) async {
    try {
      Reference storageRef = FirebaseStorage.instance.ref();
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      for (final entry in files.entries) {
        occupant.documents[entry.key] = [];
        for (var i = 0; i < entry.value.length; i++) {
          if (entry.value[i].bytes == null) {
            continue;
          }
          TaskSnapshot snapshot = await storageRef
              .child("$userUid/${entry.key}$i.${entry.value[i].extension}")
              .putData(entry.value[i].bytes!);
          occupant.documents[entry.key]!.add(snapshot.ref.fullPath);
        }
      }
      Storage.occupants.add(occupant);
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
                Text(locale.add_future_occupant, style: h1),
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
            child: Form(
              key: formKey,
              child: Row(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: PersonalInfoForm(occupant: occupant)),
                  Expanded(child: DocumentsInfoForm(occupant: occupant)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
