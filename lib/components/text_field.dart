import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

enum TextFieldType { text, number, password, phone, currency }

class CustomTextField extends StatefulWidget {
  final TextFieldType type;
  final void Function(String?)? onChanged;
  final String? label;
  final String hint;
  final String? helpLabel;
  final GestureTapCallback? onHelpTap;
  final bool isRequired;
  final String? errorText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.isRequired,
    required this.type,
    this.label,
    this.validator,
    this.helpLabel,
    this.onHelpTap,
    this.onChanged,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final InputDecoration decoration = InputDecoration(
      hintText: widget.hint,
      errorText:
          widget.errorText != null && widget.errorText!.isNotEmpty
              ? widget.errorText
              : null,
      suffixText: widget.type == TextFieldType.currency ? " € / mois" : "",
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
            if (widget.label != null) Text(widget.label!, style: p1),
            if (widget.isRequired)
              Text(
                "*",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
        Stack(
          children: [
            widget.type == TextFieldType.phone
                ? IntlPhoneField(
                  decoration: decoration,
                  languageCode: "en",
                  onChanged: (phone) {
                    widget.onChanged!(phone.completeNumber);
                  },
                )
                : TextFormField(
                  obscureText:
                      widget.type == TextFieldType.password && !showPassword,
                  enableSuggestions:
                      widget.type == TextFieldType.password && !showPassword,
                  autocorrect:
                      widget.type == TextFieldType.password && !showPassword,
                  inputFormatters:
                      widget.type == TextFieldType.number
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [],
                  decoration: decoration,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                ),
            if (widget.type == TextFieldType.password)
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child:
                      showPassword
                          ? Icon(
                            Icons.visibility_off,
                            color: colorScheme.onSurfaceVariant,
                          )
                          : Icon(
                            Icons.visibility,
                            color: colorScheme.onSurfaceVariant,
                          ),
                ),
              ),
          ],
        ),
        if (widget.helpLabel != null)
          GestureDetector(
            onTap: widget.onHelpTap != null ? widget.onHelpTap! : () {},
            child: Text(
              widget.helpLabel!,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
      ],
    );
  }
}
