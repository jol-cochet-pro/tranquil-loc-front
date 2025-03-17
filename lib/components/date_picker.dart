import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final void Function(DateTime) onChanged;
  final bool isRequired;
  final String? errorText;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.onChanged,
    this.errorText,
    required this.isRequired,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final DateFormat formatter = DateFormat("dd/MM/yyyy");
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Row(
          spacing: 4,
          children: [
            Text(widget.label, style: p1),
            if (widget.isRequired)
              Text(
                "*",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            date = await showDatePicker(
              context: context,
              firstDate: DateTime(0),
              lastDate: DateTime.now(),
            );
            if (date != null) widget.onChanged(date!);
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null ? formatter.format(date!) : locale.select_a_date,
                ),
                Icon(Icons.calendar_today, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Text(widget.errorText!, style: TextStyle(color: colorScheme.error)),
      ],
    );
  }
}
