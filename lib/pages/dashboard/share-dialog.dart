import 'package:dossier_locataire/components/text-field.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:dossier_locataire/shared/validator.dart';
import 'package:flutter/material.dart';

enum ShareDurationPeriod { month, day, year }

class ShareCreation {
  String id;
  String description;
  String email;
  int durationNum;
  ShareDurationPeriod durationPeriod;

  ShareCreation({
    required this.id,
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
  });
}

class ShareDialog extends StatefulWidget {
  const ShareDialog({super.key});

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ShareCreation shareCreation;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(32),
        constraints: BoxConstraints(maxWidth: 600),
        child: Column(
          spacing: 32,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Partager", style: h1),
                Text(
                  "Ici vous pouvez ajouter des partages pour faire en sorteque votre dossier soit vu par d’autre personnes. (changer ce texte)",
                  style: p1,
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    onSaved: (newValue) {
                      shareCreation.description = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return "La description ne peut pas être vide.";
                      }
                      return null;
                    },
                    label: "Description",
                    hint: "Jean",
                    isRequired: true,
                    type: TextFieldType.text,
                  ),
                  CustomTextField(
                    onSaved: (newValue) {
                      shareCreation.email = newValue!;
                    },
                    label: "Email",
                    hint: "jean@dupont.fr",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "L'email ne peut pas être vide.";
                      }
                      if (!value.isEmail()) {
                        return "L'email doit être bien formatté.";
                      }
                      return null;
                    },
                    isRequired: true,
                    type: TextFieldType.text,
                  ),
                  Column(
                    children: [
                      Text("Durée du partage"),
                      Row(
                        children: [
                          CustomTextField(
                            onSaved: (newValue) {
                              if (newValue == null || newValue == "") {
                                shareCreation.durationNum = -1;
                              } else {
                                shareCreation.durationNum = int.parse(newValue);
                              }
                            },
                            validator: (value) {
                              if (value == null || value == "") {
                                return null;
                              }
                              if (int.tryParse(value) == null) {
                                return "La durée doit être un nombre";
                              }
                              return null;
                            },
                            hint: "3",
                            isRequired: false,
                            type: TextFieldType.number,
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("information sent.");
                      }
                    },
                    child: Text("Partager mon dossier"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
