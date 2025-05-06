import 'package:dossier_locataire/components/date_field.dart';
import 'package:dossier_locataire/components/dropdown.dart';
import 'package:dossier_locataire/components/phone_field.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/components/text_field.dart';
import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';

class PersonalInfoForm extends StatefulWidget {
  final Warrantor warrantor;
  final void Function(ProSituation) onSituationUpdate;

  const PersonalInfoForm({
    super.key,
    required this.warrantor,
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
                  initialValue: widget.warrantor.firstname,
                  label: locale.firstname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locale.cant_be_empty(locale.the_firstname);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => widget.warrantor.firstname = newValue!),
                  hint: locale.firstname_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                ),
              ),
              Flexible(
                child: CustomTextField(
                  initialValue: widget.warrantor.lastname,
                  label: locale.lastname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locale.cant_be_empty(locale.the_lastname);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => widget.warrantor.lastname = newValue!),
                  hint: locale.lastname_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                ),
              ),
            ],
          ),
          CustomDateField(
            initialValue: widget.warrantor.dateOfBirth,
            label: locale.date_of_birth,
            onChanged:
                (newValue) =>
                    setState(() => widget.warrantor.dateOfBirth = newValue),
            isRequired: true,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Flexible(
                child: CustomTextField(
                  initialValue: widget.warrantor.email,
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
                          setState(() => widget.warrantor.email = newValue!),
                  hint: locale.email_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                ),
              ),
              Flexible(
                child: CustomPhoneField(
                  initialValue: widget.warrantor.phone,
                  label: locale.phone,
                  validator: (value) {
                    if (value != null &&
                        !PhoneNumber.fromCompleteNumber(
                          completeNumber: value,
                        ).isValidNumber()) {
                      return locale.invalid_phone_number;
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => widget.warrantor.phone = newValue!),
                  isRequired: false,
                ),
              ),
            ],
          ),
          Text("${locale.situation}:", style: h3),
          CustomDropDown(
            label: locale.home_situation,
            initialValue: widget.warrantor.homeSituation,
            onSelected:
                (value) =>
                    setState(() => widget.warrantor.homeSituation = value!),
            items:
                HomeSituation.values.map((el) {
                  return DropdownMenuEntry(value: el, label: el.locale(locale));
                }).toList(),
            isRequired: true,
          ),
          CustomDropDown(
            label: locale.pro_situation,
            initialValue: widget.warrantor.proSituation,
            onSelected: (value) {
              widget.onSituationUpdate(value!);
              setState(() => widget.warrantor.proSituation = value);
            },
            items:
                ProSituation.values.map((el) {
                  return DropdownMenuEntry(value: el, label: el.locale(locale));
                }).toList(),
            isRequired: true,
          ),
          CustomTextField(
            initialValue: widget.warrantor.income.toString(),
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
                  () => widget.warrantor.income = int.parse(newValue!),
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
