import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends StatefulWidget {
  final void Function(String?) onChanged;
  final String? initialValue;
  final String? label;
  final bool isRequired;
  final String? errorText;
  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    required this.isRequired,
    this.initialValue,
    this.label,
    this.validator,
    required this.onChanged,
    this.errorText,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  Widget build(BuildContext context) {
    final PhoneNumber? phoneNumber =
        widget.initialValue != null && widget.initialValue!.isNotEmpty
            ? PhoneNumber.fromCompleteNumber(
              completeNumber: widget.initialValue!,
            )
            : null;
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final InputDecoration decoration = InputDecoration(
      errorText:
          widget.errorText != null && widget.errorText!.isNotEmpty
              ? widget.errorText
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
            if (widget.label != null) Text(widget.label!, style: p2),
            if (widget.isRequired)
              Text(
                "*",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
        IntlPhoneField(
          initialValue: phoneNumber?.completeNumber,
          decoration: decoration,
          onChanged: (newValue) => widget.onChanged(newValue.completeNumber),
          initialCountryCode: phoneNumber?.countryISOCode ?? "FR",
          invalidNumberMessage: locale.invalid_phone_number,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
