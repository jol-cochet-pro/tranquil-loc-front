import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends FormField<PhoneNumber> {
  final String? label;
  final bool isRequired;
  final String? errorText;
  final void Function(PhoneNumber) onChanged;

  CustomPhoneField({
    super.key,
    super.initialValue,
    required this.label,
    required this.isRequired,
    this.errorText,
    required this.onChanged,
    required super.validator,
  }) : super(
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (field) {
           final AppLocalizations locale = AppLocalizations.of(field.context)!;
           final ColorScheme colorScheme = Theme.of(field.context).colorScheme;
           final InputDecoration decoration = InputDecoration(
             errorText:
                 field.errorText != null && field.errorText!.isNotEmpty
                     ? field.errorText
                     : null,
             hintText: "630303030",
             enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(color: colorScheme.outline),
             ),
             focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(color: colorScheme.primary),
             ),
             errorBorder: OutlineInputBorder(
               borderSide: BorderSide(color: colorScheme.error),
             ),
             focusedErrorBorder: OutlineInputBorder(
               borderSide: BorderSide(color: colorScheme.error),
             ),
             errorMaxLines: 100,
           );
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             spacing: 4,
             children: [
               Row(
                 spacing: 4,
                 children: [
                   if (label != null) Text(label, style: p2),
                   if (isRequired)
                     Text(
                       "*",
                       style: TextStyle(
                         color: Theme.of(field.context).colorScheme.error,
                       ),
                     ),
                 ],
               ),
               IntlPhoneField(
                 autovalidateMode: AutovalidateMode.disabled,
                 initialValue: field.value?.number,
                 decoration: decoration,
                 onChanged: (newValue) {
                   field.didChange(newValue);
                   onChanged(newValue);
                 },
                 initialCountryCode: field.value?.countryISOCode ?? "FR",
                 invalidNumberMessage: locale.invalid_phone_number,
                 keyboardType: TextInputType.phone,
               ),
             ],
           );
         },
       );
}
