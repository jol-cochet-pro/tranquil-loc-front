import 'package:dossier_locataire/api/share_api.dart';
import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/dropdown.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/components/text_field.dart';
import 'package:dossier_locataire/pages/dashboard/components/share_perm_cell.dart';
import 'package:dossier_locataire/shared/enums/share_duration_period.dart';
import 'package:dossier_locataire/shared/enums/share_permission.dart';
import 'package:dossier_locataire/shared/models/share.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/types/form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ShareDialog extends StatefulWidget {
  const ShareDialog({super.key});

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Share share = Share(
    id: "",
    description: "",
    email: "",
    durationNum: -1,
    durationPeriod: ShareDurationPeriod.day,
    occupantPermission: SharePermission.none,
    warrantorPermission: SharePermission.none,
  );
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    if (share.warrantorPermission == SharePermission.none &&
        share.occupantPermission == SharePermission.none) {
      setState(() {
        errors["permissions"] = locale.must_have_at_least_one_perm;
      });
      return;
    }
    try {
      await ShareApi.add(share);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.pop();
      });
    } catch (error) {
      // TODO ADD THIS
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
                Text(locale.share, style: h2),
                Text(locale.share_dialog_description, style: p2),
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  CustomTextField(
                    onChanged: (newValue) {
                      share.description = newValue!;
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return locale.cant_be_empty(locale.the_description);
                      }
                      return null;
                    },
                    label: locale.description,
                    hint: locale.description_hint,
                    isRequired: true,
                    type: TextFieldType.text,
                  ),
                  CustomTextField(
                    onChanged: (newValue) {
                      share.email = newValue!;
                    },
                    label: locale.email,
                    hint: locale.email_hint,
                    validator: (value) {
                      if (value == null || value == "") {
                        return locale.cant_be_empty(locale.the_email);
                      }
                      if (!value.isEmail()) {
                        return locale.must_be_well_formatted(locale.the_email);
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
                          onChanged: (newValue) {
                            if (newValue == null || newValue == "") {
                              share.durationNum = -1;
                            } else {
                              share.durationNum = int.parse(newValue);
                            }
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return locale.cant_be_empty(locale.the_duration);
                            }
                            if (int.tryParse(value) == null) {
                              return locale.must_be_a_number(
                                locale.the_duration,
                              );
                            }
                            if (int.parse(value) > 150) {
                              return locale.must_be_inferior_or_equal_than(
                                150,
                                locale.the_duration,
                              );
                            }
                            if (int.parse(value) < 1) {
                              return locale.must_be_superior_or_equal_than(
                                1,
                                locale.the_duration,
                              );
                            }
                            return null;
                          },
                          label: locale.duration_of_share,
                          hint: "3",
                          isRequired: false,
                          type: TextFieldType.number,
                        ),
                      ),
                      Flexible(
                        child: CustomDropDown(
                          initialValue: ShareDurationPeriod.day,
                          onSelected:
                              (value) =>
                                  setState(() => share.durationPeriod = value!),
                          items:
                              ShareDurationPeriod.values.map((el) {
                                return DropdownMenuEntry(
                                  value: el,
                                  label: el.locale(locale),
                                );
                              }).toList(),
                          isRequired: false,
                        ),
                      ),
                    ],
                  ),
                  Text("${locale.permissions}: ", style: h4),
                  ShadowContainer(
                    padding: EdgeInsets.all(10),
                    radius: Radius.circular(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(locale.warrantors, style: h4),
                        ),
                        SharePermCell(
                          label: locale.read_infos,
                          permission: SharePermission.readInfo,
                          value: share.warrantorPermission,
                          onChange: (newValue) {
                            setState(() {
                              share.warrantorPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: locale.read_files,
                          permission: SharePermission.readFile,
                          value: share.warrantorPermission,
                          onChange: (newValue) {
                            setState(() {
                              share.warrantorPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: locale.write,
                          permission: SharePermission.write,
                          value: share.warrantorPermission,
                          onChange: (newValue) {
                            setState(() {
                              share.warrantorPermission = newValue;
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
                          child: Text(locale.occupants, style: h4),
                        ),
                        SharePermCell(
                          label: locale.read_infos,
                          permission: SharePermission.readInfo,
                          value: share.occupantPermission,
                          onChange: (newValue) {
                            setState(() {
                              share.occupantPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: locale.read_files,
                          permission: SharePermission.readFile,
                          value: share.occupantPermission,
                          onChange: (newValue) {
                            setState(() {
                              share.occupantPermission = newValue;
                            });
                          },
                        ),
                        SharePermCell(
                          label: locale.write,
                          permission: SharePermission.write,
                          value: share.occupantPermission,
                          onChange: (newValue) {
                            setState(() {
                              share.occupantPermission = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  if (errors["permissions"] != null)
                    Text(
                      errors["permissions"]!,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        type: ButtonType.secondary,
                        onPressed: () => context.pop(),
                        padding: EdgeInsets.all(16),
                        child: Text(locale.canceled),
                      ),
                      CustomButton(
                        type: ButtonType.primary,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            submit(locale);
                          }
                        },
                        padding: EdgeInsets.all(16),
                        child: Text(locale.share_my_folder),
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
