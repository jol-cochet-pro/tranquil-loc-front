import 'package:dossier_locataire/shared/enums/share_permission.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';

class SharePermCell extends StatelessWidget {
  final String label;
  final SharePermission permission;
  final SharePermission value;
  final void Function(SharePermission) onChange;

  const SharePermCell({
    super.key,
    required this.label,
    required this.value,
    required this.permission,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: p2),
        Switch(
          value: Enum.compareByIndex(permission, value) >= 0,
          onChanged: (newValue) {
            if (Enum.compareByIndex(permission, value) >= 0) {
              onChange(SharePermission.none);
            } else {
              onChange(permission);
            }
          },
        ),
      ],
    );
  }
}
