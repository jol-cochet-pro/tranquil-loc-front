import 'package:date_format_field/date_format_field.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final DateTime? initialValue;
  final String? label;
  final bool isRequired;
  final String? errorText;

  const CustomDateField({
    super.key,
    required this.isRequired,
    required this.onChanged,
    this.initialValue,
    this.label,
    this.errorText,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd/MM/yyyy");
    if (widget.initialValue != null) {
      controller.text = formatter.format(widget.initialValue!);
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final InputDecoration decoration = InputDecoration(
      hintText: "01/01/1970",
      errorText:
          widget.errorText != null && widget.errorText!.isNotEmpty
              ? widget.errorText
              : null,
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
        Stack(
          children: [
            DateFormatField(
              initialDate: widget.initialValue,
              controller: controller,
              decoration: decoration,
              onComplete: (newValue) {
                if (newValue != null) widget.onChanged(newValue);
              },
              addCalendar: false,
              type: DateFormatType.type2,
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Icon(
                Icons.calendar_month_outlined,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
