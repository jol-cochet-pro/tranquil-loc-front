import 'package:dossier_locataire/components/date_field.dart';
import 'package:dossier_locataire/components/dropdown.dart';
import 'package:dossier_locataire/components/phone_field.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/components/text_field.dart';
import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';

class PersonalInfoForm extends StatefulWidget {
  final Occupant occupant;
  final void Function(ProSituation) onSituationUpdate;

  const PersonalInfoForm({
    super.key,
    required this.occupant,
    required this.onSituationUpdate,
  });

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return ShadowContainer(
      padding: EdgeInsets.all(20),
      radius: Radius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${locale.personal_infos}:", style: h3),
          Row(
            spacing: 24,
            children: [
              Flexible(
                child: CustomTextField(
                  initialValue: widget.occupant.firstname,
                  label: locale.firstname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locale.cant_be_empty(locale.the_firstname);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => widget.occupant.firstname = newValue!),
                  hint: locale.firstname_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                ),
              ),
              Flexible(
                child: CustomTextField(
                  initialValue: widget.occupant.lastname,
                  label: locale.lastname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locale.cant_be_empty(locale.the_lastname);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => widget.occupant.lastname = newValue!),
                  hint: locale.lastname_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                ),
              ),
            ],
          ),
          CustomDateField(
            initialValue: widget.occupant.dateOfBirth,
            label: locale.date_of_birth,
            onChanged:
                (newValue) =>
                    setState(() => widget.occupant.dateOfBirth = newValue),
            isRequired: true,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Flexible(
                child: CustomTextField(
                  initialValue: widget.occupant.email,
                  label: locale.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locale.cant_be_empty(locale.the_email);
                    }
                    if (!value.isEmail()) {
                      return locale.must_be_well_formatted(locale.the_email);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => widget.occupant.email = newValue!),
                  hint: locale.email_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                ),
              ),
              Flexible(
                child: CustomPhoneField(
                  initialValue: PhoneNumber.fromCompleteNumber(
                    completeNumber: widget.occupant.phone,
                  ),
                  label: locale.phone,
                  validator: (value) {
                    if (value != null && !value.isValidNumber()) {
                      return locale.invalid_phone_number;
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) => setState(
                        () => widget.occupant.phone = newValue.completeNumber,
                      ),
                  isRequired: false,
                ),
              ),
            ],
          ),
          Text("${locale.situation}:", style: h3),
          CustomDropDown(
            label: locale.home_situation,
            initialValue: widget.occupant.homeSituation,
            onSelected:
                (value) =>
                    setState(() => widget.occupant.homeSituation = value!),
            items:
                HomeSituation.values.map((el) {
                  return DropdownMenuEntry(value: el, label: el.locale(locale));
                }).toList(),
            isRequired: true,
          ),
          CustomDropDown(
            label: locale.pro_situation,
            initialValue: widget.occupant.proSituation,
            onSelected: (value) {
              widget.onSituationUpdate(value!);
              setState(() => widget.occupant.proSituation = value);
            },
            items:
                ProSituation.values.map((el) {
                  return DropdownMenuEntry(value: el, label: el.locale(locale));
                }).toList(),
            isRequired: true,
          ),
          CustomTextField(
            initialValue: widget.occupant.income.toString(),
            label: locale.monthly_income,
            validator: (value) {
              if (value == null || value == "") {
                return locale.cant_be_empty(locale.the_monthly_income);
              }
              if (int.tryParse(value) == null) {
                return locale.must_be_a_number(locale.the_monthly_income);
              }
              if (int.parse(value) < 0) {
                return locale.must_be_superior_or_equal_than(
                  0,
                  locale.the_monthly_income,
                );
              }
              return null;
            },
            onChanged:
                (newValue) => setState(
                  () => widget.occupant.income = int.parse(newValue!),
                ),
            hint: "1000",
            isRequired: true,
            type: TextFieldType.currency,
          ),
        ],
      ),
    );
  }
}
