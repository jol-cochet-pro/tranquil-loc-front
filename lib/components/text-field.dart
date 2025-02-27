import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { text, number }

class CustomTextField extends StatelessWidget {
  final void Function(String?) onSaved;
  final String? label;
  final String hint;
  final bool isRequired;
  final TextFieldType type;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.onSaved,
    required this.hint,
    required this.isRequired,
    required this.type,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          children: [
            label != null ? Text(label!, style: p1) : SizedBox.shrink(),
            isRequired
                ? Text(
                  "*",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
        TextFormField(
          inputFormatters:
              type == TextFieldType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Color(0xFFCBD5E1)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(143, 203, 213, 225)),
            ),
          ),
          validator: validator,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
