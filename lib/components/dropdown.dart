import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<DropdownMenuEntry<T>> items;
  final T? initialValue;
  final String? label;
  final bool isRequired;
  final void Function(T?) onSelected;
  final String? Function(T?)? validator;

  const CustomDropDown({
    super.key,
    required this.items,

    required this.isRequired,
    required this.onSelected,
    required this.initialValue,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Row(
          children: [
            label != null ? Text(label!, style: p1) : SizedBox.shrink(),
            isRequired
                ? Text("*", style: TextStyle(color: colorScheme.error))
                : SizedBox.shrink(),
          ],
        ),
        DropdownMenu<T>(
          requestFocusOnTap: false,
          initialSelection: initialValue,
          dropdownMenuEntries: items,
          onSelected: onSelected,
          menuStyle: const MenuStyle(alignment: Alignment.bottomLeft),
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: InputDecorationTheme(
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
          ),
        ),
      ],
    );
  }
}
