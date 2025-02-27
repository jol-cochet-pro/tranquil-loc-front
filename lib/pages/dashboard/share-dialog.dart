import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/dropdown.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/components/text-field.dart';
import 'package:dossier_locataire/pages/dashboard/components/share-perm-cell.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:dossier_locataire/shared/validator.dart';
import 'package:flutter/material.dart';

enum ShareDurationPeriod {
  day("jours"),
  month("mois"),
  year("années");

  const ShareDurationPeriod(this.value);
  final String value;
}

enum SharePermission { write, readFile, readInfo, none }

class ShareCreation {
  String description;
  String email;
  int durationNum;
  ShareDurationPeriod durationPeriod;
  SharePermission warrantorPermission;
  SharePermission occupantPermission;

  ShareCreation({
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
    required this.warrantorPermission,
    required this.occupantPermission,
  });
}

class ShareDialog extends StatefulWidget {
  const ShareDialog({super.key});

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ShareCreation shareCreation = ShareCreation(
    description: "",
    email: "",
    durationNum: -1,
    durationPeriod: ShareDurationPeriod.day,
    occupantPermission: SharePermission.none,
    warrantorPermission: SharePermission.none,
  );
  String permissionError = "";

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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
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
                  Row(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          onSaved: (newValue) {
                            if (newValue == null || newValue == "") {
                              shareCreation.durationNum = -1;
                            } else {
                              shareCreation.durationNum = int.parse(newValue);
                            }
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return "La durée doit ne peut pas être vide.";
                            }
                            if (int.tryParse(value) == null) {
                              return "La durée doit être un nombre.";
                            }
                            if (int.parse(value) > 150) {
                              return "La durée doit être inférieure ou égale à 150.";
                            }
                            if (int.parse(value) < 1) {
                              return "La durée doit être supérieur ou égale à 1.";
                            }
                            return null;
                          },
                          label: "Durée du partage",
                          hint: "3",
                          isRequired: false,
                          type: TextFieldType.number,
                        ),
                      ),
                      Flexible(
                        child: CustomDropDown(
                          defaultValue: ShareDurationPeriod.day,
                          onSelected:
                              (value) => {
                                shareCreation.durationPeriod = value!,
                              },
                          items:
                              ShareDurationPeriod.values.map((el) {
                                return DropdownMenuEntry(
                                  value: el,
                                  label: el.value,
                                );
                              }).toList(),
                          isRequired: false,
                        ),
                      ),
                    ],
                  ),
                  Text("Permissions: ", style: h3),
                  ShadowContainer(
                    padding: EdgeInsets.all(10),
                    radius: Radius.circular(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 100, child: Text("Garants", style: h3)),
                        SharePermCell(
                          label: "Lecture infos",
                          permission: SharePermission.readInfo,
                          value: shareCreation.warrantorPermission,
                          onChange: (newValue) {
                            setState(() {
                              shareCreation.warrantorPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: "Lecture fichiers",
                          permission: SharePermission.readFile,
                          value: shareCreation.warrantorPermission,
                          onChange: (newValue) {
                            setState(() {
                              shareCreation.warrantorPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: "Écriture",
                          permission: SharePermission.write,
                          value: shareCreation.warrantorPermission,
                          onChange: (newValue) {
                            setState(() {
                              shareCreation.warrantorPermission = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ShadowContainer(
                    padding: EdgeInsets.all(10),
                    radius: Radius.circular(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text("Occupants", style: h3),
                        ),
                        SharePermCell(
                          label: "Lecture infos",
                          permission: SharePermission.readInfo,
                          value: shareCreation.occupantPermission,
                          onChange: (newValue) {
                            setState(() {
                              shareCreation.occupantPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: "Lecture fichiers",
                          permission: SharePermission.readFile,
                          value: shareCreation.occupantPermission,
                          onChange: (newValue) {
                            setState(() {
                              shareCreation.occupantPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: "Écriture",
                          permission: SharePermission.write,
                          value: shareCreation.occupantPermission,
                          onChange: (newValue) {
                            setState(() {
                              shareCreation.occupantPermission = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    permissionError,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        type: ButtonType.secondary,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(16),
                        child: Text("Annulé"),
                      ),
                      CustomButton(
                        type: ButtonType.primary,
                        onPressed: () {
                          setState(() {
                            permissionError = "";
                          });
                          if (shareCreation.warrantorPermission ==
                                  SharePermission.none &&
                              shareCreation.occupantPermission ==
                                  SharePermission.none) {
                            setState(() {
                              permissionError =
                                  "Vous devez avoir au moins une permission pour partager votre dossier.";
                            });
                            formKey.currentState!.validate();
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            print("information sent.");
                          }
                        },
                        padding: EdgeInsets.all(16),
                        child: Text("Partager mon dossier"),
                      ),
                    ],
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
