import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { text, number, password }

class CustomTextField extends StatefulWidget {
  final void Function(String?) onSaved;
  final String? label;
  final String hint;
  final String? helpLabel;
  final GestureTapCallback? onHelpTap;
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
    this.helpLabel,
    this.onHelpTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Row(
          children: [
            widget.label != null
                ? Text(widget.label!, style: p1)
                : SizedBox.shrink(),
            widget.isRequired
                ? Text(
                  "*",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
        Stack(
          children: [
            TextFormField(
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
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: Color(0xFFCBD5E1)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCBD5E1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
              validator: widget.validator,
              onSaved: widget.onSaved,
            ),
            widget.type == TextFieldType.password
                ? Positioned.fill(
                  right: 12,
                  child: Align(
                    alignment: Alignment.centerRight,
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
                                color: Color(0xFFCBD5E1),
                              )
                              : Icon(
                                Icons.visibility,
                                color: Color(0xFFCBD5E1),
                              ),
                    ),
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
        widget.helpLabel != null
            ? GestureDetector(
              onTap: widget.onHelpTap != null ? widget.onHelpTap! : () {},
              child: Text(
                widget.helpLabel!,
                style: TextStyle(color: Color(0xFF0B74E7)),
              ),
            )
            : SizedBox.shrink(),
      ],
    );
  }
}
